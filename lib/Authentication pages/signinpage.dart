import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shellcode2/Authentication pages/forgotpwd.dart';
import 'package:shellcode2/apiData/Constants.dart';
import 'package:shellcode2/apiData/OffersApiData.dart';
import 'package:shellcode2/colors.dart';
import 'package:shellcode2/home.dart';
import 'package:shellcode2/Authentication pages/signuppage.dart';
import 'package:shellcode2/main.dart';
import 'package:sign_button/sign_button.dart';
// import 'package:flutter_facebook_login/flutter_facebook_login.dart';
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
  // static final FacebookLogin facebookSignIn = new FacebookLogin();
  UserCredential userCredential;
  final phoneController = TextEditingController();
  String phoneNo = '';
  final pwController = TextEditingController();
  String password = '';
  bool authenticated = false;

  @override
  void initState() {
    super.initState();
    phoneNo = "";
    password = "";
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
                            keyboardType: TextInputType.number,
                            style: TextStyle(height: 1.5, color: Colors.purple),
                            cursorColor: Colors.purpleAccent,
                            decoration: InputDecoration(
                              hintText: "Mobile No",
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintStyle:
                                  Theme.of(context).textTheme.caption.copyWith(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
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
                            keyboardType: TextInputType.number,
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
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
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
                                color: Colors.purple[300], fontSize: 15),
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
                                  TextStyle(fontSize: 15, color: Colors.black),
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
                                    fontSize: 15, color: Colors.purple),
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
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.5),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () {},
                              child: Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.red),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Image.asset(
                                        'assets/google.png',
                                        scale: 1.5,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 8.0),
                                        child: Text("Google",
                                            style: TextStyle(fontSize: 15)),
                                      ),
                                    ]),
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.blue),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Image.asset(
                                        'assets/facebook.png',
                                        scale: 1.5,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          "Facebook",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      )
                                    ]),
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
                  top: 120,
                  left: 120,
                  child: Container(
                      height: 140,
                      width: 140,
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
    // String firebaseToken = await getToken();
    if ((password != null && phoneNo != null) &&
        (phoneController.text != "" && pwController.text != "")) {
      List<UserOfApp> userAccountData =
          await fetchLoginApiData(phoneNo, password);
      print(userAccountData);
      if (userAccountData == null) {
        authenticated = false;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Please try Again!!!")));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Login Successful")));
        authenticated = true;
        Provider.of<APIData>(context, listen: false)
            .initializeUser(userAccountData[0]);
        // SharedPreferences preferences = await SharedPreferences.getInstance();
        // updateFirebaseToken(firebaseToken,
        //     Provider.of<APIData>(context, listen: false).user.id);
        print(userAccountData[0].toJson());
        setUserData(key1, jsonEncode(userAccountData[0].toJson()));
        status = true;
        setLoginStatus(key2, status);
        print(authenticated);
        if (authenticated) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Home()));
        }
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Please try Again!!!")));
    }
  }

  Future<String> getToken() async {
    return await FirebaseMessaging.instance.getToken();
  }

  Future setLoginStatus(String key, bool status) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool(key, status);
  }

  Future setUserData(String key, String userData) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(key, userData);
  }

  void updateFirebaseToken(String token, String id) async {
    http.Response response;
    String url =
        "$header/app_api/updateFirebaseToken.php?token=$token&user_id=$id";
    Uri uri = Uri.parse(url);
    response = await http.get(uri);
    var jsonData = jsonDecode(response.body);
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

  Future<UserCredential> loginWithFacebook() async {
    final LoginResult loginResult = await FacebookAuth.instance.login();
    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken.token);
    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

  Future signInWithGoogle() async {
    // FirebaseAuth _auth = new FirebaseAuth.instanceFor(app: );
    GoogleSignIn _googleSignIn = new GoogleSignIn();
    FirebaseAuth _auth = FirebaseAuth.instance;
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    UserCredential user = await _auth.signInWithCredential(credential);
    return user;
  }
}
