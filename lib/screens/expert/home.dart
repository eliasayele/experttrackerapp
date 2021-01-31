import 'dart:async';

import 'package:experttrack/screens/expert/chatui.dart';
import 'package:experttrack/screens/expert/mappage.dart';
import 'package:experttrack/screens/expert/post.dart';
import 'package:experttrack/screens/expert/profileshow.dart';
import 'package:flutter/material.dart';

class FancyBottomBarPage extends StatefulWidget {
  static final String path = "../../string/navybar.dart";
  final String token;

  FancyBottomBarPage({Key key, this.token}) : super(key: key);
  @override
  _FancyBottomBarPageState createState() =>
      _FancyBottomBarPageState(token: token);
}

class _FancyBottomBarPageState extends State<FancyBottomBarPage> {
  final String token;
  _FancyBottomBarPageState({this.token});

  // var profession,
  //     city,
  //     address,
  //     skills,
  //     company,
  //     bio,
  //     rate,
  //     facebook,
  //     youtube,
  //     instagram,
  //     githubusername,
  //     avatar,
  //     twitter,
  //     linkedin,
  //     website,
  //     name;
  // void fetchProfile() async {
  //   showDialog(
  //     barrierDismissible: false,
  //     context: context,
  //     builder: (BuildContext context) => ProgressDialog(
  //       status: 'Fetching Profile',
  //     ),
  //   );
  //
  //   try {
  //     Response response = await AuthService.getProfileById(token);
  //
  //     if (response.statusCode == 200) {
  //       if (response.data['name'] != null) name = response.data['name'];
  //       if (response.data['profession'] != null)
  //         profession = response.data['profession'];
  //       if (response.data['website'] != null)
  //         website = response.data['website'];
  //       if (response.data['city'] != null) city = response.data['city'];
  //       if (response.data['rate'] != null) rate = response.data['rate'];
  //       if (response.data['skills'] != null) skills = response.data['skills'];
  //       if (response.data['bio'] != null) bio = response.data['bio'];
  //       if (response.data['avatar'] != null) avatar = response.data['avatar'];
  //       if (response.data['address'] != null)
  //         address = response.data['address'];
  //       if (response.data['company'] != null)
  //         company = response.data['company'];
  //       if (response.data['social']['facebook'] != null)
  //         facebook = response.data['social']['facebook'];
  //       if (response.data['social']['youtube'] != null)
  //         youtube = response.data['social']['youtube'];
  //       if (response.data['social']['instagram'] != null)
  //         instagram = response.data['social']['instagram'];
  //       if (response.data['social']['twitter'] != null)
  //         twitter = response.data['social']['twitter'];
  //       if (response.data['social']['linkedin'] != null)
  //         linkedin = response.data['social']['linkedin'];
  //
  //       // Fluttertoast.showToast(
  //       //     msg: 'Authenticated',
  //       //     toastLength: Toast.LENGTH_SHORT,
  //       //     gravity: ToastGravity.SNACKBAR,
  //       //     timeInSecForIosWeb: 1,
  //       //     backgroundColor: Colors.green,
  //       //     textColor: Colors.white,
  //       //     fontSize: 16.0);
  //       print('token begin');
  //       print(token);
  //       print('token end');
  //     }
  //   } catch (e) {
  //     //showSnackBar(e.toString());
  //     print(e.message);
  //   }
  // }

  @override
  void dispose() {
    indexcontroller.close();
    super.dispose();
  }

