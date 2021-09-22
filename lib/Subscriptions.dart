import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shellcode2/colors.dart';

class Subscriptions extends StatefulWidget {
  Subscriptions({Key key}) : super(key: key);

  @override
  _SubscriptionsState createState() => _SubscriptionsState();
}

class _SubscriptionsState extends State<Subscriptions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Subscriptions"),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [left, middle, Colors.purple])),
        ),
      ),
      body: Container(),
    );
  }
}
