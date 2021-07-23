import 'package:flutter/material.dart';
import 'package:shellcode2/firstpage.dart';
import 'package:shellcode2/home.dart';
import 'package:shellcode2/Authentication%20pages/signinpage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignIn(),
    );
  }
}