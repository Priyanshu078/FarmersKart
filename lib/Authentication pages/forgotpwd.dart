import 'package:flutter/material.dart';
import 'package:shellcode2/Authentication%20pages/otpverification.dart';
import 'package:shellcode2/colors.dart';
import 'package:sms_autofill/sms_autofill.dart';

class ForgotPwd extends StatefulWidget {
  const ForgotPwd({Key? key}) : super(key: key);

  @override
  _ForgotPwdState createState() => _ForgotPwdState();
}

class _ForgotPwdState extends State<ForgotPwd> {
  final phoneController = TextEditingController();
  String title1 ='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightbg,
      body: Container(
        child: Column(
          children:[
            Container(
              width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80),),
                gradient: LinearGradient(
                  colors: [left,middle,Colors.purple],
                )
            ),
            child:
                Center(
                  child: Text(
                    'OTP Verification', style: TextStyle(
                      color: Colors.white,
                      fontSize: 18
                  ),
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
                    'Enter Your Mobile Number', style: TextStyle(color: Colors.black,fontSize: 18),
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
                      controller: phoneController,
                      style: TextStyle(
                        height: 1.5,color: Colors.purple
                      ),
                      cursorColor: Colors.purpleAccent,
                      decoration: InputDecoration(

                        hintText: "Mobile Number",
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintStyle: Theme.of(context).textTheme.caption!.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: yellow, // Set Your Own Color
                        ),
                      ),
                      onChanged: (value) => title1 = value,
                    ), //fontSize: 12,color: tertiaryColor,fontWeight: FontWeight.w400,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children:[
                      Expanded(
                        child: ElevatedButton(
                          onPressed: ()async{
                            final signcode = await SmsAutoFill().getAppSignature;
                            Navigator.push(context, MaterialPageRoute(builder: (context) => OtpVerification()));                          },
                          child: Text('PROCEED',style: TextStyle(color: Colors.white),),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.purple[600]),
                              padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 15)),
                              textStyle: MaterialStateProperty.all(TextStyle(fontSize: 18))),
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
    );
  }
}
