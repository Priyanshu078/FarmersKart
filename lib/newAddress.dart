import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shellcode2/Provider/data.dart';
import 'package:shellcode2/apiData/Constants.dart';
import 'package:shellcode2/apiData/cartApiData.dart';
import 'package:shellcode2/apiData/centers.dart';
import 'package:shellcode2/apiData/loginApiData.dart';
import 'colors.dart';

class NewAddress extends StatefulWidget {
  const NewAddress({Key key}) : super(key: key);

  @override
  _NewAddressState createState() => _NewAddressState();
}

class _NewAddressState extends State<NewAddress> {
  String societyName = "";
  String flatNo = "";
  String wing = "";
  String address = "";
  String pincode = "";

  TextEditingController societyNameController = new TextEditingController();
  TextEditingController flatNoController = new TextEditingController();
  TextEditingController wingController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController pincodeController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        titleSpacing: 0.0,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [left, middle, Colors.purple])),
        ),
        title: Text(
          'Add New Address',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 17,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              color: Colors.white,
              height: 50,
              child: Text(
                'ADD NEW ADDRESS',
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
              child: Text(
                'ADDRESS',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.purple),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Container(
                  alignment: Alignment.center,
                  color: Colors.white,
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      TextField(
                        controller: societyNameController,
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text(
                                    "Select Society Name",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  content: Container(
                                    height: MediaQuery.of(context).size.height,
                                    child: FutureBuilder(
                                        future: getAllCenters(),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return Container(
                                                child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                TextField(
                                                  decoration: InputDecoration(
                                                      hintText: ""),
                                                ),
                                                Container(
                                                  height: MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          3 /
                                                          4 -
                                                      100,
                                                  child: ListView.builder(
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      shrinkWrap: true,
                                                      itemCount:
                                                          snapshot.data.length,
                                                      itemBuilder:
                                                          (context, int index) {
                                                        return InkWell(
                                                          onTap: () {
                                                            String centerName =
                                                                snapshot
                                                                    .data[index]
                                                                    .centerName;
                                                            String address =
                                                                snapshot
                                                                    .data[index]
                                                                    .address;
                                                            String pincode =
                                                                snapshot
                                                                    .data[index]
                                                                    .pincode;
                                                            societyNameController
                                                                    .text =
                                                                centerName;
                                                            addressController
                                                                .text = address;
                                                            pincodeController
                                                                .text = pincode;
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: ListTile(
                                                            title: Text(snapshot
                                                                .data[index]
                                                                .centerName),
                                                          ),
                                                        );
                                                      }),
                                                ),
                                              ],
                                            ));
                                          } else if (snapshot.hasError) {
                                            print(snapshot.error);
                                          } else {
                                            return Container();
                                          }
                                          return Container();
                                        }),
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("Close"))
                                  ],
                                );
                              },
                              barrierDismissible: false);
                        },
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              borderSide:
                                  BorderSide(width: 2, color: Colors.black),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              borderSide:
                                  BorderSide(width: 2, color: Colors.black),
                            ),
                            labelText: 'Society Name*',
                            labelStyle: TextStyle(
                                color: Colors.orange,
                                fontSize: 18,
                                fontWeight: FontWeight.w400)),
                      ),
                      SizedBox(height: 20),
                      TextField(
                        controller: flatNoController,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              borderSide:
                                  BorderSide(width: 2, color: Colors.black),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              borderSide:
                                  BorderSide(width: 2, color: Colors.black),
                            ),
                            labelText: 'Flat No*',
                            labelStyle: TextStyle(
                                color: Colors.orange,
                                fontSize: 18,
                                fontWeight: FontWeight.w400)),
                      ),
                      SizedBox(height: 20),
                      TextField(
                        controller: wingController,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              borderSide:
                                  BorderSide(width: 2, color: Colors.black),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              borderSide:
                                  BorderSide(width: 2, color: Colors.black),
                            ),
                            labelText: 'Wing*',
                            labelStyle: TextStyle(
                                color: Colors.orange,
                                fontSize: 18,
                                fontWeight: FontWeight.w400)),
                      ),
                      SizedBox(height: 20),
                      TextField(
                        controller: addressController,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              borderSide:
                                  BorderSide(width: 2, color: Colors.black),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              borderSide:
                                  BorderSide(width: 2, color: Colors.black),
                            ),
                            labelText: 'Address*',
                            labelStyle: TextStyle(
                                color: Colors.orange,
                                fontSize: 18,
                                fontWeight: FontWeight.w400)),
                      ),
                      SizedBox(height: 20),
                      TextField(
                        controller: pincodeController,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              borderSide:
                                  BorderSide(width: 2, color: Colors.black),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              borderSide:
                                  BorderSide(width: 2, color: Colors.black),
                            ),
                            labelText: 'Pin Code*',
                            labelStyle: TextStyle(
                                color: Colors.orange,
                                fontSize: 18,
                                fontWeight: FontWeight.w400)),
                      ),
                    ],
                  )),
            ),
            Container(
              color: Colors.amberAccent.shade700,
              alignment: Alignment.center,
              height: 60,
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.95,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.purple,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () {
                    print(addressController.text);
                    Provider.of<APIData>(context, listen: false)
                        .initializeAddress(addressController.text);
                    updateAddress();
                  },
                  child: Text(
                    'ADD ADDRESS',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 17,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<List> getAllCenters() async {
    http.Response response;
    String url = "$header/app_api/getAllCenters.php";
    Uri uri = Uri.parse(url);
    response = await http.get(uri);
    var jsonData = jsonDecode(response.body);
    List centersData = [];
    if (jsonData["code"] == "200") {
      for (var item in jsonData["center"]) {
        Centers centers = new Centers(
            item["center_name"],
            item["address"],
            item["pincode"],
            item["del_flag"],
            item["delivery_days"],
            item["delivery_time"]);
        centersData.add(centers);
      }
    }
    return centersData;
  }

  void updateAddress() async {
    String userId = Provider.of<APIData>(context, listen: false).user.id;
    String centerId =
        Provider.of<APIData>(context, listen: false).user.centerId;
    String societyName = societyNameController.text;
    String flatNo = flatNoController.text;
    String wing = wingController.text;
    String address = addressController.text;
    String pincode = pincodeController.text;
    http.Response response;
    String url =
        "$header/app_api/updateUserAddress.php?center_name=$societyName&flat_no=$flatNo&wing=$wing&address=$address&pincode=$pincode&user_id=$userId&center_id=$centerId";
    Uri uri = Uri.parse(url);
    response = await http.get(uri);
    var jsonData = jsonDecode(response.body);
    if (jsonData["code"] == "200") {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Address updated Successfully")));
      Navigator.pop(context);
    }
  }
}
