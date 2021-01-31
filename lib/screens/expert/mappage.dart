import 'dart:async';
import 'dart:io';

import 'package:experttrack/datamodels/experts.dart';
import 'package:experttrack/helpers/api.dart';
import 'package:experttrack/screens/detailprofile.dart';
import 'package:experttrack/screens/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  final String token;
  MapPage({Key key, this.token});
  @override
  _MapPageState createState() => _MapPageState(token: token);
}

class _MapPageState extends State<MapPage> {
  final String token;
  _MapPageState({this.token});

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  //for handling key and open drawer
  //double searchSheetHeight = (Platform.isIOS) ? 300 : 275;
  //check the platform for the sheet and this make look the same in android and ios

  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController mapController;
  double mapBottomPadding = 0;

  // var geoLocator = Geolocator();
  Position currentPosition;

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
    CameraPosition cp = new CameraPosition(target: pos, zoom: 13);
    mapController.animateCamera(CameraUpdate.newCameraPosition(cp));
    //street address implemented letter

    // String address = await HelperMethods.findCordinateAddress(position,context);
    // print(address);
  }

  static CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(8.9806, 38.7578),
    zoom: 14.4746,
  );
  Color col = Colors.black;
  Color col2 = Colors.white;
  bool status = false;
  List<Experts> expertPredictionList = [];
  //auto search mode func
  void searchExpert() async {
    //print(query);

    String tok = token;

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
  //this code loads all active cutomers and show them in the marker
  Future<void> createmark() async {
    //searchExpert();
    String tok = token;

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

  //make expert online by updating status field to true
  Future<void> makeOnline() async {
    final response = await AuthService.makeOnline(token);
    if (response != null) {
      Fluttertoast.showToast(
          msg: "You are now Online ready for accept request",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      setState(() {
        status = true;
        if (col == Colors.black) {
          col = Colors.green;
          col2 = Colors.green;
        } else {
          col = Colors.black;
          col2 = Colors.white;
        }
      });
      // var resultJson = response['profiles'];
      // var thisList =
      // (resultJson as List).map((e) => Experts.fromJson(e)).toList();
      // setState(() {
      //   expertPredictionList = thisList;
      // });
    } else {
      Fluttertoast.showToast(
          msg: "Try Again",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  //make expert offline by updating profile status field to false
  Future<void> makeOffline() async {
    final response = await AuthService.makeOffline(token);
    if (response != null) {
      setState(() {
        status = false;
        if (col == Colors.black) {
          col = Colors.green;
          col2 = Colors.green;
        } else {
          col = Colors.black;
          col2 = Colors.white;
        }
      });
      // var resultJson = response['profiles'];
      // var thisList =
      // (resultJson as List).map((e) => Experts.fromJson(e)).toList();
      // setState(() {
      //   expertPredictionList = thisList;
      // });
    } else {
      Fluttertoast.showToast(
          msg: "Try Again",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      // drawer: Container(
      //   width: 250,
      //   color: Color(0xFFE8F5E9),
      //   child: Drawer(
      //     child: Container(
      //       color: Color(0xFFE8F5E9),
      //       child: ListView(
      //         padding: EdgeInsets.all(0),
      //         children: [
      //           Container(
      //             color: Color(0xFFE8F5E9),
      //             height: 160,
      //             child: DrawerHeader(
      //               decoration: BoxDecoration(
      //                 color: Colors.lightGreen,
      //
      //               ),
      //               child: Row(
      //                 children: [
      //                   CircleAvatar(
      //                       radius: 40,
      //                       backgroundColor: Colors.blueGrey,
      //                       child: CircleAvatar(
      //                           radius: 35.0,
      //                           backgroundImage: CachedNetworkImageProvider(
      //                               avatar != null
      //                                   ? avatar
      //                                   : "https://res.cloudinary.com/expert-tracker/image/upload/v1609371504/expertbo_iy2uj5.png"))),
      //                   SizedBox(
      //                     width: 15,
      //                   ),
      //                   Column(
      //                     mainAxisAlignment: MainAxisAlignment.center,
      //                     children: [
      //                       Text(
      //                         name != null ? na : 'Name',
      //                         style: TextStyle(
      //                             fontSize: 19,
      //                             fontFamily: 'Brand-Bold',
      //                             color: Colors.black),
      //                       ),
      //                       SizedBox(
      //                         height: 5,
      //                       ),
      //                       Text(
      //                         'Customer',
      //                         style: TextStyle(
      //                             fontFamily: 'Brand-Bold',
      //                             color: Colors.black),
      //                       ),
      //                     ],
      //                   )
      //                 ],
      //               ),
      //             ),
      //           ),
      //           BrandDivider(),
      //           SizedBox(
      //             height: 10,
      //           ),
      //           //chat
      //           GestureDetector(
      //             child: ListTile(
      //               leading: Icon(OMIcons.chatBubbleOutline),
      //               title: Text(
      //                 'Inbox',
      //                 style: kDrawerItemStyle,
      //               ),
      //             ),
      //             onTap: () {
      //               Navigator.pop(context);
      //               Navigator.push(
      //                 context,
      //                 MaterialPageRoute(
      //                   builder: (context) => ChatUiCustomer(),
      //                   settings: RouteSettings(
      //                     arguments: widget.token,
      //                   ),
      //                 ),
      //               );
      //               //ExpertRegister();
      //             },
      //           ),
      //           //edit profile
      //           GestureDetector(
      //               child: ListTile(
      //                 leading: Icon(OMIcons.edit),
      //                 title: Text(
      //                   'Edit Profile',
      //                   style: kDrawerItemStyle,
      //                 ),
      //               ),
      //               onTap: () {
      //                 Navigator.pop(context);
      //                 Navigator.push(
      //                   context,
      //                   MaterialPageRoute(
      //                     builder: (context) => EditProfilePage(),
      //                   ),
      //                 );
      //               }),
      //           //be expert
      //           GestureDetector(
      //             child: ListTile(
      //               leading: Icon(OMIcons.workOutline),
      //               title: Text(
      //                 'Be Expert',
      //                 style: kDrawerItemStyle,
      //               ),
      //             ),
      //             onTap: () {
      //               Navigator.pop(context);
      //               Navigator.push(
      //                 context,
      //                 MaterialPageRoute(
      //                   builder: (context) => LandingOnePage(token: token),
      //                 ),
      //               );
      //               //ExpertRegister();
      //             },
      //           ),
      //           //nearby expert
      //           GestureDetector(
      //             child: ListTile(
      //               leading: Icon(OMIcons.nearMe),
      //               title: Text(
      //                 'Nearby Experts',
      //                 style: kDrawerItemStyle,
      //               ),
      //             ),
      //             onTap: () {
      //               Navigator.pop(context);
      //               Navigator.push(
      //                 context,
      //                 MaterialPageRoute(
      //                   builder: (context) => Posts(),
      //                   settings: RouteSettings(
      //                     arguments: widget.token,
      //                   ),
      //                 ),
      //               );
      //             },
      //           ),
      //           //History
      //           ListTile(
      //             leading: Icon(OMIcons.history),
      //             title: Text(
      //               'History',
      //               style: kDrawerItemStyle,
      //             ),
      //           ),
      //           //about
      //           GestureDetector(
      //               child: ListTile(
      //                 leading: Icon(OMIcons.settings),
      //                 title: Text(
      //                   'Setting',
      //                   style: kDrawerItemStyle,
      //                 ),
      //               ),
      //               onTap: () {
      //                 Navigator.push(
      //                   context,
      //                   MaterialPageRoute(
      //                     builder: (context) => SettingsPage(),
      //                     settings: RouteSettings(
      //                       arguments: widget.token,
      //                     ),
      //                   ),
      //                 );
      //               }),
      //
      //           GestureDetector(
      //             child: ListTile(
      //               leading: Icon(OMIcons.info),
      //               title: Text(
      //                 'About',
      //                 style: kDrawerItemStyle,
      //               ),
      //             ),
      //             onTap: () {
      //               Navigator.pop(context);
      //               Navigator.push(
      //                 context,
      //                 MaterialPageRoute(
      //                   builder: (context) => About(),
      //
      //                 ),
      //               );
      //               //
      //             },
      //           ),
      //           //logout
      //           GestureDetector(
      //             child: ListTile(
      //               leading: Icon(Icons.link_off),
      //               title: Text(
      //                 'Logout',
      //                 style: kDrawerItemStyle,
      //               ),
      //             ),
      //             onTap: () {
      //               Navigator.pop(context);
      //               Navigator.push(
      //                 context,
      //                 MaterialPageRoute(
      //                   builder: (context) => LoginPage(),
      //                 ),
      //               );
      //               //
      //             },
      //           ),
      //           //dark mode
      //           ListTile(
      //             leading: Icon(OMIcons.settingsEthernet),
      //             title: Text(
      //               'Dark Mode',
      //               style: kDrawerItemStyle,
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
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
                mapBottomPadding = (Platform.isAndroid) ? 0 : 0;
              });
              setupPositionLocator();
            },
          ),
          Positioned(
            top: 47,
            left: 20,
            child: GestureDetector(
              onTap: () {
                status == true ? makeOffline() : makeOnline();
              },
              child: Container(
                decoration: BoxDecoration(
                    color: col2,
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
                  radius: 26,
                  child: Icon(
                    Icons.online_prediction,
                    color: col,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 120,
            left: 20,
            child: GestureDetector(
              onTap: () {
                makeOffline();
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
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
                  radius: 26,
                  child: Icon(
                    Icons.logout,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
