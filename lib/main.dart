import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shellcode2/firstpage.dart';
import 'package:shellcode2/home.dart';
import 'package:shellcode2/Authentication%20pages/signinpage.dart';
import 'package:provider/provider.dart';
import 'package:shellcode2/Provider/data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (context)=>APIData(),
      child:  MaterialApp(
        debugShowCheckedModeBanner: false,
        home: FrontPage(),
      ),
    );

  }
}
