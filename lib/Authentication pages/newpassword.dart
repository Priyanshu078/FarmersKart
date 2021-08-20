import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shellcode2/Authentication%20pages/otpverification.dart';
import 'package:shellcode2/colors.dart';
import 'package:sms_autofill/sms_autofill.dart';

class NewPassword extends StatefulWidget {
  final String phoneNo;
  NewPassword({Key key, @required this.phoneNo}) : super(key: key);

  @override
  _NewPasswordState createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  TextEditingController _password = new TextEditingController();
  TextEditingController _confirmPassword = new TextEditingController();
  String password = "";
  String confirmPassword = "";
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
                    'Change Password',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.all(40),
                child: Column(
                  children: [
                    Text(
                      'Enter new Password',
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    SizedBox(
                      height: 20,
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
                        controller: _password,
                        style: TextStyle(height: 1.5, color: Colors.purple),
                        cursorColor: Colors.purpleAccent,
                        decoration: InputDecoration(
                          hintText: "new password",
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
                        onChanged: (value) => password = value,
                      ), //fontSize: 12,color: tertiaryColor,fontWeight: FontWeight.w400,
                    ),
                    SizedBox(
                      height: 20,
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
                        controller: _confirmPassword,
                        style: TextStyle(height: 1.5, color: Colors.purple),
                        cursorColor: Colors.purpleAccent,
                        decoration: InputDecoration(
                          hintText: "confirm password",
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
                        onChanged: (value) => confirmPassword = value,
                      ), //fontSize: 12,color: tertiaryColor,fontWeight: FontWeight.w400,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              if (password == confirmPassword) {
                                String phoneNo = widget.phoneNo;
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          OtpVerification.phone(
                                              phoneNo: phoneNo,
                                              password: password)),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          "Both password fields should match")),
                                );
                              }
                            },
                            child: Text(
                              'Change Password',
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
        ),
      ),
    );
  }
}
