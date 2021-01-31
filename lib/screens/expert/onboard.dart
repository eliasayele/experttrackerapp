import 'package:experttrack/core/assets.dart';
import 'package:experttrack/screens/expert/createprofile.dart';
import 'package:flutter/material.dart';

class LandingOnePage extends StatelessWidget {
  LandingOnePage({Key key, this.token}) : super(key: key);
  static final String path = "lib/src/pages/onboarding/landing1.dart";
  final String bgImage = photographer;
  final String image = ledge;
  final String token;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // Container(
          //     alignment: Alignment.center,
          //     child: CachedNetworkImage(
          //       imageUrl: bgImage,
          //       imageBuilder: (context, imageProvider) => Container(
          //         decoration: BoxDecoration(
          //           image: DecorationImage(
          //             image: imageProvider,
          //             fit: BoxFit.contain,
          //           ),
          //         ),
          //       ),
          //     )),
          Column(
            children: <Widget>[
              SizedBox(height: 30.0),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black38,
                            offset: Offset(2.0, 5.0),
                            blurRadius: 5.0)
                      ]),
                  margin: EdgeInsets.all(48.0),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('images/exp.png'),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0),
                              )),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Text(
                        "Do you have a skill?",
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 24.0,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        "Welcome please provide your true information only, and create your working environment, exposed to many customers and get paid",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black, fontSize: 14.0),
                      ),
                      SizedBox(height: 30.0),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 80.0),
                width: double.infinity,
                child: RaisedButton(
                  padding: const EdgeInsets.all(16.0),
                  textColor: Colors.white,
                  color: Colors.lightGreen,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreateProfile(token: token),
                      ),
                    );
                  },
                  child: Text(
                    "Get Started",
                    style:
                        TextStyle(fontWeight: FontWeight.w300, fontSize: 18.0),
                  ),
                ),
              ),
              SizedBox(height: 40.0),
            ],
          )
        ],
      ),
    );
  }
}
