import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shellcode2/Bottom bar pages/categories.dart';
import 'package:shellcode2/apiData/Constants.dart';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

String AllCategoriesApi = "$header/app_api/getAllCategories.php";

List<kategory> list;

Future<bool> fetchDataByDistrictApi() async {
  bool gotData = false;
  print('hey');
  http.Response response = await http.get(Uri.parse(AllCategoriesApi));

  if (response.statusCode == 200) {
    Map sessionsData = jsonDecode(response.body);
    List<dynamic> data = sessionsData['category'];

    list = data.map((json) => kategory.fromJson(json)).toList();

    for (int i = 0; i < list.length; i++) {
      category1.add(Categories(
          imageUrl: list[i].logo,
          title: list[i].name,
          subCategory: list[i].subcategory,
          categoryId: list[i].id));

      print(list[i].logo);
    }
    gotData = true;
  } else
    Exception(response.statusCode);

  return gotData;
}

class Categories {
  String imageUrl;
  String title;
  String subCategory;
  String categoryId;
  //String classTitle;
  Categories({
    @required this.imageUrl,
    @required this.title,
    @required this.subCategory,
    @required this.categoryId,
  });
}

List<Categories> category1 = [];

class Welcome {
  Welcome({
    this.category,
    this.code,
  });

  List<kategory> category;
  String code;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        category: List<kategory>.from(
            json["category"].map((x) => kategory.fromJson(x))),
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "category": List<dynamic>.from(category.map((x) => x.toJson())),
        "code": code,
      };
}

class kategory {
  kategory({
    this.id,
    this.name,
    this.delFlag,
    this.logo,
    this.subcategory,
  });

  String id;
  String name;
  String delFlag;
  String logo;
  String subcategory;

  factory kategory.fromJson(Map<String, dynamic> json) => kategory(
        id: json["id"],
        name: json["name"],
        delFlag: json["del_flag"],
        logo: json["logo"],
        subcategory: json["subcategory"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "del_flag": delFlag,
        "logo": logo,
        "subcategory": subcategory,
      };
}
