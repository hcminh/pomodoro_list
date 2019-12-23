// screens/home/home.dart

import 'package:flutter/material.dart';

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
          style: TextStyle(
            letterSpacing: 0.5,
            height: 1.5,
            color: Colors.black,
            fontSize: 23.0,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: Text(''),
    );
  }
}
