import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shellcode2/Authentication pages/forgotpwd.dart';
import 'package:shellcode2/colors.dart';
import 'package:shellcode2/home.dart';
import 'package:shellcode2/Authentication pages/signuppage.dart';
import 'package:sign_button/sign_button.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final phoneController = TextEditingController();
  String title1 ='';
  final pwController = TextEditingController();
  String title2 ='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightbg,
      body: Container(
          child:
          Stack(
            children: [
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 90,right: 90),
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80),),
                        gradient: LinearGradient(
                          colors: [left,middle,Colors.purple],
                        )
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: (){},
                          child: Text(
                            'SIGN IN', style: TextStyle(
                              color: yellow,
                              fontSize: 18
                          ),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Signup()));
                          },
                          child: Text(
                            'SIGN UP', style: TextStyle(
                              color: Colors.white,
                              fontSize: 18
                          ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top:60.0,right: 40.0,left: 40.0),
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
                            controller: phoneController,
                            style: TextStyle(
                                height: 1.5,color: Colors.purple
                            ),
                            cursorColor: Colors.purpleAccent,
                            decoration: InputDecoration(
                              hintText: "Your Phone Number",
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
                            controller: pwController,
                            style: TextStyle(
                                height: 1.5,color: Colors.purple
                            ),
                            cursorColor: Colors.purpleAccent,
                            decoration: InputDecoration(
                              hintText: "Password",
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
                            onChanged: (value) => title2 = value,
                          ), //fontSize: 12,color: tertiaryColor,fontWeight: FontWeight.w400,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPwd()));
                          },
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                                color: Colors.purple[300],
                                fontSize: 12
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children:[
                            Expanded(
                              child: ElevatedButton(
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
                                },
                                child: Text('LOG IN',style: TextStyle(color: Colors.white),),
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(Colors.purple[600]),
                                    padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 15)),
                                    textStyle: MaterialStateProperty.all(TextStyle(fontSize: 18))),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Don't Have Account ?",style: TextStyle(
                                fontSize: 12,
                                color: Colors.black
                            ),),
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Signup()));
                              },
                              child: Text(" SIGN UP NOW",style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.purple
                              ),),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(children: <Widget>[
                          Expanded(
                            child: Divider(
                              color: Colors.orange,
                            ),
                          ),
                          Text(" OR ",style: TextStyle(
                              fontSize: 14,
                              color: Colors.purple
                          ),),
                          Expanded(
                            child: Divider(
                              color: Colors.orange,
                            ),
                          ),
                        ]),
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text("Sign in with Social Media",style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                              letterSpacing: 0.5
                          ),),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SignInButton(
                                buttonType: ButtonType.google,
                                buttonSize: ButtonSize.small,
                                btnTextColor: Colors.black,
                                btnColor: bgcolor,
                                width: 120,
                                btnText: 'Google',
                                onPressed: () {
                                  print('click');
                                }),
                            SignInButton(
                                buttonType: ButtonType.facebook,
                                buttonSize: ButtonSize.small,
                                btnTextColor: Colors.black,
                                btnColor: bgcolor,
                                width: 120,
                                btnText: 'Facebook',
                                onPressed: () {
                                  print('click');
                                })
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Positioned(
                  top: 140,
                  left: 140,
                  child: Container(
                      height: 120,
                      width: 120,
                      child: Image.asset('assets/login.png',fit: BoxFit.cover,))),

            ],
          ),
      ),
    );
  }
}
