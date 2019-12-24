import 'package:flutter/material.dart';
import 'package:podomoro_list/widgets/job.dart';
import 'package:podomoro_list/widgets/task.dart';
import 'package:podomoro_list/style.dart';

class ListJob extends StatefulWidget {
  ListJob({Key key}) : super(key: key);
  @override
  ListJobState createState() => ListJobState();
}

class ListJobState extends State<ListJob> {
  _addNewJob(Job job) {
    data.add(job);
    setState(() {});
  }

  // _addNewTaskOnJob(Job job, Task task)
  // {
  //   job.children.add(task);

  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) =>
            JobWidget(data[index]),
        itemCount: data.length,
      ),
      floatingActionButton: AddJobButton(addNewJob: _addNewJob),
    );
  }
}

class AddJobButton extends StatefulWidget {
  AddJobButton({Key key, this.addNewJob}) : super(key: key);
  final Function addNewJob;
  @override
  AddJobButtonState createState() => AddJobButtonState();
}

class AddJobButtonState extends State<AddJobButton> {
  void _onPressed() {
    widget.addNewJob(Job(
      'Chapter C',
      <Task>[
        Task(taskContent: 'Section A1', completed: false),
        Task(taskContent: 'Section A2', completed: false),
        Task(taskContent: '', completed: false),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: _onPressed,
      tooltip: 'Add new job',
      child: Icon(Icons.add),
    );
  }
}

//fake data
// The entire multilevel list displayed by this app.
List<Job> data = <Job>[
  Job(
    'Chapter A',
    <Task>[
      Task(taskContent: 'Section A0', completed: true),
      Task(taskContent: 'Section A1', completed: false),
      Task(taskContent: 'Section A2', completed: false),
      Task(taskContent: '', completed: false),
    ],
  ),
  Job(
    'Chapter B',
    <Task>[
      Task(taskContent: 'Section B0', completed: false),
      Task(taskContent: 'Section B1', completed: true),
      Task(taskContent: 'Section B2', completed: true),
      Task(taskContent: '', completed: false),
    ],
  ),
];
