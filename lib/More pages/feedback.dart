import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:shellcode2/Bottom%20bar%20pages/categories.dart';
import 'package:shellcode2/Bottom%20bar%20pages/wishlist.dart';
import 'package:shellcode2/Provider/data.dart';
import 'package:shellcode2/apiData/Constants.dart';
import '../colors.dart';
import '../home.dart';
import 'package:http/http.dart' as http;

class FeedBack extends StatefulWidget {
  String userId;
  List data;
  String orderId;
  FeedBack.totalOrder(
      {Key key,
      @required this.userId,
      @required this.data,
      @required this.orderId})
      : super(key: key);
  FeedBack.todaysOrder(
      {Key key,
      @required this.userId,
      @required this.data,
      @required this.orderId})
      : super(key: key);
  FeedBack.cancelledOrder(
      {Key key,
      @required this.userId,
      @required this.data,
      @required this.orderId})
      : super(key: key);

  @override
  _FeedBackState createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
  bool overAll = true;
  bool individual = false;
  String productId = "";
  String comment;
  List<TextEditingController> _controllers = [];
  TextEditingController overAllRating = new TextEditingController();
  TextEditingController individualRating = new TextEditingController();

  var currentText = TextStyle(color: Colors.white, fontWeight: FontWeight.w400);
  var anotherText = TextStyle(color: Colors.black, fontWeight: FontWeight.w400);
  var currentButton = TextButton.styleFrom(
      backgroundColor: left,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.fromLTRB(20, 2, 20, 2),
      side: BorderSide(color: Colors.black, width: 1));
  var anotherButton = TextButton.styleFrom(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.fromLTRB(20, 2, 20, 2),
      side: BorderSide(color: Colors.black, width: 1));

