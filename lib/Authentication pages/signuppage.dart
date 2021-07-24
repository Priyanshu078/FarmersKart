import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shellcode2/Authentication%20pages/SocietyShopHotels.dart';
import 'package:shellcode2/colors.dart';
import 'package:shellcode2/Authentication%20pages/signinpage.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final phoneController = TextEditingController();
  String title1 ='';
  final pwController = TextEditingController();
  String title2 ='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightbg,
      body: Container(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 90,right: 90),
              height: 200,
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
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SignIn()));
                    },
                    child: Text(
                      'SIGN IN', style: TextStyle(
                        color: Colors.white,
                        fontSize: 18
                    ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){},
                    child: Text(
                      'SIGN UP', style: TextStyle(
                        color: yellow,
                        fontSize: 18
                    ),
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
                          fontSize: 12,
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
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => SSH(0)));
                              },
                              child: CircleAvatar(
                              foregroundImage: AssetImage('assets/bg.jpg'),
                                maxRadius: 35,
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text('SOCIETY', style: TextStyle(color: Colors.black,fontSize: 12),)
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => SSH(1)));
                              },
                              child: CircleAvatar(
                                foregroundImage: AssetImage('assets/bg.jpg'),
                                maxRadius: 35,
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text('SHOP', style: TextStyle(color: Colors.black,fontSize: 12),)
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => SSH(3)));
                              },
                              child: CircleAvatar(
                                foregroundImage: AssetImage('assets/bg.jpg'),
                                maxRadius: 35,
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text('HOTELS', style: TextStyle(color: Colors.black,fontSize: 12),)
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children:[
                      Expanded(
                        child: ElevatedButton(
                          onPressed: null,
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
            )

          ],
        ),
      ),
    );
  }
}
