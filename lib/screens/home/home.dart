// screens/home/home.dart

import 'package:flutter/material.dart';
import '../../style.dart';
import '../../widgets/task.dart';
import '../../widgets/job.dart';
import '../../widgets/list_jobs.dart';

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
        child: ListJob(),
      ),
      // floatingActionButton: AddJobButton(),
    );
  }
}
