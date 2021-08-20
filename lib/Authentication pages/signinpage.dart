import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shellcode2/Authentication pages/forgotpwd.dart';
import 'package:shellcode2/apiData/OffersApiData.dart';
import 'package:shellcode2/colors.dart';
import 'package:shellcode2/home.dart';
import 'package:shellcode2/Authentication pages/signuppage.dart';
import 'package:sign_button/sign_button.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shellcode2/apiData/loginApiData.dart';
import 'package:shellcode2/Provider/data.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  static final FacebookLogin facebookSignIn = new FacebookLogin();
  UserCredential userCredential;
  final phoneController = TextEditingController();
  String phoneNo = '';
  final pwController = TextEditingController();
  String password = '';
  bool authenticated = false;

  @override
  void initState() {
    super.initState();
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
                    padding: EdgeInsets.only(left: 80, right: 80),
                    height: 200,
                    width: double.infinity,
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
                          onTap: () {},
                          child: Text(
                            'SIGN IN',
                            style: TextStyle(color: yellow, fontSize: 18),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Signup()));
                          },
                          child: Text(
                            'SIGN UP',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.only(top: 60.0, right: 30.0, left: 30.0),
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
                            style: TextStyle(height: 1.5, color: Colors.purple),
                            cursorColor: Colors.purpleAccent,
                            decoration: InputDecoration(
                              hintText: "Your Phone Number",
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
                            onChanged: (value) => phoneNo = value,
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
                            onChanged: (value) => password = value,
                          ), //fontSize: 12,color: tertiaryColor,fontWeight: FontWeight.w400,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ForgotPwd()));
                          },
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                                color: Colors.purple[300], fontSize: 12),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () async {
                                  await Login();
                                },
                                child: Text(
                                  'LOG IN',
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
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Don't Have Account ?",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.black),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Signup()));
                              },
                              child: Text(
                                " SIGN UP NOW",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.purple),
                              ),
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
                          Text(
                            " OR ",
                            style:
                                TextStyle(fontSize: 14, color: Colors.purple),
                          ),
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
                          child: Text(
                            "Sign in with Social Media",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                                letterSpacing: 0.5),
                          ),
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
                                width: 100,
                                btnText: 'Google',
                                onPressed: () {
                                  builder();
                                }),
                            SignInButton(
                                buttonType: ButtonType.facebook,
                                buttonSize: ButtonSize.small,
                                btnTextColor: Colors.black,
                                btnColor: bgcolor,
                                width: 120,
                                btnText: 'Facebook',
                                onPressed: () {
                                  loginWithFacebook();
                                }),
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
                        'assets/login.png',
                        fit: BoxFit.cover,
                      ))),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> Login() async {
    print(phoneNo);
    print(password);
    if (password != null && phoneNo != null) {
      List<UserOfApp> userAccountData =
          await fetchLoginApiData(phoneNo, password);
      print(userAccountData);
      if (userAccountData == null)
        authenticated = false;
      else {
        authenticated = true;
        Provider.of<UserAccountDetails>(context, listen: false)
            .initializeUser(userAccountData[0]);
        print(authenticated);
        if (authenticated) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Home()));
        }
      }
    }
  }

  Widget builder() {
    return FutureBuilder(
        future: signInWithGoogle(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Signup()),
              );
            } else if (snapshot.hasError) {
              print("GoogleSignin Error");
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }
          return Center(child: CircularProgressIndicator());
        });
  }

  Future<Null> loginWithFacebook() async {
    final FacebookLoginResult result = await facebookSignIn.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final FacebookAccessToken accessToken = result.accessToken;
        print('''
         Logged in!

         Token: ${accessToken.token}
         User id: ${accessToken.userId}
         Expires: ${accessToken.expires}
         Permissions: ${accessToken.permissions}
         Declined permissions: ${accessToken.declinedPermissions}
         ''');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Signup()));
        break;
      case FacebookLoginStatus.cancelledByUser:
        print('Login cancelled by the user.');
        break;
      case FacebookLoginStatus.error:
        print('Something went wrong with the login process.\n'
            'Here\'s the error Facebook gave us: ${result.errorMessage}');
        break;
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
