import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/note.dart';
import '../controllers/notes/manager.dart';
import '../style.dart';

import 'widgets/customAppBar.dart';
import 'widgets/customDialogNote.dart';
import 'widgets/customNote.dart';

class NotePage extends StatefulWidget {
  NotePage({Key key}) : super(key: key);

  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  NoteManager noteManager = NoteManager();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey _itemKey = GlobalObjectKey("item");
  TextEditingController _contentController;
  CusNoteDialog noteAlertDialog;

  @override
  void initState() {
    super.initState();
    noteManager.loadAllNotes();
    _contentController = TextEditingController(text: '');
    noteAlertDialog =
        CusNoteDialog("Your new note", _contentController, _saveNoteAndClose);
  }

  void _saveNoteAndClose() async {
    String content = _contentController.text;

    if (content.trim().isEmpty) {
      return;
    }

    Note note = Note(0, content);
    if (note != null) {
      await NoteManager().addNewNote(note);
      await noteManager.loadAllNotes();
      setState(() {});
    }
    Navigator.pop(context);

    _contentController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      floatingActionButton: Container(
        width: 75.0,
        height: 75.0,
        child: RawMaterialButton(
          shape: CircleBorder(),
          fillColor: Colors.blue,
          elevation: 0.0,
          child: addTaskIcon,
          onPressed: () =>
              showDialog(context: context, builder: (_) => noteAlertDialog),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[CusAppBar('Notes')];
        },
        body: Container(
          child: StreamBuilder(
              stream: noteManager.notesData.asStream(),
              initialData: List<Note>(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Note>> snapshot) {
                var notes = snapshot.data.reversed;
                if (snapshot.connectionState != ConnectionState.done) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (notes != null && notes.length == 0) {
                  return Center(
                    child: Text(
                      'Let me take some note for you',
                      style: textDoneJob,
                    ),
                  );
                } else {
                  return GridView.count(
                      crossAxisCount: 2,
                      children: List.generate(notes.length, (index) {
                        return NoteWidget(
                          note: notes.elementAt(index),
                          onRemoved: () async {
                            await noteManager.loadAllNotes();
                            setState(() {});
                          },
                        );
                      }));
                }
              }),
        ),
      ),
    );
  }
}
