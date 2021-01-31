import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PostDetail extends StatelessWidget {
  static final String path = "lib/src/pages/blog/article1.dart";
  @override
  Widget build(BuildContext context) {
    String image =
        "https://res.cloudinary.com/expert-tracker/image/upload/v1609420435/scientificwebs-mobile-appli_f7citu.jpg";
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          "Post Detail",
          style: TextStyle(color: Colors.black, fontSize: 20.0),
        ),
        actions: <Widget>[
          //adding new post
          IconButton(
            color: Colors.black,
            icon: Icon(Icons.edit_rounded),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                    height: 300,
                    width: double.infinity,
                    child: CachedNetworkImage(
                      imageUrl: image,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                  Colors.lightGreen, BlendMode.softLight)),
                        ),
                      ),
                    )),
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 2.0, right: 8.0, top: 8.0, bottom: 8.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text("Oct 21, 2017"),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "Here is My Previous works",
                    style: Theme.of(context).textTheme.title,
                  ),
                  Divider(),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: <Widget>[
                      Icon(Icons.favorite_border),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text("20.2k"),
                      SizedBox(
                        width: 16.0,
                      ),
                      Icon(Icons.comment),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text("2.2k"),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "My name is Essayas Teshome, and I’m currently looking for a job in youth services. I have 10 years of experience working with youth agencies. I have a bachelor’s degree in outdoor education. I raise money, train leaders, and organize units. I have raised over \$100,000 each of the last six years. I consider myself a good public speaker, and I have a good sense of humor. “Who do you know who works with youth?",
                    textAlign: TextAlign.justify,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
