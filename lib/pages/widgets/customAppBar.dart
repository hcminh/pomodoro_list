import 'package:flutter/material.dart';
import '../../style.dart';

class CusAppBar extends StatelessWidget {
  final String title;
  CusAppBar(this.title);
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Color(0xFaFaFa).withOpacity(1.0),
      expandedHeight: 80.0,
      floating: true,
      pinned: false,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          title,
          style: appBarTitle,
        ),
      ),
    );
  }
}
