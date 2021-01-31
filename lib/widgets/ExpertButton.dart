import 'package:flutter/material.dart';

class ExpertButton extends StatelessWidget {
  //this widget used to is button
  //and created by passed the below properties

  final String title;
  final Color color;
  final Function onPressed;
  //constructor
  ExpertButton({this.title, this.color, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressed,
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(25)),
      color: color,
      textColor: Colors.white,
      child: Container(
        height: 56.0,
        child: Center(
          child: Text(
            title,
            style: TextStyle(fontSize: 18, fontFamily: 'Brand-Bold'),
          ),
        ),
      ),
    );
  }
}
