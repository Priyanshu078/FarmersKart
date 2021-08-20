import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shellcode2/Authentication pages/signuppage.dart';
import 'package:shellcode2/Authentication%20pages/signinpage.dart';
import 'package:shellcode2/colors.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:shellcode2/apiData/Constants.dart';

class OtpVerification extends StatefulWidget {
  String phoneNo;
  String name;
  String placeName;
  int flatNo;
  String wing;
  String address;
  int pincode;
  String password;
  int gstNo;
  String userType;

  OtpVerification({Key key}) : super(key: key);

  OtpVerification.phone(
      {Key key, @required this.phoneNo, @required this.password})
      : super(key: key);

  OtpVerification.society(
      {Key key,
      @required this.phoneNo,
      @required this.name,
      @required this.placeName,
      @required this.flatNo,
      @required this.wing,
      @required this.address,
      @required this.pincode,
      @required this.password,
      @required this.userType})
      : super(key: key);

  OtpVerification.shop(
      {Key key,
      @required this.phoneNo,
      @required this.name,
      @required this.placeName,
      @required this.address,
      @required this.pincode,
      @required this.gstNo,
      @required this.password,
      @required this.userType})
      : super(key: key);

  OtpVerification.hotel(
      {Key key,
      @required this.phoneNo,
      @required this.name,
      @required this.placeName,
      @required this.address,
      @required this.pincode,
      @required this.password,
      @required this.userType})
      : super(key: key);

  @override
  _OtpVerificationState createState() => _OtpVerificationState();
}

const String _heroAddTodo = 'add-todo-hero';

