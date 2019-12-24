import 'package:flutter/material.dart';
import 'package:podomoro_list/widgets/task.dart';
import 'package:podomoro_list/style.dart';

class Job {
  Job(this.title, this.children);

  final String title;
  final List<Task> children;
}

class JobWidget extends StatelessWidget {
  const JobWidget(this.job);
  final Job job;

  Widget _buildTiles(Job root) {
    if (root.children.isEmpty) return Task(taskContent: root.title, completed: false);
    return ExpansionTile(
      backgroundColor: Colors.transparent,
      title: Text(
        root.title,
        style: jobTitle,
      ),
      children: root.children
          .map((item) {
            return Task(taskContent: item.taskContent, completed: item.completed);
          }).toList()
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(job);
  }
}