  PageController pageController = PageController(initialPage: 0);
  StreamController<int> indexcontroller = StreamController<int>.broadcast();
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          indexcontroller.add(index);
        },
        controller: pageController,
        children: <Widget>[
          Center(
            child: MapPage(token: token),
          ),
          Center(
            child: ProfilePage(token: token),
          ),
          Center(
            child: Posts(token: token),
          ),
          Center(
            child: ChatUi(),
          ),
        ],
      ),
      bottomNavigationBar: StreamBuilder<Object>(
          initialData: 0,
          stream: indexcontroller.stream,
          builder: (context, snapshot) {
            int cIndex = snapshot.data;
            return FancyBottomNavigation(
              currentIndex: cIndex,
              items: <FancyBottomNavigationItem>[
                FancyBottomNavigationItem(
                    icon: Icon(Icons.home_outlined), title: Text('Home')),
                FancyBottomNavigationItem(
                    icon: Icon(Icons.person_outline), title: Text('Profile')),
                FancyBottomNavigationItem(
                    icon: Icon(Icons.post_add_rounded), title: Text('Post')),
                FancyBottomNavigationItem(
                    icon: Icon(Icons.chat_bubble_outline),
                    title: Text('Inbox')),
              ],
              onItemSelected: (int value) {
                indexcontroller.add(value);
                pageController.jumpToPage(value);
              },
            );
          }),
    );
  }
}

class FancyBottomNavigation extends StatefulWidget {
  final int currentIndex;
  final double iconSize;
  final Color activeColor;
  final Color inactiveColor;
  final Color backgroundColor;
  final List<FancyBottomNavigationItem> items;
  final ValueChanged<int> onItemSelected;

  FancyBottomNavigation(
      {Key key,
      this.currentIndex = 0,
      this.iconSize = 24,
      this.activeColor,
      this.inactiveColor,
      this.backgroundColor,
      @required this.items,
      @required this.onItemSelected}) {
    assert(items != null);
    assert(onItemSelected != null);
  }

  @override
  _FancyBottomNavigationState createState() {
    return _FancyBottomNavigationState(
        items: items,
        backgroundColor: backgroundColor,
        currentIndex: currentIndex,
        iconSize: iconSize,
        activeColor: activeColor,
        inactiveColor: inactiveColor,
        onItemSelected: onItemSelected);
  }
}

class _FancyBottomNavigationState extends State<FancyBottomNavigation> {
  @override
  final int currentIndex;
  final double iconSize;
  Color activeColor;
  Color inactiveColor;
  Color backgroundColor;
  List<FancyBottomNavigationItem> items;
  int _selectedIndex;
  ValueChanged<int> onItemSelected;

  _FancyBottomNavigationState(
      {@required this.items,
      this.currentIndex,
      this.activeColor,
      this.inactiveColor = Colors.black,
      this.backgroundColor,
      this.iconSize,
      @required this.onItemSelected}) {
    _selectedIndex = currentIndex;
  }

  Widget _buildItem(FancyBottomNavigationItem item, bool isSelected) {
    return AnimatedContainer(
      width: isSelected ? 124 : 50,
      height: double.maxFinite,
      duration: Duration(milliseconds: 250),
      padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              color: activeColor,
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.all(0),
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: IconTheme(
                  data: IconThemeData(
                      size: iconSize,
                      color: isSelected ? backgroundColor : inactiveColor),
                  child: item.icon,
                ),
              ),
              isSelected
                  ? DefaultTextStyle.merge(
                      style: TextStyle(color: backgroundColor),
                      child: item.title,
                    )
                  : SizedBox.shrink()
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    activeColor =
        (activeColor == null) ? Theme.of(context).accentColor : activeColor;
    activeColor = Colors.green;
    backgroundColor = (backgroundColor == null)
        ? Theme.of(context).bottomAppBarColor
        : backgroundColor;

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 56,
      padding: EdgeInsets.only(left: 8, right: 8, top: 6, bottom: 6),
      decoration: BoxDecoration(
          color: backgroundColor,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 2)]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: items.map((item) {
          var index = items.indexOf(item);
          return GestureDetector(
            onTap: () {
              onItemSelected(index);

              setState(() {
                _selectedIndex = index;
              });
            },
            child: _buildItem(item, _selectedIndex == index),
          );
        }).toList(),
      ),
    );
  }
}

class FancyBottomNavigationItem {
  final Icon icon;
  final Text title;

  FancyBottomNavigationItem({
    @required this.icon,
    @required this.title,
  }) {
    assert(icon != null);
    assert(title != null);
  }
}