class _OtpVerificationState extends State<OtpVerification> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  final phoneController = TextEditingController();
  String phoneNumber = '';
  String verificationID = "";
  String smsCode = "";
  UserCredential _userCredential;
  int resendtoken = 0;
  String firebaseToken = "";
  bool loading = false;
  bool registered = false;
  String message = "";

  @override
  void initState() {
    verifyPhoneNumber();
    _listenOtp();
    super.initState();
  }

  Future<String> getToken() async {
    return await FirebaseMessaging.instance.getToken();
  }

  void verifyPhoneNumber() async {
    phoneNumber = '+91' + widget.phoneNo;
    firebaseToken = await getToken();
    try {
      await firebaseAuth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {
            showSnackBar("Verification Completed");
          },
          verificationFailed: (FirebaseAuthException exception) {
            showSnackBar(exception.toString());
          },
          codeSent: (String verificationId, int resendToken) {
            showSnackBar("OTP sent to your Phone Number");
            setState(() {
              verificationID = verificationId;
              resendtoken = resendToken;
            });
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            showSnackBar("Time out");
          });
    } catch (e) {
      showSnackBar(e.toString());
    }
  }

  void showSnackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
  }

  Future<void> signInWithPhoneNumber(
      String verificationID, String smsCode) async {
    try {
      AuthCredential authCredential = PhoneAuthProvider.credential(
          verificationId: verificationID, smsCode: smsCode);
      _userCredential = await firebaseAuth.signInWithCredential(authCredential);
      showSnackBar("Phone Number Verified");
    } catch (e) {
      showSnackBar(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightbg,
      body: SingleChildScrollView(
        child: Container(
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(80),
                        ),
                        gradient: LinearGradient(
                          colors: [left, middle, Colors.purple],
                        )),
                    child: Center(
                      child: Text(
                        'OTP Verification',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    padding: EdgeInsets.all(40),
                    child: Column(
                      children: [
                        Text(
                          'Enter the OTP sent to Your Number',
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 50, vertical: 10),
                            child: PinFieldAutoFill(
                              decoration: UnderlineDecoration(
                                  colorBuilder:
                                      FixedColorBuilder(Colors.purple)),
                              codeLength: 6,
                              onCodeChanged: (val) {
                                smsCode = val;
                              },
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Din't Receive the OTP ?",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.black),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Text(
                                " RESEND OTP",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.purple),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  signInWithPhoneNumber(
                                      verificationID, smsCode);
                                  print("firebase Token : $firebaseToken");
                                  if (widget.userType != null) {
                                    registerUser();
                                  } else {
                                    updatePassword();
                                  }
                                  Navigator.of(context).push(HeroDialogRoute(
                                      builder: (context) {
                                        return _AddTodoPopupCard(
                                          registered: registered,
                                          message: message,
                                        );
                                      },
                                      settings:
                                          ModalRoute.of(context).settings));
                                },
                                child: Text(
                                  'VERIFY & PROCEED',
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
                ],
              ),
              Positioned(
                  top: 140,
                  left: 140,
                  child: Container(
                      height: 120,
                      width: 120,
                      child: Image.asset(
                        'assets/otp_image.png',
                        fit: BoxFit.cover,
                      ))),
            ],
          ),
        ),
      ),
    );
  }

  void registerUser() async {
    setState(() {
      loading = true;
    });
    String name = widget.name;
    String email = " default email";
    String phoneNo = widget.phoneNo;
    String password = widget.password;
    String userType = widget.userType;
    String societyName;
    if (userType == 'Society') {
      societyName = widget.placeName;
    } else {
      societyName = "";
    }
    int flatNo = widget.flatNo;
    String wing = widget.wing;
    String address = widget.address;
    int pincode = widget.pincode;
    int gstNo = widget.gstNo;
    String from = 'App';
    http.Response response;
    String url =
        "$header/app_api/register.php?name=$name&email=$email&mobile=$phoneNo&password=$password&society_name=$societyName&flat_no=$flatNo&wing=$wing&address=$address&pincode=$pincode&gst_no=$gstNo&user_type=$userType&from=$from&firebase_token=$firebaseToken";
    var uri = Uri.parse(url);

    try {
      response = await http.get(uri, headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      });
    } catch (e) {
      print(e);
    }
    var jsonData = jsonDecode(response.body);
    if (jsonData['code'] == 200) {
      setState(() {
        registered = true;
      });
    } else {
      setState(() {
        message = jsonData['msg'];
      });
      print(jsonData['msg']);
    }
    setState(() {
      loading = false;
    });
  }

  void updatePassword() async {
    http.Response response;
    String phoneNo = widget.phoneNo;
    String password = widget.password;
    Uri url = Uri.parse(
        "$header/app_api/updatePassword.php?mobile_no=$phoneNo&password=$password");
    response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    print(jsonData);
    if (jsonData["code"] == "200") {
      showSnackBar("Password changed successfully");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => SignIn()));
    } else {
      showSnackBar("Something Went Wrong");
    }
  }
}

void _listenOtp() async {
  await SmsAutoFill().listenForCode;
}

class HeroDialogRoute<T> extends PageRoute<T> {
  /// {@macro hero_dialog_route}
  HeroDialogRoute({
    @required WidgetBuilder builder,
    @required RouteSettings settings,
    bool fullscreenDialog = false,
  })  : _builder = builder,
        super(settings: settings, fullscreenDialog: fullscreenDialog);

  final WidgetBuilder _builder;

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  bool get maintainState => true;

  @override
  Color get barrierColor => Colors.black54;

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return child;
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return _builder(context);
  }

  @override
  String get barrierLabel => 'Popup dialog open';
}

class _AddTodoPopupCard extends StatefulWidget {
  final bool registered;
  final String message;
  _AddTodoPopupCard({
    Key key,
    @required this.registered,
    @required this.message,
  }) : super(key: key);
  @override
  __AddTodoPopupCardState createState() => __AddTodoPopupCardState();
}

class __AddTodoPopupCardState extends State<_AddTodoPopupCard> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Hero(
          tag: _heroAddTodo,
          child: Material(
            color: lightbg,
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.checkmark_circle_fill,
                          color: Colors.green,
                        ),
                        Text(
                          ' Registered Successfully!',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Dear customer, Thank you for registering with us, your account is pending approval and you will be notified once it is approved.',
                      style: TextStyle(
                          height: 1.5,
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Signup()));
                      },
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          'OK',
                          style: TextStyle(
                              height: 1.5,
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
