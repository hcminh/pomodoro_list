import 'package:flutter/material.dart';
import '../style.dart';

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
          widget.completed ? Icons.check_circle : Icons.check_circle_outline,
          color: widget.completed ? Colors.green : Colors.grey),
      title: checkBoxTextWidget(widget.taskContent),
      onTap: () {
        setState(() {
          widget.completed = !widget.completed;
        });
      },
    );
  }

  Widget checkBoxTextWidget(String str) {
    if (str == "") {
      return TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Enter a new task',
        ),
        // onSubmitted: ,
      );
    }
    if (widget.completed == true) {
      return Text(str, style: taskTitleCompleted);
    }
    return Text(str, style: TextStyle(decoration: TextDecoration.none));
  }
}
