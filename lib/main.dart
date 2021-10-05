import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shellcode2/firstpage.dart';
import 'package:provider/provider.dart';
import 'package:shellcode2/Provider/data.dart';
import 'package:flutter/cupertino.dart';

final RouteObserver<PageRoute> routeObserver = new RouteObserver<PageRoute>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => APIData(),
      child: MaterialApp(
        navigatorObservers: <NavigatorObserver>[routeObserver],
        debugShowCheckedModeBanner: false,
        home: FrontPage(),
      ),
    );
  }
}
