import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../style.dart';

class NotifyPage extends StatefulWidget {
  NotifyPage({Key key}) : super(key: key);

  @override
  _NotifyPageState createState() => _NotifyPageState();
}

class _NotifyPageState extends State<NotifyPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          // controller: _titleController,
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
                          // controller: _descriptionController,
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
                        onPressed: () => {},
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
                  'Notify task',
                  style: appBarTitle,
                ),
              ),
            ),
          ];
        },
        body: Text("COOL!")
      ),
    );
  }
}
