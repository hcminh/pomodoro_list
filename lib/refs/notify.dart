// import 'dart:async';
// import 'dart:ui';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:rxdart/subjects.dart';

// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

// // Streams are created so that app can respond to notification-related events since the plugin is initialised in the `main` function
// final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject =
//     BehaviorSubject<ReceivedNotification>();

// final BehaviorSubject<String> selectNotificationSubject =
//     BehaviorSubject<String>();

// class ReceivedNotification {
//   final int id;
//   final String title;
//   final String body;
//   final String payload;

//   ReceivedNotification(
//       {@required this.id,
//       @required this.title,
//       @required this.body,
//       @required this.payload});
// }

// /// IMPORTANT: running the following code on its own won't work as there is setup required for each platform head project.
// /// Please download the complete example app from the GitHub repository where all the setup has been done
// Future<void> main() async {
//   // needed if you intend to initialize in the `main` function
//   WidgetsFlutterBinding.ensureInitialized();

//   var initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
//   var initializationSettingsIOS = IOSInitializationSettings(
//       onDidReceiveLocalNotification:
//           (int id, String title, String body, String payload) async {
//     didReceiveLocalNotificationSubject.add(ReceivedNotification(
//         id: id, title: title, body: body, payload: payload));
//   });
//   var initializationSettings = InitializationSettings(
//       initializationSettingsAndroid, initializationSettingsIOS);
//   await flutterLocalNotificationsPlugin.initialize(initializationSettings,
//       onSelectNotification: (String payload) async {
//     if (payload != null) {
//       debugPrint('notification payload: ' + payload);
//     }
//     selectNotificationSubject.add(payload);
//   });
//   runApp(
//     MaterialApp(
//       home: HomePage(),
//     ),
//   );
// }

// class PaddedRaisedButton extends StatelessWidget {
//   final String buttonText;
//   final VoidCallback onPressed;
//   const PaddedRaisedButton(
//       {@required this.buttonText, @required this.onPressed});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 8.0),
//       child: RaisedButton(child: Text(buttonText), onPressed: onPressed),
//     );
//   }
// }

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final MethodChannel platform =
//       MethodChannel('crossingthestreams.io/resourceResolver');
//   @override
//   void initState() {
//     super.initState();
//     didReceiveLocalNotificationSubject.stream
//         .listen((ReceivedNotification receivedNotification) async {
//       await showDialog(
//         context: context,
//         builder: (BuildContext context) => CupertinoAlertDialog(
//           title: receivedNotification.title != null
//               ? Text(receivedNotification.title)
//               : null,
//           content: receivedNotification.body != null
//               ? Text(receivedNotification.body)
//               : null,
//           actions: [
//             CupertinoDialogAction(
//               isDefaultAction: true,
//               child: Text('Ok'),
//               onPressed: () async {
//                 Navigator.of(context, rootNavigator: true).pop();
//                 await Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) =>
//                         SecondScreen(receivedNotification.payload),
//                   ),
//                 );
//               },
//             )
//           ],
//         ),
//       );
//     });
//     selectNotificationSubject.stream.listen((String payload) async {
//       await Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => SecondScreen(payload)),
//       );
//     });
//   }

//   @override
//   void dispose() {
//     didReceiveLocalNotificationSubject.close();
//     selectNotificationSubject.close();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Plugin example app'),
//         ),
//         body: SingleChildScrollView(
//           scrollDirection: Axis.vertical,
//           child: Padding(
//             padding: EdgeInsets.all(8.0),
//             child: Center(
//               child: Column(
//                 children: <Widget>[
//                   Padding(
//                     padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 8.0),
//                     child: Text(
//                         'Tap on a notification when it appears to trigger navigation'),
//                   ),
                  
//                   PaddedRaisedButton(
//                     buttonText:
//                         'Repeat notification every day at approximately 10:00:00 am',
//                     onPressed: () async {
//                       await _showDailyAtTime();
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> _showDailyAtTime() async {
//     var time = Time(12, 53, 0);
//     var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//         'repeatDailyAtTime channel id',
//         'repeatDailyAtTime channel name',
//         'repeatDailyAtTime description');
//     var iOSPlatformChannelSpecifics = IOSNotificationDetails();
//     var platformChannelSpecifics = NotificationDetails(
//         androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
//     await flutterLocalNotificationsPlugin.showDailyAtTime(
//         0,
//         'show daily title',
//         'Daily notification shown at approximately ${_toTwoDigitString(time.hour)}:${_toTwoDigitString(time.minute)}:${_toTwoDigitString(time.second)}',
//         time,
//         platformChannelSpecifics);
//   }

//   String _toTwoDigitString(int value) {
//     return value.toString().padLeft(2, '0');
//   }
// }

// class SecondScreen extends StatefulWidget {
//   SecondScreen(this.payload);

//   final String payload;

//   @override
//   State<StatefulWidget> createState() => SecondScreenState();
// }

// class SecondScreenState extends State<SecondScreen> {
//   String _payload;
//   @override
//   void initState() {
//     super.initState();
//     _payload = widget.payload;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Second Screen with payload: ${(_payload ?? '')}'),
//       ),
//       body: Center(
//         child: RaisedButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           child: Text('Go back!'),
//         ),
//       ),
//     );
//   }
// }
