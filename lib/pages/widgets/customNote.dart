import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/note.dart';
import '../../controllers/notes/manager.dart';

class NoteWidget extends StatefulWidget {
  final Note note;
  final VoidCallback onRemoved;
  final VoidCallback onUpdated;
  final VoidCallback onTap;

  NoteWidget({Key key, this.note, this.onRemoved, this.onUpdated, this.onTap})
      : super(key: key);

  _NoteWidgetState createState() => _NoteWidgetState();
}

class _NoteWidgetState extends State<NoteWidget> {
  @override
  Widget build(BuildContext context) {
    final note = widget.note;
    return GestureDetector(
        // onTap: ,
        onLongPress: () => showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: Text("Delete this note ?"),
                  actions: [
                    FlatButton(
                      padding: EdgeInsets.only(top: 10),
                      hoverColor: Colors.blueAccent,
                      child: Text(
                        'Delete',
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.w300,
                          fontSize: 22.0,
                        ),
                      ),
                      onPressed: () async {
                        await NoteManager().removeNote(note);
                        widget.onRemoved();
                        Navigator.pop(context);
                      },
                    )
                  ],
                )),
        child: Container(
            margin: EdgeInsets.all(7.0),
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              gradient: new LinearGradient(
                  colors: [Colors.white54, Colors.lightBlue[50]],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(0.0, 1.0),
                  tileMode: TileMode.clamp),
              boxShadow: [
                BoxShadow(
                    color: Colors.blueGrey[50],
                    offset: new Offset(0, 0),
                    blurRadius: 20.0,
                    spreadRadius: 5.0)
              ],
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.width / 2,
            child: Text(
              note.content,
              style: TextStyle(fontSize: 15.0),
            )));
  }
}
