import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shellcode2/Authentication%20pages/otpverification.dart';
import 'package:shellcode2/colors.dart';
import 'dart:convert';
import 'package:shellcode2/filter.dart';
import 'package:http/http.dart' as http;

class SSH extends StatefulWidget {
  final int index;
  final String phoneNo;
  SSH({Key key, @required this.index, @required this.phoneNo})
      : super(key: key);

  @override
  _SSHState createState() => _SSHState();
}

class _SSHState extends State<SSH> {
  String phoneNo = "";
  String name = "";
  int flatNo = 0;
  String wing = "";
  String address = "";
  int pincode = 0;
  String password = "";
  String confirmPassword = "";
  int gstNo = 0;
  bool loading = false;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final phoneController1 = TextEditingController();
  final phoneController2 = TextEditingController();
  final phoneController3 = TextEditingController();
  final phoneController4 = TextEditingController();
  final phoneController5 = TextEditingController();
  final phoneController6 = TextEditingController();
  final phoneController7 = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    phoneNo = "";
    name = "";
    flatNo = 0;
    wing = "";
    address = "";
    pincode = 0;
    password = "";
    confirmPassword = "";
    gstNo = 0;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightbg,
      appBar: AppBar(
        centerTitle: true,
        titleSpacing: 0.0,
        elevation: 0,
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [left, middle, Colors.purple])),
        ),
        title: widget.index == 0
            ? Text(
                'Society',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                  color: Colors.white,
                ),
              )
            : widget.index == 1
                ? Text(
                    'Shop',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  )
                : Text(
                    'Hotel',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
      ),
      body: Container(
        child: widget.index == 0
            ? Container(
                padding: EdgeInsets.only(left: 30, right: 30, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                          controller: phoneController1,
                          style: TextStyle(height: 1.5, color: Colors.purple),
                          cursorColor: Colors.purpleAccent,
                          decoration: InputDecoration(
                            hintText: "Society Name",
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintStyle:
                                Theme.of(context).textTheme.caption.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: yellow, // Set Your Own Color
                                    ),
                          ),
                          onChanged: (value) {
                            name = value;
                          }), //fontSize: 12,color: tertiaryColor,fontWeight: FontWeight.w400,
                    ),
                    SizedBox(
                      height: 10,
                    ),
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
                        controller: phoneController2,
                        style: TextStyle(height: 1.5, color: Colors.purple),
                        cursorColor: Colors.purpleAccent,
                        decoration: InputDecoration(
                          hintText: "Flat No",
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintStyle:
                              Theme.of(context).textTheme.caption.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: yellow, // Set Your Own Color
                                  ),
                        ),
                        onChanged: (value) {
                          flatNo = int.parse(value);
                        },
                      ), //fontSize: 12,color: tertiaryColor,fontWeight: FontWeight.w400,
                    ),
                    SizedBox(
                      height: 10,
                    ),
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
                        controller: phoneController3,
                        style: TextStyle(height: 1.5, color: Colors.purple),
                        cursorColor: Colors.purpleAccent,
                        decoration: InputDecoration(
                          hintText: "Wing",
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintStyle:
                              Theme.of(context).textTheme.caption.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: yellow, // Set Your Own Color
                                  ),
                        ),
                        onChanged: (value) {
                          wing = value;
                        },
                      ), //fontSize: 12,color: tertiaryColor,fontWeight: FontWeight.w400,
                    ),
                    SizedBox(
                      height: 10,
                    ),
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
                        controller: phoneController4,
                        style: TextStyle(height: 1.5, color: Colors.purple),
                        cursorColor: Colors.purpleAccent,
                        decoration: InputDecoration(
                          hintText: "Address / Area",
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintStyle:
                              Theme.of(context).textTheme.caption.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: yellow, // Set Your Own Color
                                  ),
                        ),
                        onChanged: (value) {
                          address = value;
                        },
                      ), //fontSize: 12,color: tertiaryColor,fontWeight: FontWeight.w400,
                    ),
                    SizedBox(
                      height: 10,
                    ),
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
                        controller: phoneController5,
                        style: TextStyle(height: 1.5, color: Colors.purple),
                        cursorColor: Colors.purpleAccent,
                        decoration: InputDecoration(
                          hintText: "Pincode",
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintStyle:
                              Theme.of(context).textTheme.caption.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: yellow, // Set Your Own Color
                                  ),
                        ),
                        onChanged: (value) {
                          pincode = int.parse(value);
                        },
                      ), //fontSize: 12,color: tertiaryColor,fontWeight: FontWeight.w400,
                    ),
                    SizedBox(
                      height: 10,
                    ),
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
                        controller: phoneController6,
                        style: TextStyle(height: 1.5, color: Colors.purple),
                        cursorColor: Colors.purpleAccent,
                        decoration: InputDecoration(
                          hintText: "Password",
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintStyle:
                              Theme.of(context).textTheme.caption.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: yellow, // Set Your Own Color
                                  ),
                        ),
                        onChanged: (value) {
                          password = value;
                        },
                      ), //fontSize: 12,color: tertiaryColor,fontWeight: FontWeight.w400,
                    ),
                    SizedBox(
                      height: 10,
                    ),
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
                        controller: phoneController7,
                        style: TextStyle(height: 1.5, color: Colors.purple),
                        cursorColor: Colors.purpleAccent,
                        decoration: InputDecoration(
                          hintText: "Confirm Password",
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintStyle:
                              Theme.of(context).textTheme.caption.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: yellow, // Set Your Own Color
                                  ),
                        ),
                        onChanged: (value) {
                          confirmPassword = value;
                        },
                      ), //fontSize: 12,color: tertiaryColor,fontWeight: FontWeight.w400,
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              phoneNo = widget.phoneNo;
                              if (confirmPassword != password) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          "Both password fields do not match")),
                                );
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            OtpVerification.society(
                                              phoneNo: phoneNo,
                                              name: name,
                                              flatNo: flatNo,
                                              wing: wing,
                                              address: address,
                                              pincode: pincode,
                                              password: password,
                                              userType: "Society",
                                            )));
                              }
                              print(
                                  "$name,$flatNo,$wing, $address, $pincode,$phoneNo, $password");
                            },
                            child: Text(
                              'SUBMIT',
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
            : widget.index == 1
                ? Container(
                    padding: EdgeInsets.only(left: 30, right: 30, top: 10),
                    child: Column(
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
                              controller: phoneController2,
                              style:
                                  TextStyle(height: 1.5, color: Colors.purple),
                              cursorColor: Colors.purpleAccent,
                              decoration: InputDecoration(
                                hintText: "Shop Name",
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: yellow, // Set Your Own Color
                                    ),
                              ),
                              onChanged: (value) {
                                name = value;
                              }), //fontSize: 12,color: tertiaryColor,fontWeight: FontWeight.w400,
                        ),
                        SizedBox(
                          height: 10,
                        ),
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
                            controller: phoneController3,
                            style: TextStyle(height: 1.5, color: Colors.purple),
                            cursorColor: Colors.purpleAccent,
                            decoration: InputDecoration(
                              hintText: "Address / Area",
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintStyle:
                                  Theme.of(context).textTheme.caption.copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: yellow, // Set Your Own Color
                                      ),
                            ),
                            onChanged: (value) {
                              address = value;
                            },
                          ), //fontSize: 12,color: tertiaryColor,fontWeight: FontWeight.w400,
                        ),
                        SizedBox(
                          height: 10,
                        ),
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
                            controller: phoneController4,
                            style: TextStyle(height: 1.5, color: Colors.purple),
                            cursorColor: Colors.purpleAccent,
                            decoration: InputDecoration(
                              hintText: "Pincode",
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintStyle:
                                  Theme.of(context).textTheme.caption.copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: yellow, // Set Your Own Color
                                      ),
                            ),
                            onChanged: (value) {
                              pincode = int.parse(value);
                            },
                          ), //fontSize: 12,color: tertiaryColor,fontWeight: FontWeight.w400,
                        ),
                        SizedBox(
                          height: 10,
                        ),
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
                            controller: phoneController5,
                            style: TextStyle(height: 1.5, color: Colors.purple),
                            cursorColor: Colors.purpleAccent,
                            decoration: InputDecoration(
                              hintText: "GST No",
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintStyle:
                                  Theme.of(context).textTheme.caption.copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: yellow, // Set Your Own Color
                                      ),
                            ),
                            onChanged: (value) {
                              gstNo = int.parse(value);
                            },
                          ), //fontSize: 12,color: tertiaryColor,fontWeight: FontWeight.w400,
                        ),
                        SizedBox(
                          height: 10,
                        ),
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
                            controller: phoneController6,
                            style: TextStyle(height: 1.5, color: Colors.purple),
                            cursorColor: Colors.purpleAccent,
                            decoration: InputDecoration(
                              hintText: "Password",
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintStyle:
                                  Theme.of(context).textTheme.caption.copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: yellow, // Set Your Own Color
                                      ),
                            ),
                            onChanged: (value) {
                              password = value;
                            },
                          ), //fontSize: 12,color: tertiaryColor,fontWeight: FontWeight.w400,
                        ),
                        SizedBox(
                          height: 10,
                        ),
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
                            controller: phoneController7,
                            style: TextStyle(height: 1.5, color: Colors.purple),
                            cursorColor: Colors.purpleAccent,
                            decoration: InputDecoration(
                              hintText: "Confirm Password",
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintStyle:
                                  Theme.of(context).textTheme.caption.copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: yellow, // Set Your Own Color
                                      ),
                            ),
                            onChanged: (value) {
                              confirmPassword = value;
                            },
                          ), //fontSize: 12,color: tertiaryColor,fontWeight: FontWeight.w400,
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  phoneNo = widget.phoneNo;
                                  if (confirmPassword != password) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              "Both password fields do not match")),
                                    );
                                  } else {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                OtpVerification.shop(
                                                  phoneNo: phoneNo,
                                                  name: name,
                                                  address: address,
                                                  pincode: pincode,
                                                  gstNo: gstNo,
                                                  password: password,
                                                  userType: "Shop",
                                                )));
                                  }
                                  print(
                                      "$name, $address, $gstNo, $pincode ,$phoneNo, $password");
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
                : Container(
                    padding: EdgeInsets.only(left: 30, right: 30, top: 10),
                    child: Column(
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
                              controller: phoneController2,
                              style:
                                  TextStyle(height: 1.5, color: Colors.purple),
                              cursorColor: Colors.purpleAccent,
                              decoration: InputDecoration(
                                hintText: "Hotel Name",
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: yellow, // Set Your Own Color
                                    ),
                              ),
                              onChanged: (value) {
                                name = value;
                              }), //fontSize: 12,color: tertiaryColor,fontWeight: FontWeight.w400,
                        ),
                        SizedBox(
                          height: 10,
                        ),
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
                            controller: phoneController3,
                            style: TextStyle(height: 1.5, color: Colors.purple),
                            cursorColor: Colors.purpleAccent,
                            decoration: InputDecoration(
                              hintText: "Address / Area",
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintStyle:
                                  Theme.of(context).textTheme.caption.copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: yellow, // Set Your Own Color
                                      ),
                            ),
                            onChanged: (value) {
                              address = value;
                            },
                          ), //fontSize: 12,color: tertiaryColor,fontWeight: FontWeight.w400,
                        ),
                        SizedBox(
                          height: 10,
                        ),
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
                            controller: phoneController4,
                            style: TextStyle(height: 1.5, color: Colors.purple),
                            cursorColor: Colors.purpleAccent,
                            decoration: InputDecoration(
                              hintText: "Pincode",
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintStyle:
                                  Theme.of(context).textTheme.caption.copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: yellow, // Set Your Own Color
                                      ),
                            ),
                            onChanged: (value) {
                              pincode = int.parse(value);
                            },
                          ), //fontSize: 12,color: tertiaryColor,fontWeight: FontWeight.w400,
                        ),
                        SizedBox(
                          height: 10,
                        ),
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
                            controller: phoneController6,
                            style: TextStyle(height: 1.5, color: Colors.purple),
                            cursorColor: Colors.purpleAccent,
                            decoration: InputDecoration(
                              hintText: "Password",
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintStyle:
                                  Theme.of(context).textTheme.caption.copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: yellow, // Set Your Own Color
                                      ),
                            ),
                            onChanged: (value) {
                              password = value;
                            },
                          ), //fontSize: 12,color: tertiaryColor,fontWeight: FontWeight.w400,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        MaterialButton(
                          minWidth: double.infinity,
                          height: 50,
                          onPressed: () {},
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
                              controller: phoneController7,
                              style:
                                  TextStyle(height: 1.5, color: Colors.purple),
                              cursorColor: Colors.purpleAccent,
                              decoration: InputDecoration(
                                hintText: "Confirm Password",
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: yellow, // Set Your Own Color
                                    ),
                              ),
                              onChanged: (value) {
                                confirmPassword = value;
                              }), //fontSize: 12,color: tertiaryColor,fontWeight: FontWeight.w400,
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  phoneNo = widget.phoneNo;
                                  if (confirmPassword != password) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              "Both password fields do not match")),
                                    );
                                  } else {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                OtpVerification.hotel(
                                                  phoneNo: phoneNo,
                                                  name: name,
                                                  address: address,
                                                  pincode: pincode,
                                                  password: password,
                                                  userType: "Hotel",
                                                )));
                                  }
                                  print(
                                      "$name, $address, $pincode,$phoneNo, $password");
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
                  ),
      ),
    );
  }

  void getdata() async {
    setState(() {
      loading = true;
    });
    // var queryParameters = {
    //   'param1': 'one',
    //   'param2': 'two',
    // };
    var response;
    var uri = Uri.http('192.168.43.156', '/app_api/getAllCategories.php');
    try {
      response = await http.get(uri);
    } catch (e) {
      print(e);
    }
    var jsondata = jsonDecode(response.body);
    print(jsondata);
    setState(() {
      loading = false;
    });
  }
}
