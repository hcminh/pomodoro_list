import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../style.dart';

class CusAlertDialog extends StatelessWidget {
  final String _title;
  final TextEditingController _titleController;
  final TextEditingController _descriptionController;
  final Function _onPressButton;
  final FocusNode _titleFocus = FocusNode();
  final FocusNode _descriptionFocus = FocusNode();
  CusAlertDialog(this._title, this._titleController,
      this._descriptionController, this._onPressButton);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(_title, textAlign: TextAlign.center, style: TextStyle(fontSize: 24.0),),
      content: Container(
        height: 140,
        width: MediaQuery.of(context).size.width * 0.95,
        child: Column(
          children: <Widget>[
            TextField(
              textCapitalization: TextCapitalization.sentences,
              autofocus: true,
              maxLength: 24,
              controller: _titleController,
              style: textFieldTitleTask,
              decoration: inputDecorationTitleTask,
              textInputAction: TextInputAction.next,
              focusNode: _titleFocus,
              onEditingComplete: () {
                _titleFocus.unfocus();
                FocusScope.of(context).requestFocus(_descriptionFocus);
              },
            ),
            TextField(
              autofocus: true,
              textCapitalization: TextCapitalization.sentences,
              controller: _descriptionController,
              focusNode: _descriptionFocus,
              keyboardType: TextInputType.multiline,
              maxLines: 1,
              maxLength: 50,
              style: textFieldDescriptionTask,
              decoration: inputDecorationDescriptionTask,
            ),
          ],
        ),
      ),
      contentPadding: EdgeInsets.only(bottom: 0, right: 10.0, left: 10.0),
      titlePadding: EdgeInsets.only(bottom: 10.0, top: 10.0),
      elevation: 24.0,
      actions: <Widget>[
        FlatButton(
          padding: EdgeInsets.only(bottom: 10.0,right: 20.0, left: 20.0),
          hoverColor: Colors.blueAccent,
          child: Text(
            'Save',
            style: TextStyle(
              fontSize: 24.0,
            ),
          ),
          onPressed: _onPressButton,
        ),
      ],
    );
  }
}
