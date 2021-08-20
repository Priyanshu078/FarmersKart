import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shellcode2/Authentication%20pages/SocietyShopHotels.dart';
import 'package:shellcode2/apiData/Constants.dart';
import 'package:shellcode2/colors.dart';
import 'package:shellcode2/Authentication%20pages/signinpage.dart';
import 'package:http/http.dart' as http;

class Signup extends StatefulWidget {
  const Signup({Key key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final phoneController = TextEditingController();
  String phoneNumber = '';
  final pwController = TextEditingController();
  String title2 = '';
  int index = 0;
  String iconChange = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightbg,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(left: 90, right: 90),
                height: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(80),
                    ),
                    gradient: LinearGradient(
                      colors: [left, middle, Colors.purple],
                    )),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => SignIn()));
                      },
                      child: Text(
                        'SIGN IN',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        'SIGN UP',
                        style: TextStyle(color: yellow, fontSize: 18),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    MaterialButton(
                      minWidth: double.infinity,
                      height: 50,
                      onPressed: null,
                      //() {
                      // Navigator.push(context,
                      //   MaterialPageRoute(builder: (context) => login2()));
                      //},
                      color: bgcolor,
                      elevation: 0,
                      disabledColor: bgcolor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: phoneController,
                        style: TextStyle(height: 1.5, color: Colors.purple),
                        cursorColor: Colors.purpleAccent,
                        decoration: InputDecoration(
                          hintText: "Mobile Number",
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintStyle:
                              Theme.of(context).textTheme.caption.copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: yellow, // Set Your Own Color
                                  ),
                        ),
                        onChanged: (value) => phoneNumber = value,
                      ), //fontSize: 12,color: tertiaryColor,fontWeight: FontWeight.w400,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Divider(
                      color: Colors.greenAccent[400],
                      thickness: 1,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    index = 0;
                                    iconChange = "Society";
                                  });
                                },
                                child: CircleAvatar(
                                  child: iconChange == "Society"
                                      ? Icon(
                                          Icons.house,
                                          size: 30,
                                        )
                                      : Image.asset('assets/bg.jpg'),
                                  radius: 35,
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                'SOCIETY',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 12),
                              )
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    index = 1;
                                    iconChange = "Shop";
                                  });
                                },
                                child: CircleAvatar(
                                  child: iconChange == "Shop"
                                      ? Icon(
                                          Icons.store,
                                          size: 30,
                                        )
                                      : Image.asset('assets/bg.jpg'),
                                  maxRadius: 35,
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                'SHOP',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 12),
                              )
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    index = 2;
                                    iconChange = "Hotels";
                                  });
                                },
                                child: CircleAvatar(
                                  child: iconChange == "Hotels"
                                      ? Icon(
                                          Icons.hotel,
                                          size: 30,
                                        )
                                      : Image.asset('assets/bg.jpg'),
                                  maxRadius: 35,
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                'HOTELS',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 12),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              bool userExist = await checkIfUserExist();
                              if (userExist) {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text(
                                      "Mobile Number Already Registered",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    content: Text(
                                      "You are already registered with us login now",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        SignIn()));
                                          },
                                          child: Text(
                                            "OK",
                                            style: TextStyle(fontSize: 15),
                                          ))
                                    ],
                                    elevation: 20,
                                  ),
                                  barrierDismissible: false,
                                );
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SSH(
                                            index: index,
                                            phoneNo: phoneNumber)));
                              }
                              print(phoneNumber);
                            },
                            child: Text(
                              'PROCEED',
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.purple[600]),
                                padding: MaterialStateProperty.all(
                                    EdgeInsets.symmetric(vertical: 15)),
                                textStyle: MaterialStateProperty.all(
                                    TextStyle(fontSize: 18))),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> checkIfUserExist() async {
    http.Response response;
    String uri = "$header/app_api/checkUserExist.php?mobile=$phoneNumber";
    Uri url = Uri.parse(uri);
    response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    bool userExist = false;
    if (jsonData["code"] == "200") {
      userExist = true;
    } else {
      userExist = false;
    }
    return userExist;
  }
}
