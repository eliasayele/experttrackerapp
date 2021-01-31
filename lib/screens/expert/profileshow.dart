import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatelessWidget {
  static final String path = "lib/src/pages/profile/profile4.dart";
  final String token;
  ProfilePage({Key key, this.token}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          "Profile",
          style: TextStyle(color: Colors.black, fontSize: 20.0),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.edit_rounded,
              color: Colors.black54,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 10.0),
            _buildHeader(),
            Container(
              margin: const EdgeInsets.all(16.0),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(color: Colors.grey.shade200),
              child: Column(
                children: [
                  Text(
                      "Over 8+ years of experience and web development and 5+ years of experience in mobile applications development "),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.blue,
                        size: 24.0,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.blue,
                        size: 24.0,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.blue,
                        size: 24.0,
                      ),
                      Icon(
                        Icons.star_half,
                        color: Colors.blue,
                        size: 24.0,
                      ),
                      Icon(
                        Icons.star_border,
                        color: Colors.blue,
                        size: 24.0,
                      )
                    ],
                  ),
                ],
              ),
            ),
            _buildTitle("Skills"),
            SizedBox(height: 10.0),
            _buildSkillRow("Wordpress", 0.75),
            SizedBox(height: 5.0),
            _buildSkillRow("Laravel", 0.6),
            SizedBox(height: 5.0),
            _buildSkillRow("React JS", 0.65),
            SizedBox(height: 5.0),
            _buildSkillRow("Flutter", 0.5),
            SizedBox(height: 30.0),
            _buildTitle("Experience"),
            _buildExperienceRow(
                company: "Ethio Soft",
                position: "Php Developer",
                duration: "2010 - 2012"),
            _buildExperienceRow(
                company: "Bena Tech",
                position: "Laravel Developer",
                duration: "2012 - 2015"),
            _buildExperienceRow(
                company: "Softnet ",
                position: "Web Developer",
                duration: "2015 - 2018"),
            _buildExperienceRow(
                company: "Expert Tracker Pvt. Ltd.",
                position: "Flutter Developer",
                duration: "2018 - Current"),
            SizedBox(height: 20.0),
            _buildTitle("Education"),
            SizedBox(height: 5.0),
            _buildExperienceRow(
                company: "Wolkite University, Eth",
                position: "B.Sc. Software Engineering",
                duration: "2009 - 2013"),
            _buildExperienceRow(
                company: "Wolkite University, Eth",
                position: "A Level",
                duration: "2008 - 2010"),
            _buildExperienceRow(
                company: "Addis Abeba",
                position: "junier dev",
                duration: "2008"),
            SizedBox(height: 20.0),
            _buildTitle("Contact"),
            SizedBox(height: 5.0),
            Row(
              children: <Widget>[
                SizedBox(width: 30.0),
                Icon(
                  Icons.mail,
                  color: Colors.black54,
                ),
                SizedBox(width: 10.0),
                Text(
                  "eliasflutter@gmail.com",
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              children: <Widget>[
                SizedBox(width: 30.0),
                Icon(
                  Icons.phone,
                  color: Colors.black54,
                ),
                SizedBox(width: 10.0),
                Text(
                  "+251-918427804",
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
            _buildSocialsRow(),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }

  Row _buildSocialsRow() {
    return Row(
      children: <Widget>[
        SizedBox(width: 20.0),
        IconButton(
          color: Colors.indigo,
          icon: Icon(FontAwesomeIcons.facebookF),
          onPressed: () {
            _launchURL("facebook.com/elias.ayele.319/");
          },
        ),
        SizedBox(width: 5.0),
        IconButton(
          color: Colors.indigo,
          icon: Icon(FontAwesomeIcons.github),
          onPressed: () {
            _launchURL("https://github.com/eliasayele");
          },
        ),
        SizedBox(width: 5.0),
        IconButton(
          color: Colors.red,
          icon: Icon(FontAwesomeIcons.youtube),
          onPressed: () {
            _launchURL("youtube.com/channel/UCVioYQK7Xz6TYWkn_a1CeiQ");
          },
        ),
        SizedBox(width: 10.0),
      ],
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  ListTile _buildExperienceRow(
      {String company, String position, String duration}) {
    return ListTile(
      leading: Padding(
        padding: const EdgeInsets.only(top: 8.0, left: 20.0),
        child: Icon(
          FontAwesomeIcons.solidCircle,
          size: 12.0,
          color: Colors.black54,
        ),
      ),
      title: Text(
        company,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      subtitle: Text("$position ($duration)"),
    );
  }

  Row _buildSkillRow(String skill, double level) {
    return Row(
      children: <Widget>[
        SizedBox(width: 16.0),
        Expanded(
            flex: 2,
            child: Text(
              skill.toUpperCase(),
              textAlign: TextAlign.right,
            )),
        SizedBox(width: 10.0),
        Expanded(
          flex: 5,
          child: LinearProgressIndicator(
            value: level,
          ),
        ),
        SizedBox(width: 16.0),
      ],
    );
  }

  Widget _buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title.toUpperCase(),
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          Divider(
            color: Colors.black54,
          ),
        ],
      ),
    );
  }

  Row _buildHeader() {
    return Row(
      children: <Widget>[
        SizedBox(width: 20.0),
        Container(
            width: 80.0,
            height: 80.0,
            child: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.grey,
                child: CircleAvatar(
                    radius: 35.0,
                    backgroundImage: CachedNetworkImageProvider(
                        'https://res.cloudinary.com/expert-tracker/image/upload/v1609260805/photo5983544056929694458_rxlhvp.jpg')))),
        SizedBox(width: 20.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Elias Ayele",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text("Full Stack Developer"),
            SizedBox(height: 5.0),
            Row(
              children: <Widget>[
                Icon(
                  FontAwesomeIcons.map,
                  size: 12.0,
                  color: Colors.black54,
                ),
                SizedBox(width: 10.0),
                Text(
                  "Wolkite, Ethiopia",
                  style: TextStyle(color: Colors.black54),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
