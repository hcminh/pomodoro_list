import 'package:flutter/material.dart';
import '../../style.dart';

class CusAlertDialog extends StatelessWidget {
  final String _title;
  final TextEditingController _titleController;
  final TextEditingController _descriptionController;
  final Function _onPressButton;
  CusAlertDialog(this._title, this._titleController,
      this._descriptionController, this._onPressButton);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(_title),
      content: Container(
        height: 140,
        width: MediaQuery.of(context).size.width * 0.95,
        child: Column(
          children: <Widget>[
            TextField(
              autofocus: true,
              maxLength: 24,
              controller: _titleController,
              style: textFieldTitleTask,
              decoration: inputDecorationTitleTask,
            ),
            TextField(
              controller: _descriptionController,
              keyboardType: TextInputType.multiline,
              maxLength: 50,
              style: textFieldDescriptionTask,
              decoration: inputDecorationDescriptionTask,
            ),
          ],
        ),
      ),
      elevation: 24.0,
      actions: <Widget>[
        FlatButton(
          child: Text(
            'Save',
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
          onPressed: _onPressButton,
        ),
      ],
    );
  }
}
