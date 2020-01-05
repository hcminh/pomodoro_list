// app.dart

import 'package:flutter/material.dart';
import 'pages/taskPage.dart';
import 'pages/notePage.dart';

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
  State<StatefulWidget> createState() => _MyMainPageState();
}

class _MyMainPageState extends State<MainPage> {
  int _selectedPage = 0;

  final pageController = PageController(
    initialPage: 0,
  );

  Widget buildPageView() {
    return PageView(
      controller: pageController,
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      onPageChanged: (int index) {
        setState(() {
          _selectedPage = index;
        });
      },
      children: <Widget>[
        HomePage(),
        NotePage(),
      ],
    );
  }

  List <BottomNavigationBarItem> bottomIconTap() {
    return [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.check_circle_outline,
              size: 30.0,
            ),
            title: Container(),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.event_note,
              size: 30.0,
            ),
            title: Container(),
          ),
        ];
  }

  bottomTapped(int index) {
    setState(() {
      _selectedPage = index;
      pageController.jumpToPage(index);
    });
  }

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      body: buildPageView(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedPage,
        onTap: bottomTapped,
        items: bottomIconTap(),
      ),
    );
  }
}
