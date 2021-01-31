import 'package:experttrack/brand-colors.dart';
import 'package:experttrack/datamodels/prediction.dart';
import 'package:experttrack/helpers/api.dart';
import 'package:experttrack/screens/detailprofile.dart';
import 'package:experttrack/widgets/BrandDivider.dart';
import 'package:experttrack/widgets/PredictionTile.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  final token;
  SearchPage({Key key, this.token}) : super(key: key);
  @override
  _SearchPageState createState() => _SearchPageState(token:token);
}

class _SearchPageState extends State<SearchPage> {
  final token;
  _SearchPageState({Key key, this.token});
  var searchController = TextEditingController();

  var focusSearch = FocusNode();

  bool focused = false;
  void setFocus() {
    if (!focused) {
      FocusScope.of(context).requestFocus(focusSearch);
      focused = true;
    }
  }

  List<Prediction> expertPredictionList = [];
  //auto search mode func
  void searchExpert(String query) async {
    //print(query);
    if (query.length > 1) {

      var response = await AuthService.searchresult(token, query);
      if (response != null) {
        var resultJson = response['result'];
        var thisList =
            (resultJson as List).map((e) => Prediction.fromJson(e)).toList();
        setState(() {
          expertPredictionList = thisList;
        });
        print(response);
        return response;
      }

    }
  }
  //end of search

  @override
  Widget build(BuildContext context) {
    setFocus();
    // String address = Provider.of<AppData>(context).meetingAddress.placeName ??
    //''; // ?? checks for null
    // searchController.text = address;
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 166,
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 5.0,
                spreadRadius: 0.5,
                offset: Offset(
                  0.7,
                  0.5,
                ),
              ),
            ]),
            child: Padding(
              padding:
                  EdgeInsets.only(left: 24, top: 48, right: 24, bottom: 20),
              child: Column(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Stack(
                    children: [
                      GestureDetector(
                        child: Icon(Icons.arrow_back),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      Center(
                        child: Text(
                          'Search Expert',
                          style:
                              TextStyle(fontSize: 20, fontFamily: 'Brand-Bold'),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  Row(
                    children: [
                      // Image.asset('images/pickicon.png',height: 16,width: 16,),
                      // InkWell(
                      //   child: Icon(Icons.build_outlined,
                      //       size: 18.0, color: Colors.green),
                      // ),
                      new SizedBox(
                          height: 16,
                          width: 16,
                          child: Icon(
                            Icons.build_outlined,
                            color: Colors.green,
                          )),
                      SizedBox(
                        width: 18,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: BrandColors.colorLightGray,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(2.0),
                            child: TextField(
                              onChanged: (value) {
                                searchExpert(value);
                              },
                              focusNode: focusSearch,
                              controller: searchController,
                              decoration: InputDecoration(
                                hintText: 'name, profession, skill',
                                fillColor: BrandColors.colorLightGrayFair,
                                filled: true,
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.only(
                                    left: 10, top: 8, bottom: 8),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
          (expertPredictionList.length > 0)
              ? Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: GestureDetector(
                    child: ListView.separated(
                      padding: EdgeInsets.all(0),
                      itemBuilder: (context, index) {
                        return PredictionTile(
                          prediction: expertPredictionList[index],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          BrandDivider(),
                      itemCount: expertPredictionList.length,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                    ),
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
                )
              : Container(),
        ],
      ),
    );
  }
}
