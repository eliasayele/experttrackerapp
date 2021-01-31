import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:experttrack/helpers/api.dart';
import 'package:experttrack/screens/expert/home.dart' as FancyBottomBarPage;
import 'package:experttrack/screens/mainpage.dart';
import 'package:experttrack/screens/registrationpage.dart';
//import 'package:experttrack/string/navaybar.dart';
import 'package:experttrack/widgets/ExpertButton.dart';
import 'package:experttrack/widgets/ProgressDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  static const String id = 'loginpage';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //final FirebaseAuth _auth = FirebaseAuth.instance;

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  void showSnackBar(String title) {
    final snackbar = SnackBar(
      content: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 15),
      ),
    );
    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var token;
  var name;
  var avatar;
  var type;

  //this func is authenticate the user and return token
  void loginmongo() async {
    //this show loading status
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => ProgressDialog(
        status: 'Logging you in',
      ),
    );

    //all network requests must be surround by try catch
    try {
      Response response = await AuthService.login(
          emailController.text, passwordController.text);
      if (response.statusCode == 200) {
        token = response.data['token'];
        Fluttertoast.showToast(
            msg: 'Authenticated',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.SNACKBAR,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);

        //this request sent for to get users information
        Response resuser = await AuthService.getinfo(token);

        name = resuser.data['name'];
        avatar = resuser.data['avatar'];
        type = resuser.data['type'];

        if (type == 'expert' || type == 'admin') {
          //navigate to main experts page after login
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  FancyBottomBarPage.FancyBottomBarPage(token: token),
            ),
          );
        } else if (type == 'customer') {
          //navigate to main page after login
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  MainPage(token: token, name: name, avatar: avatar),
            ),
          );
        }
      }
    } catch (e) {
      Navigator.pop(context);

      showSnackBar("Try Again!");
      print(e.message);
    }
  }
//firebase login
  // void login() async {
  //   showDialog(
  //     barrierDismissible: false,
  //     context: context,
  //     builder: (BuildContext context) => ProgressDialog(
  //       status: 'Logging you in',
  //     ),
  //   );
  //   try {
  //     UserCredential userCredential = await FirebaseAuth.instance
  //         .signInWithEmailAndPassword(
  //             email: emailController.text, password: passwordController.text);
  //
  //     if (userCredential != null) {
  //       var userid = _auth.currentUser.uid;
  //       DatabaseReference userRef =
  //           FirebaseDatabase.instance.reference().child('users/${userid}');
  //
  //       userRef.once().then((DataSnapshot snapshot) {
  //         if (snapshot.value != null) {
  //           print('user found');
  //           Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //               builder: (context) => MainPage(),
  //               settings: RouteSettings(
  //                 arguments: token,
  //               ),
  //             ),
  //           );
  //         }
  //       });
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     //Navigator.pop(context);
  //     if (e.code == 'user-not-found') {
  //       print('No user found for that email.');
  //       showSnackBar('No user found for that email.');
  //       return;
  //     } else if (e.code == 'wrong-password') {
  //       showSnackBar('wrong-password');
  //       print('Wrong password provided for that user.');
  //       return;
  //     }
  //   } catch (e) {
  //     Navigator.pop(context);
  //     PlatformException thisEx = e;
  //     showSnackBar(thisEx.message);
  //     print(e);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 70.0,
                ),
                Image(
                  alignment: Alignment.center,
                  height: 150.0,
                  width: MediaQuery.of(context).size.width * 0.7,
                  image: AssetImage('images/logo.png'),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Text(
                  'Sign In Here',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25.0, fontFamily: 'Brand-Bold'),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            labelText: 'Email address',
                            labelStyle: TextStyle(
                              fontSize: 14.0,
                            ),
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 10.0,
                            )),
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(
                              fontSize: 14.0,
                            ),
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 10.0,
                            )),
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      ExpertButton(
                        title: 'Login',
                        color: Colors.green,
                        onPressed: () async {
                          var connectivityResult =
                              await Connectivity().checkConnectivity();
                          if (connectivityResult != ConnectivityResult.mobile &&
                              connectivityResult != ConnectivityResult.wifi) {
                            showSnackBar('No Internet Connectivity');
                            return;
                          }
                          if (!emailController.text.contains('@')) {
                            showSnackBar(
                                'Please enter your valid email address');
                            return;
                          }
                          if (passwordController.text.length < 6) {
                            showSnackBar('Please enter valid email');
                            return;
                          }
                          //calling
                          loginmongo();
                        },
                      ),
                      //login();
                    ],
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegistrationPage(),
                      ),
                    );
                  },
                  child: Text(
                    'Don\'t have an account? sign up here',
                    style: new TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
