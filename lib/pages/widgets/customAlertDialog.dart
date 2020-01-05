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
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Container(
        constraints:
            BoxConstraints(maxHeight: 260.0, minWidth: 150.0, minHeight: 200.0),
        width: MediaQuery.of(context).size.width,
        child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                MaterialButton(
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
