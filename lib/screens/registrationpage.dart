import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:experttrack/helpers/api.dart';
import 'package:experttrack/screens/loginpage.dart';
import 'package:experttrack/screens/mainpage.dart';
import 'package:experttrack/widgets/ExpertButton.dart';
import 'package:experttrack/widgets/ProgressDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RegistrationPage extends StatefulWidget {
  static const String id = 'register';

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  var token;
  var name;
  var avatar;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  getLocation() async {
    //get user location
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    LatLng pos = LatLng(position.latitude, position.longitude);

    return pos;
  }

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

  // final FirebaseAuth _auth = FirebaseAuth.instance;

  var fullNameController = TextEditingController();

  var phoneController = TextEditingController();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();
  //var token; //holds the token hmmmm its funny

  void registerUsermongo() async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => ProgressDialog(
        status: 'Registering you...',
      ),
    );
    try {
      Position position = await GeolocatorPlatform.instance
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      // LatLng pos = LatLng(position.latitude, position.longitude);
      //Future<LatLng>  position = getLocation();
      double latitude = position.latitude;
      double longitude = position.longitude;
      Response response = await AuthService.signup(
          fullNameController.text,
          emailController.text,
          passwordController.text,
          phoneController.text,
          latitude,
          longitude);

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
        print('token begin');
        print(token);
        print('token end');
        Response resuser = await AuthService.getinfo(token);
        name = resuser.data['name'];
        avatar = resuser.data['avatar'];
        // Response res = await AuthService.getinfo(token);
        // print(res.data.toString());

        //push to the Main page if registration complete
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                MainPage(token: token, name: name, avatar: avatar),
          ),
        );
      }
    } catch (e) {
      //next line pop up the progress bar if there is error
      Navigator.pop(context);
      showSnackBar(e.toString());
      print(e);
    }
  }

  //using firebase currently not called
  // void registerUser() async {
  //   showDialog(
  //     barrierDismissible: false,
  //     context: context,
  //     builder: (BuildContext context) => ProgressDialog(
  //       status: 'Registering you...',
  //     ),
  //   );
  //   try {
  //     UserCredential userCredential =
  //         await _auth.createUserWithEmailAndPassword(
  //       email: emailController.text,
  //       password: passwordController.text,
  //     );
  //
  //     if (userCredential != null) {
  //       FirebaseAuth auth = FirebaseAuth.instance;
  //       var userid = auth.currentUser.uid;
  //       DatabaseReference newUserRef =
  //           FirebaseDatabase.instance.reference().child('users/${userid}');
  //       //prepare data to be saved on users table
  //       Map userMap = {
  //         'fulname': fullNameController.text,
  //         'email': emailController.text,
  //         'phone': phoneController.text,
  //       };
  //       var reg = newUserRef.set(userMap);
  //       if (reg != null) {
  //         print('register success');
  //         //showSnackBar('Congratulations, Registration Completed!');
  //         //take user to the mainpage
  //         //  Navigator.pushNamedAndRemoveUntil(context, MainPage.id, (route) => false);
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(builder: (context) => MainPage()),
  //         );
  //       }
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     Navigator.pop(context);
  //     if (e.code == 'weak-password') {
  //       showSnackBar('The password provided is too weak');
  //     } else if (e.code == 'email-already-in-use') {
  //       showSnackBar('The account already exists for that email.');
  //       print('The account already exists for that email.');
  //     }
  //   } catch (e) {
  //     Navigator.pop(context);
  //     PlatformException thisEx = e;
  //     showSnackBar(thisEx.message);
  //     print(e);
  //   }
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey, //this give scafold variable used and do its job
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
                  height: 130.0,
                  width: MediaQuery.of(context).size.width,
                  image: AssetImage('images/logo.png'),
                ),
                SizedBox(
                  height: 25.0,
                ),
                Text(
                  'Create your Account here',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25.0, fontFamily: 'Brand-Bold'),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      //Full Name
                      TextField(
                        controller: fullNameController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            labelText: 'Full Name',
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
                        height: 12.0,
                      ),

                      //Email
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
                        height: 12.0,
                      ),

                      //phone Number
                      TextField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            labelText: 'phone number',
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
                        height: 12.0,
                      ),

                      //password
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

                      //Register Button
                      ExpertButton(
                        title: 'Register',
                        color: Colors.green,
                        onPressed: () async {
                          //check the network
                          var connectivityResult =
                              await Connectivity().checkConnectivity();
                          if (connectivityResult != ConnectivityResult.mobile &&
                              connectivityResult != ConnectivityResult.wifi) {
                            showSnackBar('No Internet Connectivity');
                            return;
                          }
                          //if fulname is grether than 3
                          if (fullNameController.text.length < 3) {
                            showSnackBar('please provide a valid full name');
                            return;
                          }

                          if (!emailController.text.contains('@')) {
                            showSnackBar(
                                'please provide a valid email address');
                            return;
                          }
                          if (phoneController.text.length < 6) {
                            showSnackBar('please provide valid phone number');
                            return;
                          }
                          if (passwordController.text.length < 6) {
                            showSnackBar(
                                'password must be greater than 8 characters');
                            return;
                          }
                          //finaly call void method
                          // registerUser (); //this is firebase register skip for now
                          registerUsermongo();
                        },
                      ),
                    ],
                  ),
                ),
                FlatButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                      // return Navigator.pushNamedAndRemoveUntil(
                      //     context, LoginPage.id, (route) => false);
                    },
                    child: Text('Already have an account? Log in',
                        style: new TextStyle(color: Colors.blue)))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
