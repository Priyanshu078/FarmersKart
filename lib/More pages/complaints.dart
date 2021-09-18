import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shellcode2/Bottom%20bar%20pages/categories.dart';
import 'package:shellcode2/Bottom%20bar%20pages/wishlist.dart';
import 'package:shellcode2/Provider/data.dart';
import 'package:shellcode2/apiData/Constants.dart';
import 'package:shellcode2/apiData/loginApiData.dart';
import '../colors.dart';
import '../home.dart';
import 'package:http/http.dart' as http;

class Complaints extends StatefulWidget {
  String orderID;
  List productsOrder;
  Complaints({Key key, @required this.orderID, @required this.productsOrder})
      : super(key: key);

  @override
  _ComplaintsState createState() => _ComplaintsState();
}

class _ComplaintsState extends State<Complaints> {
  Dio dio = new Dio();
  bool overAll = true;
  bool individual = false;
  String productId = "";
  List productOrderList = [];
  // var id = "a6ecMO";
  final ImagePicker _picker = ImagePicker();
  XFile pic;
  TextEditingController complaintsController = new TextEditingController();

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

  List _items = ['Select Product'];
  String _selected;

  void add() {
    productOrderList = widget.productsOrder;
    for (var item in productOrderList) {
      _items.add(item.productName);
    }
    print(_items);
  }

  @override
  void initState() {
    super.initState();
    add();
  }

  String getProductId() {
    for (int i = 0; i < productOrderList.length; i++) {
      String productID = "";
      if (_selected == productOrderList[i].productName) {
        return productOrderList[i].productId;
      }
    }
    return productId;
  }

  void sendComplaint(BuildContext context) async {
    String userId = Provider.of<APIData>(context, listen: false).userId;
    Response complaintResponse;
    FormData formData;
    String url = "$header/app_api/addUserCompaint.php?apicall=uploadpic";
    if (pic != null) {
      formData = new FormData.fromMap({
        "user_id": userId,
        "image_name": pic.name,
        "product_id": overAll ? "" : getProductId(),
        "complaints_text": complaintsController.text,
        "order_id": widget.orderID,
        "pic": await MultipartFile.fromFile(pic.path, filename: pic.name)
      });
    } else {
      formData = new FormData.fromMap({
        "user_id": userId,
        "image_name": "",
        "product_id": overAll ? "" : getProductId(),
        "complaints_text": complaintsController.text,
        "order_id": widget.orderID,
      });
    }
    complaintResponse = await dio.post(url,
        data: formData,
        options: Options(
            method: 'POST',
            responseType: ResponseType.json,
            headers: {
              "Accept": "application/json",
              "Content-Type": "multipart/form-data"
            }));
    // var jsonData = jsonDecode(complaintResponse.data);
    if (complaintResponse.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Complaint Submitted Successfully")));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Something Went Wrong")));
    }
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
          'Complaints',
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
              sendComplaint(context);
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
            Padding(
              padding: EdgeInsets.fromLTRB(15, 10, 0, 20),
              child: Text(
                'Tell us what can be improved?',
                style: TextStyle(
                    color: Colors.purple,
                    fontSize: 18,
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
            Container(
              height: MediaQuery.of(context).size.height * 0.58,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              margin: EdgeInsets.fromLTRB(15, 15, 15, 15),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(12, 5, 8, 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        individual
                            ? Padding(
                                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black, width: 2),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Flexible(
                                    child: DropdownButton(
                                      isDense: true,
                                      hint: Text('Select Product',
                                          style: TextStyle(
                                              color: left,
                                              fontSize: 17,
                                              fontWeight: FontWeight.w400)),
                                      underline: Container(),
                                      value: _selected,
                                      style: TextStyle(
                                          color: left,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                      onChanged: (newValue) {
                                        setState(() {
                                          _selected = newValue;
                                        });
                                      },
                                      items: _items.map((items) {
                                        return DropdownMenuItem(
                                          child: Flexible(child: Text(items)),
                                          value: items,
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              )
                            : Spacer(),
                        individual ? Spacer() : Container(),
                        Column(
                          children: [
                            IconButton(
                              icon: Icon(Icons.camera_alt_rounded),
                              iconSize: 50,
                              onPressed: () {
                                setState(() {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return SimpleDialog(
                                          title: Text("Select image from"),
                                          children: [
                                            SimpleDialogOption(
                                              child: Text("Photo Gallery",
                                                  style:
                                                      TextStyle(fontSize: 16)),
                                              onPressed: () async {
                                                XFile tempImage =
                                                    await _picker.pickImage(
                                                        source: ImageSource
                                                            .gallery);
                                                setState(() {
                                                  pic = tempImage;
                                                });
                                                Navigator.pop(context);
                                              },
                                            ),
                                            SimpleDialogOption(
                                              child: Text("Camera",
                                                  style:
                                                      TextStyle(fontSize: 16)),
                                              onPressed: () async {
                                                XFile tempImage =
                                                    await _picker.pickImage(
                                                        source:
                                                            ImageSource.camera);
                                                setState(() {
                                                  pic = tempImage;
                                                });
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        );
                                      });
                                });
                              },
                            ),
                            Text(
                              'ID: ${widget.orderID}',
                              style: TextStyle(color: Colors.orange),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  pic != null
                      ? Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 40, vertical: 20),
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.50,
                              height: MediaQuery.of(context).size.height * 0.25,
                              decoration: BoxDecoration(),
                              child: Image.file(
                                File(pic.path),
                                filterQuality: FilterQuality.high,
                                scale: 1,
                              ),
                            ),
                          ),
                        )
                      : SizedBox(
                          height: MediaQuery.of(context).size.height * 0.32),
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: TextField(
                        controller: complaintsController,
                        maxLines: null,
                        style: TextStyle(color: Colors.purple),
                        decoration: InputDecoration(
                          isDense: true,
                          hintText: 'Enter your Complaints & \nFeedback.....',
                          hintStyle:
                              TextStyle(color: Colors.orange, fontSize: 20),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide:
                                BorderSide(width: 2, color: Colors.purple),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide:
                                BorderSide(width: 2, color: Colors.purple),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Items {
  final String itemName;

  Items({this.itemName});
}

List<Items> dummyItem = [
  Items(itemName: 'Banana'),
  Items(itemName: 'Tomato'),
];

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
