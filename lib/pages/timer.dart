import 'dart:async';
import 'dart:math';
import 'package:screen/screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/animation.dart';

import '../models/task.dart';
import '../ui/wave.dart';
import '../style.dart';

class TimerPage extends StatefulWidget {
  final Task task;

  TimerPage({Key key, @required this.task}) : super(key: key);

  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage>
    with SingleTickerProviderStateMixin {
  Timer timer;

  Task getTask() => widget.task;

  String timeText = '';
  int timeRadius = 0;
  int minutes = 1;
  double percentCoutLeft = 1.0;

  Stopwatch stopwatch = Stopwatch();
  static const delay = Duration(microseconds: 1);

  var begin = 0.0;
  Animation<double> heightSize;
  AnimationController _controller;

  double brightness = 0.4;
  bool isKeptOn = false;

  createAlertDialog(BuildContext context, Task task) {
    Widget launchButton = FlatButton(
      child: Text('OK',
          style: TextStyle(
            fontSize: 18.0,
          )),
      onPressed: () {
        print("object \n");
        Navigator.of(context).pop(task);
        backToHome(task);
      },
    );
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: task.done ? Text("Great!") : Text("Ops!"),
            content: task.done
                ? Text("Let relaxing 2 minutes before next task..")
                : Text("Do some tubs before continue.."),
            elevation: 24.0,
            actions: <Widget>[launchButton],
          );
        });
  }

  void backToHome(Task task) {
    Navigator.of(context).pop(task);
  }

  void updateClock() {
    if (stopwatch.elapsed.inMinutes == minutes) {
      if (Navigator.canPop(context)) {
      final task = getTask();
      Navigator.of(context).pop(task);
      createAlertDialog(context, task);
      }
      return;
    }
    var currentMinute = stopwatch.elapsed.inMinutes;
    var currentSecond = stopwatch.elapsed.inSeconds + 1;
    setState(() {
      percentCoutLeft = 1.0 - currentSecond / (minutes * 60);
      if (percentCoutLeft == 0) percentCoutLeft = 0.1;
      timeRadius = (currentSecond);
      timeText =
          '${(minutes - currentMinute - 1).toString().padLeft(2, "0")}:${((60 - stopwatch.elapsed.inSeconds % 60 - 1)).toString().padLeft(2, '0')}';
    });

    if (stopwatch.elapsed.inSeconds == 0) {
      setState(() {
        timeText = '$minutes:00';
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(minutes: minutes),
      vsync: this,
    );

    _controller.addStatusListener((state) {
      print('-----animation state: $state');
    });

    _keepScreenAwake();

    timer = Timer.periodic(delay, (Timer t) => updateClock());

    begin = 50.0;
    stopwatch.start();
    _controller.forward();
    updateClock();
  }

  void _keepScreenAwake() async {
    brightness = await Screen.brightness;
    isKeptOn = await Screen.isKeptOn;

    Screen.setBrightness(0.3);
    Screen.keepOn(true);
  }

  @override
  void dispose() {
    Screen.setBrightness(brightness);
    Screen.keepOn(isKeptOn);
    _controller.dispose();
    stopwatch.stop();
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    heightSize =
        new Tween(begin: begin, end: MediaQuery.of(context).size.height + 70.0)
            .animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    Size size =
        new Size(MediaQuery.of(context).size.width, heightSize.value * 0.9);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Material(
        child: Stack(
          children: <Widget>[
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return DemoBody(
                  size: size,
                  color: Theme.of(context).primaryColor,
                  // color: Color.fromARGB(230, 25.5 ~/ percentCoutLeft, 120,
                  //     (255 * percentCoutLeft).toInt()),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 32.0, left: 4.0, right: 4.0),
              child: Row(
                children: <Widget>[
                  IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        size: 35.0,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                  Spacer(),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.only(top: 150),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Hero(
                      transitionOnUserGestures: true,
                      tag: 'text-${widget.task.id}',
                      child: Text(
                        widget.task.title,
                        style:
                            TextStyle(fontSize: 30.0, color: Colors.grey[850]),
                      ),
                    ),
                    Text(
                      widget.task.description,
                      style: TextStyle(color: Colors.grey[800]),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                margin: EdgeInsets.only(bottom: 100),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Transform.rotate(
                            angle: 2 * pi * timeRadius / (minutes * 60),
                            child: Icon(
                              Icons.power_settings_new,
                              size: 200.0,
                            ),
                          ),
                          Container(
                            height: 150,
                            width: 150,
                            margin: EdgeInsets.only(left: 25, top: 25),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100.0)),
                                border: Border.all(
                                    width: 17,
                                    color: Colors.black,
                                    style: BorderStyle.solid)),
                            child: null,
                          ),
                        ],
                      ),
                      // Text(
                      //   timeText,
                      //   style: textTimerCouting,
                      // ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(bottom: 32),
                child: GestureDetector(
                    child: RoundedButton(),
                    onTap: () {
                      final task = getTask()..done = true;

                      createAlertDialog(context, task);
                      // Navigator.of(context).pop(task);
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class RoundedButton extends StatefulWidget {
  RoundedButton({Key key}) : super(key: key);

  @override
  _RoundedButtonState createState() => _RoundedButtonState();
}

class _RoundedButtonState extends State<RoundedButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140.0,
      height: 140.0,
      child: finishIcon,
    );
  }
}