  double _initialRating = 0;
  IconData _selectedIcon;
  double _rating;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controllers.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        titleSpacing: 0.0,
        elevation: 0,
        //brightness: Brightness.light,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [left, middle, Colors.purple])),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, size: 20, color: yellow),
        ),
        title: Text(
          'Feedback',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 17,
            color: Colors.white,
          ),
        ),
      ),
      persistentFooterButtons: [
        Container(
          padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
          height: double.infinity,
          width: double.infinity,
          child: TextButton(
            onPressed: () {
              submitFeedback(productId);
            },
            child: Text(
              'SUBMIT',
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
            style: TextButton.styleFrom(
              backgroundColor: Colors.purple,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
        )
      ],
      bottomNavigationBar: Navigate(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            overAll
                ? Container(
                    margin: EdgeInsets.all(8),
                    color: Colors.white,
                    height: MediaQuery.of(context).size.height * 0.25,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Rate Your Experience',
                            style: TextStyle(
                                color: Colors.purple,
                                fontSize: 22,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(8, 8, 8, 20),
                          child: Text(
                            'Are you Satisfied with the Our Service OR Product',
                            style: TextStyle(
                                color: Colors.orange,
                                fontSize: 17,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                        RatingBar.builder(
                          initialRating: _initialRating,
                          minRating: 0,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          unratedColor: Colors.grey.shade300,
                          itemCount: 5,
                          itemSize: 50.0,
                          glow: false,
                          itemPadding: EdgeInsets.symmetric(horizontal: 4),
                          itemBuilder: (context, _) => Icon(
                            _selectedIcon ?? Icons.star,
                            color: Colors.purple,
                          ),
                          onRatingUpdate: (rating) {
                            setState(() {
                              _rating = rating;
                            });
                          },
                          updateOnDrag: true,
                        )
                      ],
                    ),
                  )
                : Container(),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
              child: Text(
                'Tell us what can be improved?',
                style: TextStyle(
                    color: Colors.purple,
                    fontSize: 19,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      overAll = true;
                      individual = false;
                    });
                  },
                  child: Text('Over all service',
                      style: overAll ? currentText : anotherText),
                  style: overAll ? currentButton : anotherButton,
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      overAll = false;
                      individual = true;
                    });
                  },
                  child: Text('Individual Product',
                      style: individual ? currentText : anotherText),
                  style: individual ? currentButton : anotherButton,
                ),
              ],
            ),
            overAll
                ? Padding(
                    padding: EdgeInsets.fromLTRB(20, 35, 20, 20),
                    child: TextField(
                      onTap: () {
                        productId = "";
                      },
                      controller: overAllRating,
                      maxLines: null,
                      style: TextStyle(color: Colors.purple),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Enter your Own Feedback.....',
                        hintStyle:
                            TextStyle(color: Colors.orange, fontSize: 16),
                        contentPadding: EdgeInsets.fromLTRB(5, 10, 5, 50),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(width: 1, color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(width: 1, color: Colors.black),
                        ),
                      ),
                    ),
                  )
                : Container(),
            individual
                ? Container(
                    margin: EdgeInsets.all(30),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: widget.data.length,
                      itemBuilder: (context, index) {
                        _controllers.add(new TextEditingController());
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(5, 10, 5, 15),
                              child: Text(
                                widget.data[index].productName,
                                style: TextStyle(
                                    color: Colors.purple,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            RatingBar.builder(
                              initialRating: _initialRating,
                              minRating: 0,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              unratedColor: Colors.grey.shade300,
                              itemCount: 5,
                              itemSize: 40,
                              glow: false,
                              itemBuilder: (context, _) => Icon(
                                _selectedIcon ?? Icons.star,
                                color: Colors.purple,
                              ),
                              onRatingUpdate: (rating) {
                                setState(() {
                                  _rating = rating;
                                });
                              },
                              updateOnDrag: true,
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(5, 10, 5, 15),
                              child: TextField(
                                onTap: () {
                                  productId = widget.data[index].productId;
                                },
                                controller: _controllers[index],
                                onChanged: (value) {
                                  comment = _controllers[index].text;
                                },
                                maxLines: null,
                                style: TextStyle(color: Colors.purple),
                                decoration: InputDecoration(
                                  filled: true,
                                  isDense: true,
                                  fillColor: Colors.white,
                                  hintText: 'Enter feedback',
                                  hintStyle: TextStyle(
                                      color: Colors.orange, fontSize: 20),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    borderSide:
                                        BorderSide(width: 1, color: left),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    borderSide:
                                        BorderSide(width: 1, color: left),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }

  void submitFeedback(String productId) async {
    String userId = Provider.of<APIData>(context, listen: false).user.id;
    String orderID = widget.data[0].orderId;
    http.Response response;
    String url = "$header/app_api/addRating.php";
    Uri uri = Uri.parse(url);
    response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "feedback": [
          {
            "user_id": userId,
            "product_id": productId,
            "rating": _rating,
            "comment": overAll ? overAllRating.text : comment,
            "order_id": orderID
          }
        ]
      }),
    );
    var jsonData = jsonDecode(response.body);
    if (jsonData["code"] == "200") {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("User Feedback Submitted")));
    } else if (jsonData["code"] == "201") {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("User Already gave feedback")));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Something Went Wrong")));
    }
  }
}

// class Items {
//   final String itemName;

//   Items({this.itemName});
// }

// List<Items> dummyItem = [
//   Items(itemName: 'Elachi Banana 250 GM'),
//   Items(itemName: 'Tomato 250 GM'),
// ];

class Navigate extends StatefulWidget {
  const Navigate({Key key}) : super(key: key);

  @override
  _NavigateState createState() => _NavigateState();
}

class _NavigateState extends State<Navigate> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.transparent,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: BottomNavigationBar(
            backgroundColor: lightbg,
            //type: BottomNavigationBarType.fixed,
            selectedFontSize: 12,
            unselectedFontSize: 12,
            selectedItemColor: Colors.purple,
            unselectedItemColor: Colors.grey[500],
            showUnselectedLabels: true,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Home()));
                    },
                    child: Icon(Icons.home)),
                title: Text('Home'),
              ),
              BottomNavigationBarItem(
                icon: GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Category()));
                    },
                    child: Icon(Icons.list)),
                title: Text('Categories'),
              ),
              BottomNavigationBarItem(
                  icon: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Wishlist()));
                      },
                      child: Icon(CupertinoIcons.heart)),
                  title: Text('Wishlist')),
            ],
          ),
        ));
  }
}
