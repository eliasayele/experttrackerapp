import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:experttrack/helpers/api.dart';
import 'package:experttrack/screens/expert/home.dart';
import 'package:experttrack/screens/settings.dart';
import 'package:experttrack/widgets/ProgressDialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CreateProfile extends StatefulWidget {
  final String token;
  CreateProfile({Key key, this.token}) : super(key: key);
  @override
  _CreateProfileState createState() => _CreateProfileState(token: token);
}

class _CreateProfileState extends State<CreateProfile> {
  final String token;
  _CreateProfileState({this.token});
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  bool showPassword = false;
  //final String name;
  var professionController = TextEditingController();
  var companyController = TextEditingController();
  var skilController = TextEditingController();
  var cityController = TextEditingController();
  var addressController = TextEditingController();
  var bioController = TextEditingController();
  var websiteController = TextEditingController();
  var facebookController = TextEditingController();
  var instagramController = TextEditingController();
  var twitterController = TextEditingController();
  var youtubeController = TextEditingController();
  var linkedInController = TextEditingController();
  var githubController = TextEditingController();

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

  void createProfile() async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => ProgressDialog(
        status: 'creating profile... ',
      ),
    );
    try {
      Response response = await AuthService.createprofile(
          token,
          professionController.text,
          companyController.text,
          skilController.text,
          cityController.text,
          addressController.text,
          bioController.text,
          websiteController.text,
          facebookController.text,
          twitterController.text,
          youtubeController.text,
          instagramController.text,
          linkedInController.text,
          githubController.text);

      if (response.statusCode == 200) {
        //as soon as user create profile we change his type 'expert'
         await AuthService.makeUserExpert(token);
        Fluttertoast.showToast(
            msg: 'Profile Created',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.SNACKBAR,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        //    name = response.data['name'];
        print('token begin');
        print(token);
        print('token end');
        // Response res = await AuthService.getinfo(token);
        // print(res.data['name']);
        // Response resuser = await AuthService.getinfo(token);
        // name = resuser.data['name'];
        // avatar = resuser.data['avatar'];
        // print(name);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FancyBottomBarPage(token: token),
          ),
        );
      }
    } catch (e) {
      Navigator.pop(context);
      showSnackBar(e.toString());
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Create Profile",
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.article,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => SettingsPage()));
            },
          ),
        ],
      ),
      // onTap: () {
      //   FocusScope.of(context).unfocus();
      // },
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Container(
                // margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  boxShadow: [
                    BoxShadow(
                        spreadRadius: 10,
                        color: Colors.white.withOpacity(0.8),
                        offset: Offset(0, 7),
                        blurRadius: 5.0)
                  ],
                ),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        "Please enter appropriate information of your profession, profession skill and city is required",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              buildTextField(
                  "Profession", "what do you do", false, professionController),
              buildTextField("company", "company where you work", false,
                  companyController),
              buildTextField(
                  "Skills", "engine repair,oil change", false, skilController),
              buildTextField(
                  "city", "Wolkite, Ethiopia", false, cityController),
              buildTextField("address", "gubre", false, addressController),
              buildTextField(
                  "bio", "short bio of yourself", false, bioController),
              buildTextField("website", "optional", false, websiteController),
              //expandable list begin
              ExpansionTile(
                childrenPadding: EdgeInsets.only(left: 16, top: 25, right: 16),
                title: Text(
                  "Add Social Media Link",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                children: <Widget>[
                  buildTextField(
                      "facebook", "optional", false, facebookController),
                  buildTextField(
                      "twitter", "optional", false, twitterController),
                  buildTextField(
                      "youtube", "optional", false, youtubeController),
                  buildTextField(
                      "instagram", "optional", false, instagramController),
                  buildTextField(
                      "linkedIn", "optional", false, linkedInController),
                  buildTextField("github", "github", false, githubController),
                ],
              ),
              //expandable list end
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: RaisedButton(
                  onPressed: () async {
                    var connectivityResult =
                        await Connectivity().checkConnectivity();
                    if (connectivityResult != ConnectivityResult.mobile &&
                        connectivityResult != ConnectivityResult.wifi) {
                      showSnackBar('No Internet Connectivity');
                      return;
                    }
                    if (professionController.text.length < 2) {
                      showSnackBar('Please enter valid profession');
                      return;
                    }
                    if (cityController.text.length < 2) {
                      showSnackBar('Please enter valid city');
                      return;
                    }
                    if (skilController.text.length < 2) {
                      showSnackBar('Please enter valid skill');
                      return;
                    }
                    createProfile();
                  },
                  // onPressed: () {
                  //   Navigator.pop(context);
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => FancyBottomBarPage(),
                  //     ),
                  //   );
                  // },
                  color: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    "SAVE",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        letterSpacing: 3,
                        color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String labelText, String placeholder,
      bool isPasswordTextField, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        controller: controller,
        obscureText: isPasswordTextField ? showPassword : false,
        // decoration: InputDecoration(
        //     suffixIcon: isPasswordTextField
        //         ? IconButton(
        //             onPressed: () {
        //               setState(() {
        //                 showPassword = !showPassword;
        //               });
        //             },
        //             icon: Icon(
        //               Icons.remove_red_eye,
        //               color: Colors.grey,
        //             ),
        //           )
        //         : null,
        //     contentPadding: EdgeInsets.only(bottom: 3),
        //     labelText: labelText,
        //     labelStyle: TextStyle(
        //       fontSize: 20,
        //       //color: Colors.black,
        //     ),
        //     floatingLabelBehavior: FloatingLabelBehavior.always,
        //     hintText: placeholder,
        //     hintStyle: TextStyle(
        //       fontSize: 14,
        //     )),
        decoration: InputDecoration(
          labelText: labelText,
          hintStyle: TextStyle(color: Colors.grey),
          filled: true,
          hintText: placeholder,
          fillColor: Colors.white70,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
            borderSide: BorderSide(color: Colors.grey, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: Colors.lightGreen),
          ),
        ),
      ),
    );
  }
}
