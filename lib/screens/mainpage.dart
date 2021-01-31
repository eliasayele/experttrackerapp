import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:experttrack/brand-colors.dart';
import 'package:experttrack/datamodels/experts.dart';
import 'package:experttrack/helpers/api.dart';
import 'package:experttrack/screens/about.dart';
import 'package:experttrack/screens/chatuicustomer.dart';
import 'package:experttrack/screens/detailprofile.dart';
import 'package:experttrack/screens/editprofile.dart';
import 'package:experttrack/screens/expert/onboard.dart';
import 'package:experttrack/screens/expert/post.dart';
import 'package:experttrack/screens/loginpage.dart';
import 'package:experttrack/screens/searchpage.dart';
import 'package:experttrack/screens/settings.dart';
import 'package:experttrack/styles/styles.dart';
import 'package:experttrack/widgets/BrandDivider.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class MainPage extends StatefulWidget {
  final token, name, avatar;
  MainPage({Key key, this.token, this.name, this.avatar}) : super(key: key);
  static const String id = 'mainpage';

  @override
  _MainPageState createState() =>
      _MainPageState(token: token, name: name, avatar: avatar);
}

class _MainPageState extends State<MainPage> {
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  //for handling key and open drawer
  double searchSheetHeight = (Platform.isIOS) ? 300 : 275;
  //check the platform for the sheet and this make look the same in android and ios
  final token, name, avatar;
  _MainPageState({ this.token, this.name, this.avatar});

  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController mapController;
  double mapBottomPadding = 0;

  // var geoLocator = Geolocator();
  Position currentPosition;
  //get position fro geolocator package

  // void fetchUser() async {
  //   try {
  //     Response response = await AuthService.login(
  //         emailController.text, passwordController.text);
  //
  //     if (response.statusCode == 200) {
  //       token = response.data['token'];
  //
  //       Fluttertoast.showToast(
  //           msg: 'Authenticated',
  //           toastLength: Toast.LENGTH_SHORT,
  //           gravity: ToastGravity.SNACKBAR,
  //           timeInSecForIosWeb: 1,
  //           backgroundColor: Colors.green,
  //           textColor: Colors.white,
  //           fontSize: 16.0);
  //     }
  //   } catch (e) {}
  // }

  //marker code
  // CLASS MEMBER, MAP OF MARKS
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  MarkerId selectedMarker;

  void setupPositionLocator() async {
    //get user location
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    currentPosition = position;

    LatLng pos = LatLng(position.latitude, position.longitude);
    CameraPosition cp = new CameraPosition(target: pos, zoom: 14);
    mapController.animateCamera(CameraUpdate.newCameraPosition(cp));
    //street address implemented letter

    // String address = await HelperMethods.findCordinateAddress(position,context);
    // print(address);
  }

