// app.dart

import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'pages/page2.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Colors.black,
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  State<StatefulWidget> createState() => new _MyMainPageState();
}

class _MyMainPageState extends State<MainPage> {
int _selectedPage = 0;

  final _pageOptions = [
    HomePage(),
    SecondPage(),
  ];
  
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.grey,
      body: _pageOptions[_selectedPage],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedPage,
        onTap: (int index) {
          setState(() {
            _selectedPage = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle_outline),
            title: Text(''),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_active),
            title: Text(''),
          ),
        ],
      ),
    );
  }
}
