import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../style.dart';

class CusNoteDialog extends StatelessWidget {
  final String _title;
  final TextEditingController _titleController;
  final Function _onPressButton;
  CusNoteDialog(this._title, this._titleController, this._onPressButton);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Container(
        constraints: BoxConstraints(maxHeight: 300.0, minHeight: 200.0),
        width: MediaQuery.of(context).size.width + 20,
        child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Column(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      _title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.w500),
                    )),
                TextField(
                  textCapitalization: TextCapitalization.sentences,
                  autofocus: true,
                  maxLines: null,
                  controller: _titleController,
                  minLines: 6,
                  style: TextStyle(fontSize: 14.0),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Note content',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.all(10),
                  ),
                ),
                MaterialButton(
                  padding: EdgeInsets.only(top: 10),
                  minWidth: MediaQuery.of(context).size.width,
                  hoverColor: Colors.blueAccent,
                  child: Text(
                    'Save',
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 24.0,
                    ),
                  ),
                  onPressed: _onPressButton,
                ),
              ],
            )),
      ),
    );
  }
}