  static CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(8.9806, 38.7578),
    zoom: 14.4746,
  );

  List<Experts> expertPredictionList = [];
  //auto search mode func
  void searchExpert() async {
    //print(query);

    String tok = token;
    //'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoiZTNhNDI5Y2MyNWJjNGRhOGI3Y2Y3NGFjNjEyMzA2ODEifSwiaWF0IjoxNjA5MzU2MDQ1LCJleHAiOjE2MDk3MTYwNDV9.IcPyC_J1G_03gt9aAwL5Ejm0ExT0ileo1IiECvW62Lc';

    var response = await AuthService.getAllProfiles(tok);
    if (response != null) {
      var resultJson = response['profiles'];
      var thisList =
          (resultJson as List).map((e) => Experts.fromJson(e)).toList();
      setState(() {
        expertPredictionList = thisList;
      });

      return response;
    }
  }

  List<Marker> allMarkers = [];

  final Map<String, Marker> _markers = {};
  Future<void> createmark() async {
    //searchExpert();
    String tok = token;
    // 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoiZTNhNDI5Y2MyNWJjNGRhOGI3Y2Y3NGFjNjEyMzA2ODEifSwiaWF0IjoxNjA5MzU2MDQ1LCJleHAiOjE2MDk3MTYwNDV9.IcPyC_J1G_03gt9aAwL5Ejm0ExT0ileo1IiECvW62Lc';

    final response = await AuthService.getAllProfiles(tok);
    if (response != null) {
      var resultJson = response['profiles'];
      var thisList =
          (resultJson as List).map((e) => Experts.fromJson(e)).toList();
      setState(() {
        expertPredictionList = thisList;
      });
    }

    // final googleOffices = await locations.getGoogleOffices();

    setState(() {
      _markers.clear();
      for (final expr in expertPredictionList) {
        final marker = Marker(
          markerId: MarkerId(expr.userId),
          position:
              LatLng(double.parse(expr.latitude), double.parse(expr.longitude)),
          infoWindow: InfoWindow(
            title: expr.name,
            snippet: expr.profession,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePage(),
                  settings: RouteSettings(
                      // arguments: widget.token,
                      ),
                ),
              );
            },
          ),
          onTap: () {},
        );
        _markers[expr.name] = marker;
      }
    });
  }

  // final LoginPage token = ModalRoute.of(BuildContext context).settings.arguments;
  // Response res = await AuthService.getinfo(token);
  @override
  Widget build(BuildContext context) {
    var parts = name.split(' ');
    var na = parts[0].trim();
    // final String token = ModalRoute.of(context).settings.arguments;
    //final String name = ModalRoute.of(context).settings.arguments.
    return Scaffold(
      key: scaffoldKey,
      drawer: Container(
        width: 250,
        color: Color(0xFFE8F5E9),
        child: Drawer(
          child: Container(
            color: Color(0xFFE8F5E9),
            child: ListView(
              padding: EdgeInsets.all(0),
              children: [
                Container(
                  color: Color(0xFFE8F5E9),
                  height: 160,
                  child: DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.lightGreen,

                      // image: DecorationImage(
                      //   fit: BoxFit.fill,
                      //
                      //   image: AssetImage(
                      //     'images/light-gree.jpg',
                      //   ),
                      // ),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.blueGrey,
                            child: CircleAvatar(
                                radius: 35.0,
                                backgroundImage: CachedNetworkImageProvider(
                                    avatar != null
                                        ? avatar
                                        : "https://res.cloudinary.com/expert-tracker/image/upload/v1609371504/expertbo_iy2uj5.png"))),
                        SizedBox(
                          width: 15,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              name != null ? na : 'Name',
                              style: TextStyle(
                                  fontSize: 19,
                                  fontFamily: 'Brand-Bold',
                                  color: Colors.black),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Customer',
                              style: TextStyle(
                                  fontFamily: 'Brand-Bold',
                                  color: Colors.black),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                BrandDivider(),
                SizedBox(
                  height: 10,
                ),
                //chat
                GestureDetector(
                  child: ListTile(
                    leading: Icon(OMIcons.chatBubbleOutline),
                    title: Text(
                      'Inbox',
                      style: kDrawerItemStyle,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatUiCustomer(),
                        settings: RouteSettings(
                          arguments: widget.token,
                        ),
                      ),
                    );
                    //ExpertRegister();
                  },
                ),
                //edit profile
                GestureDetector(
                    child: ListTile(
                      leading: Icon(OMIcons.edit),
                      title: Text(
                        'Edit Profile',
                        style: kDrawerItemStyle,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditProfilePage(),
                        ),
                      );
                    }),
                //be expert
                GestureDetector(
                  child: ListTile(
                    leading: Icon(OMIcons.workOutline),
                    title: Text(
                      'Be Expert',
                      style: kDrawerItemStyle,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LandingOnePage(token: token),
                      ),
                    );
                    //ExpertRegister();
                  },
                ),
                //nearby expert
                GestureDetector(
                  child: ListTile(
                    leading: Icon(OMIcons.nearMe),
                    title: Text(
                      'Nearby Experts',
                      style: kDrawerItemStyle,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Posts(),
                        settings: RouteSettings(
                          arguments: widget.to  ken,
                        ),
                      ),
                    );
                  },
                ),
                //History
                ListTile(
                  leading: Icon(OMIcons.history),
                  title: Text(
                    'History',
                    style: kDrawerItemStyle,
                  ),
                ),
                //about
                GestureDetector(
                    child: ListTile(
                      leading: Icon(OMIcons.settings),
                      title: Text(
                        'Setting',
                        style: kDrawerItemStyle,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SettingsPage(),
                          settings: RouteSettings(
                            arguments: widget.token,
                          ),
                        ),
                      );
                    }),

                GestureDetector(
                  child: ListTile(
                    leading: Icon(OMIcons.info),
                    title: Text(
                      'About',
                      style: kDrawerItemStyle,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => About(),

                      ),
                    );
                    //
                  },
                ),
                //logout
                GestureDetector(
                  child: ListTile(
                    leading: Icon(Icons.link_off),
                    title: Text(
                      'Logout',
                      style: kDrawerItemStyle,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                    );
                    //
                  },
                ),
                //dark mode
                ListTile(
                  leading: Icon(OMIcons.settingsEthernet),
                  title: Text(
                    'Dark Mode',
                    style: kDrawerItemStyle,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            padding: EdgeInsets.only(bottom: mapBottomPadding),
            mapType: MapType.normal,
            mapToolbarEnabled: true,
            myLocationButtonEnabled: true,
            initialCameraPosition: _kGooglePlex,
            myLocationEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            markers: _markers.values.toSet(),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              mapController = controller;
              setState(() {
                createmark();
                mapBottomPadding = (Platform.isAndroid) ? 280 : 270;
              });
              setupPositionLocator();
            },
          ),
          Positioned(
            top: 44,
            left: 20,
            child: GestureDetector(
              onTap: () {
                scaffoldKey.currentState.openDrawer();
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 5.0,
                        spreadRadius: 0.5,
                        offset: Offset(
                          0.7,
                          0.7,
                        ),
                      ),
                    ]),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 24,
                  child: Icon(
                    Icons.menu,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: searchSheetHeight,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 15.0,
                      spreadRadius: 0.5,
                      offset: Offset(
                        0.7,
                        0.7,
                      ),
                    )
                  ]),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Nice to see you king!',
                      style: TextStyle(
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      'What type of expert do you want?',
                      style: TextStyle(fontSize: 18, fontFamily: 'Brand-Bold'),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchPage(token:token)));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 5.0,
                                spreadRadius: 0.5,
                                offset: Offset(
                                  0.7,
                                  0.7,
                                ),
                              ),
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.search,
                                color: Colors.blueAccent,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text('Search Expert'),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    Row(
                      //Add home row
                      children: [
                        Icon(
                          OMIcons.home,
                          color: BrandColors.colorDimText,
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text((Provider.of<AppData>(context)
                            //             .meetingAddress) !=
                            //         null
                            //     ? Provider.of<AppData>(context)
                            //         .meetingAddress
                            //         .placeName
                            //     : 'Add home'),
                            Text('Add Home'),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              'Add your residential address',
                              style: TextStyle(
                                  fontSize: 11,
                                  color: BrandColors.colorDimText),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    BrandDivider(),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      //current location row
                      children: [
                        Icon(
                          OMIcons.myLocation,
                          color: BrandColors.colorDimText,
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 12,
                            ),
                            Text('Current location'),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              'Your current location',
                              style: TextStyle(
                                  fontSize: 11,
                                  color: BrandColors.colorDimText),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
