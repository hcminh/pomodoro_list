// screens/home/home.dart

import 'package:flutter/material.dart';
import '../../style.dart';
import '../../task.dart';
import '../../collapse_task.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xFaFaFa).withOpacity(1.0),
        centerTitle: true,
        title: Text(
          'Daily Jobs',
          style: appBarTitle,
        ),
      ),
      body: Center(
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) =>
              JobWidget(data[index]),
          itemCount: data.length,
        ),
      ),
    );
  }
}

//fake data
// The entire multilevel list displayed by this app.
final List<Job> data = <Job>[
  Job(
    'Chapter A',
    <Task>[
      Task(taskContent: 'Section A0', completed: true),
      Task(taskContent: 'Section A1', completed: false),
      Task(taskContent: 'Section A2', completed: false),
    ],
  ),
  Job(
    'Chapter B',
    <Task>[
      Task(taskContent: 'Section B0', completed: false),
      Task(taskContent: 'Section B1', completed: true),
      Task(taskContent: 'Section B2', completed: true),
    ],
  ),
];