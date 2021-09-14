import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shellcode2/apiData/Constants.dart';
import 'package:shellcode2/apiData/allProducts.dart';
import 'package:shellcode2/apiData/loginApiData.dart';
import 'package:shellcode2/colors.dart';
import 'package:http/http.dart' as http;

class Search extends StatefulWidget {
  const Search({Key key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final phoneController = TextEditingController();
  String title1 = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(),
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
            } else if (snapshot.hasError) {
              print(snapshot.error);
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
