// app.dart

import 'package:flutter/material.dart';
import 'pages/home.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Colors.black,
      home: HomePage(),
    );
  }
}
