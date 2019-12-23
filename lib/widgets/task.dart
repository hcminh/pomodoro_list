import 'package:flutter/material.dart';

class Task extends StatefulWidget {
  final String taskContent;
  bool completed;
  Task({Key key, this.taskContent, this.completed}) : super(key: key);

  @override
  _Task createState() => _Task();
}

class _Task extends State<Task> {
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      controlAffinity: ListTileControlAffinity.leading,
      activeColor: Colors.green,
      title: checkBoxText(widget.taskContent),
      value: widget.completed,
      onChanged: (bool value) {
        setState(() {
          widget.completed = !widget.completed;
        });
      },
    );
  }

  Text checkBoxText(String str)
  {
    if(widget.completed == true)
    {
      return Text(str, style: TextStyle(decoration: TextDecoration.lineThrough, fontStyle: FontStyle.italic, color: Colors.grey));
    }
    return Text(str, style: TextStyle(decoration: TextDecoration.none));
  }
}