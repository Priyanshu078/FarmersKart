import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shellcode2/apiData/Constants.dart';

Future<String> addUserFav(String id, String productId) async {
  print(
      "$header/app_api/addUserFavourites.php?user_id=$id&product_id=$productId");

  http.Response response = await http.get(Uri.parse(
      "$header/app_api/addUserFavourites.php?user_id=$id&product_id=$productId"));

  if (response.statusCode == 200) {
    Map apiData = jsonDecode(response.body);
    String message = apiData['msg'];

    return message;
  } else
    return response.statusCode.toString();
}

Future<String> removeUserFav(String id, String productId) async {
  print("$header/app_api/removeUserFav.php?user_id=$id&product_id=$productId");
  http.Response response = await http.get(Uri.parse(
      "$header/app_api/removeUserFav.php?user_id=$id&product_id=$productId"));

  if (response.statusCode == 200) {
    Map apiData = jsonDecode(response.body);
    String message = apiData['msg'];

    return message;
  } else
    return response.statusCode.toString();
}

class Welcome {
  Welcome({
    this.code,
    this.msg,
  });

  String code;
  String msg;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        code: json["code"],
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "msg": msg,
      };
}
