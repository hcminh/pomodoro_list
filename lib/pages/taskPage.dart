import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/task.dart';
import '../utils/manager.dart';
import '../pages/timer.dart';
import '../style.dart';

import 'package:flutter_slidable/flutter_slidable.dart';

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

  @override
  void initState() {
    super.initState();
    taskManager.loadAllTasks();
    _descriptionController = TextEditingController(text: '');
    _titleController = TextEditingController(text: '');
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
          // onPressed: _addTask,
          onPressed: () => showDialog(
              context: context,
              builder: (_) => AlertDialog(
                    title: Text("Add your new task"),
                    content: Container(
                      height: 140,
                      width: MediaQuery.of(context).size.width * 0.95,
                      child: Column(
                        children: <Widget>[
                        TextField(
                          autofocus: true,
                          maxLength: 24,
                          controller: _titleController,
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Task title',
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding:
                                EdgeInsets.only(left: 8, right: 8),
                          ),
                        ),
                        TextField(
                          controller: _descriptionController,
                          keyboardType: TextInputType.multiline,
                          maxLength: 50,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Description',
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding:
                                EdgeInsets.only(left: 8, right: 8),
                          ),
                        ),
                      ],
                    ),
                    ),
                    elevation: 24.0,
                    actions: <Widget>[
                      FlatButton(
                        child: Text('Save', style: TextStyle(fontSize: 18.0,),),
                        onPressed: _saveTaskAndClose,
                      ),
                    ],
                  )),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: Color(0xFaFaFa).withOpacity(1.0),
              expandedHeight: 80.0,
              floating: true,
              pinned: false,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  'Daily Jobs',
                  style: appBarTitle,
                ),
              ),
            ),
          ];
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
