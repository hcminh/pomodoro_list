import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'widgets/customAppBar.dart';
import 'widgets/customAlertDialog.dart';
import '../style.dart';

class ReminderPage extends StatefulWidget {
  ReminderPage({Key key}) : super(key: key);

  @override
  _ReminderPageState createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  TextEditingController _titleController, _descriptionController;
  _saveReminderAndClose() {}

  showNotification() async {
    var android = AndroidNotificationDetails(
        'channel id', 'channel name', 'channel description');
    var iOS = IOSNotificationDetails();
    var platform = NotificationDetails(android, iOS);
    var scheduledNotificationDateTime = new DateTime(2019, 12,26,13,37,0,0,0);
    await flutterLocalNotificationsPlugin.schedule(0, 'Title ', 'Body', scheduledNotificationDateTime, platform);
  }


  @override
  void initState() {
    super.initState();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var android = AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOS = IOSInitializationSettings();
    var initSettings = InitializationSettings(android, iOS);
    flutterLocalNotificationsPlugin.initialize(initSettings);
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
          onPressed: showNotification,
          // onPressed: () => showDialog(
          //   context: context,
          //   builder: (_) => CusAlertDialog("Your new reminder",
          //       _titleController, _descriptionController, _saveReminderAndClose),
          // ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[CusAppBar('Notify task')];
          },
          body: Text("COOL!")),
    );
  }
}
