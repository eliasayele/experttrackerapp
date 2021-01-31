import 'package:flutter/material.dart';

class About extends StatelessWidget {
  static final String path = "lib/src/pages/blog/sports_news1.dart";

  @override
  Widget build(BuildContext context) {
    final Color bgColor = Color(0xffF3F3F3);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          "About",
          style: TextStyle(color: Colors.black, fontSize: 20.0),
        ),
      ),
      body: Center(
        child: Text('About page'),
      ),
    );
  }
}
