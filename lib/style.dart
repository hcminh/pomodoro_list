import 'package:flutter/material.dart';

const TextStyle appBarTitle = TextStyle(
  letterSpacing: 0.5,
  height: 1.5,
  color: Colors.black,
  fontSize: 23.0,
  fontWeight: FontWeight.w400,
);

const TextStyle jobTitle = TextStyle(
  fontSize: 18.0,
  letterSpacing: 0.6,
);

const TextStyle taskTitle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w400,
);

const TextStyle taskDescription = TextStyle(
  fontSize: 12,
  fontStyle: FontStyle.italic,
  fontWeight: FontWeight.w300,
);

const TextStyle textDoneJob = TextStyle(
    fontSize: 20, color: Colors.blueGrey, fontStyle: FontStyle.italic);

const TextStyle textTimerCouting =
    TextStyle(fontSize: 54.0, color: Colors.black, fontWeight: FontWeight.bold);

const TextStyle textFieldTitleTask = TextStyle(
  fontSize: 20.0,
  color: Colors.black,
);

const InputDecoration inputDecorationTitleTask = InputDecoration(
  hintText: 'Task title',
  filled: true,
  fillColor: Colors.white,
  contentPadding: EdgeInsets.only(left: 8, right: 8),
);

const TextStyle textFieldDescriptionTask = TextStyle(
  fontSize: 16.0,
  color: Colors.black,
);

const InputDecoration inputDecorationDescriptionTask = InputDecoration(
  hintText: 'Description',
  filled: true,
  fillColor: Colors.white,
  contentPadding: EdgeInsets.only(left: 8, right: 8),
);

//icon custom
const Icon addTaskIcon = Icon(
  Icons.add,
  size: 40.0,
  color: Colors.white,
);

const Icon doneTaskIcon = Icon(
  Icons.done_outline,
  size: 32.0,
  color: Colors.green,
);

const Icon removeTaskIcon = Icon(
  Icons.delete,
  size: 32.0,
  color: Colors.red,
);

const Icon backIcon = Icon(
  Icons.arrow_back,
  size: 32,
  color: Colors.grey,
);

const Icon finishIcon = Icon(
  Icons.check_circle_outline,
  size: 140.0,
  color: Colors.lightGreenAccent,
);
