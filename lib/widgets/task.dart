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
    return ListTile(
      leading: Icon(
          widget.completed ? Icons.check_circle: Icons.check_circle_outline,
          color: widget.completed ? Colors.green : Colors.grey),
      title: checkBoxText(widget.taskContent),
      onTap: () {
        setState(() {
          widget.completed = !widget.completed;
        });
      },
    );
  }

  Text checkBoxText(String str) {
    if (widget.completed == true) {
      return Text(str,
          style: TextStyle(
              decoration: TextDecoration.lineThrough,
              fontStyle: FontStyle.italic,
              color: Colors.grey));
    }
    return Text(str, style: TextStyle(decoration: TextDecoration.none));
  }
}
