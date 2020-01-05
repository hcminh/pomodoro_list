import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/task.dart';
import '../controllers/tasks/manager.dart';
import '../pages/timer.dart';
import '../style.dart';

import 'widgets/customAppBar.dart';
import 'widgets/customAlertDialog.dart';
import 'widgets/customTask.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Manager taskManager = Manager();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey _itemKey = GlobalObjectKey("item");
  TextEditingController _titleController, _descriptionController;
  CusAlertDialog taskAlertDialog;

  @override
  void initState() {
    super.initState();
    taskManager.loadAllTasks();
    _descriptionController = TextEditingController(text: '');
    _titleController = TextEditingController(text: '');
    taskAlertDialog = CusAlertDialog("Your new task", _titleController,
        _descriptionController, _saveTaskAndClose);
  }

  void _startTimer(Task task) async {
    Task result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => TimerPage(
                task: task,
              )),
    );
    if (result != null) {
      await Manager().updateTask(result);
      await taskManager.loadAllTasks();
      setState(() {});
    }
  }

  void _saveTaskAndClose() async {
    String title = _titleController.text;
    String description = _descriptionController.text;

    if (title.trim().isEmpty) {
      return;
    }

    Task task = Task(0, title, description, false);
    if (task != null) {
      await Manager().addNewTask(task);
      await taskManager.loadAllTasks();
      setState(() {});
    }
    Navigator.pop(context);

    _titleController.clear();
    _descriptionController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      floatingActionButton: Container(
        width: 75.0,
        height: 75.0,
        child: RawMaterialButton(
          shape: CircleBorder(),
          fillColor: Colors.blue,
          elevation: 0.0,
          child: addTaskIcon,
          onPressed: () => showDialog(
              context: context,
              builder: (_) => taskAlertDialog),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[CusAppBar('Daily task')];
        },
        body: Container(
          child: StreamBuilder(
              stream: taskManager.tasksData.asStream(),
              initialData: List<Task>(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Task>> snapshot) {
                var tasks = snapshot.data.reversed;
                if (snapshot.connectionState != ConnectionState.done) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (tasks != null && tasks.length == 0) {
                  return Center(
                    child: Text(
                      'Cool! Nothing to do \n Let take a coffee',
                      style: textDoneJob,
                    ),
                  );
                } else {
                  return ListView.builder(
                    padding: EdgeInsets.only(top: 0),
                    itemCount: tasks.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      var item = tasks.elementAt(index);
                      return Hero(
                          tag: 'task-${item.id}',
                          child: Material(
                              key: index == 0 ? _itemKey : null,
                              child: InkWell(
                                child: TaskWidget(
                                  task: item,
                                  onRemoved: () async {
                                    await taskManager.loadAllTasks();
                                    setState(() {});
                                  },
                                  onUpdated: () async {
                                    await taskManager.loadAllTasks();
                                    setState(() {});
                                  },
                                  onTap: () {
                                    _startTimer(item);
                                  },
                                ),
                              )));
                    },
                  );
                }
              }),
        ),
      ),
    );
  }
}
