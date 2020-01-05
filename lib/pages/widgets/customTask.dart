import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../models/task.dart';
import '../../controllers/tasks/manager.dart';
import '../../style.dart';

class TaskWidget extends StatefulWidget {
  final Task task;
  final VoidCallback onRemoved;
  final VoidCallback onUpdated;
  final VoidCallback onTap;

  TaskWidget({Key key, this.task, this.onRemoved, this.onUpdated, this.onTap})
      : super(key: key);

  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    final task = widget.task;
    return Slidable(
      delegate: new SlidableDrawerDelegate(),
      actionExtentRatio: 0.25,
      child: Container(
        color: Colors.white,
        child: Material(
            child: Card(
                margin: const EdgeInsets.fromLTRB(4, 4, 4, 4),
                child: InkWell(
                    onTap: () {
                      widget.onTap();
                    },
                    child: Container(
                        // height: 50.0,
                        margin: const EdgeInsets.fromLTRB(16, 4, 16, 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Icon(
                              task.done
                                  ? Icons.check_circle
                                  : Icons.check_circle_outline,
                              color: task.done ? Colors.green : Colors.grey,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 5.0, top: 5.0, bottom: 5.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 5.0, top: 5.0),
                                    child: Text(
                                      task.title,
                                      style: taskTitle,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 5.0, top: 5.0, bottom: 5.0),
                                    child: Text(
                                      task.description,
                                      style: taskDescription,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ))))),
      ),
      actions: <Widget>[
        IconButton(
            icon: doneTaskIcon,
            onPressed: () async {
              Task nTask = task..done = true;
              await Manager().updateTask(nTask);
              widget.onUpdated();
            }),
      ],
      secondaryActions: <Widget>[
        IconButton(
            icon: removeTaskIcon,
            onPressed: () async {
              await Manager().removeTask(task);
              widget.onRemoved();
            }),
      ],
      closeOnScroll: true,
    );
  }
}