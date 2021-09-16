import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shellcode2/apiData/Constants.dart';
import 'package:http/http.dart' as http;

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

List<UserOfApp> user;

String Login = '$header/app_api/login.php?';
Future<List> fetchLoginApiData(String mobile, String password) async {
  String url = Login + 'mobile=$mobile&password=$password';
  http.Response response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    print(response.statusCode);
    print(url);
    Map apiData = jsonDecode(response.body);
    print(apiData);
    String code = apiData['code'];
    print(code);
    List data = apiData['user'];
    print(data);
    List<UserOfApp> userData = [];
    if (code == '200') {
      for (var item in data) {
        List<CenterOfStore> centerList = [];
        // for (var center in item["center"]) {
        //   CenterOfStore centerOfStore = new CenterOfStore(
        //       centerName: center["center_name"].toString(),
        //       address: center["address"].toString(),
        //       pincode: center["pincode"].toString(),
        //       delFlag: center["del_flag"].toString(),
        //       deliveryDays: center["delivery_days"].toString(),
        //       deliveryTime: center["delivery_time"].toString(),
        //       id: center["id"].toString());
        //   centerList.add(centerOfStore);
        // }
        UserOfApp userOfApp = new UserOfApp(
            id: item["id"],
            name: item["name"],
            email: item["email"],
            mobile: item["mobile"],
            password: item["password"],
            isActive: item["is_active"],
            delFlag: item["del_flag"],
            firebaseToken: item["firebase_token"],
            userType: item["user_type"],
            address: item["address"],
            societyName: item["society_name"],
            flatNo: item["flat_no"],
            wing: item["wing"],
            pincode: item["pincode"],
            gstNo: item["gst_no"],
            createdAt: DateTime.parse(item["created_at"]),
            from: item["from"],
            imageName: item["image_name"],
            centerId: item["center_id"],
            center: centerList);
        userData.add(userOfApp);
      }
      user = userData;
      print(user);
    } else
      print(code);

    return user;
  }
}

class Welcome {
  Welcome({
    this.user,
    this.code,
  });

  List<UserOfApp> user;
  String code;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        user: List<UserOfApp>.from(
            json["user"].map((x) => UserOfApp.fromJson(x))),
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "user": List<dynamic>.from(user.map((x) => x.toJson())),
        "code": code,
      };
}

class UserOfApp {
  UserOfApp({
    @required this.id,
    @required this.name,
    @required this.email,
    @required this.mobile,
    @required this.password,
    @required this.isActive,
    @required this.delFlag,
    @required this.firebaseToken,
    @required this.userType,
    @required this.address,
    @required this.societyName,
    @required this.flatNo,
    @required this.wing,
    @required this.pincode,
    @required this.gstNo,
    @required this.createdAt,
    @required this.from,
    @required this.imageName,
    @required this.centerId,
    @required this.center,
  });

  String id;
  String name;
  String email;
  String mobile;
  String password;
  String isActive;
  String delFlag;
  String firebaseToken;
  String userType;
  String address;
  String societyName;
  String flatNo;
  String wing;
  String pincode;
  String gstNo;
  DateTime createdAt;
  String from;
  dynamic imageName;
  String centerId;
  List<CenterOfStore> center;

  factory UserOfApp.fromJson(Map<String, dynamic> json) => UserOfApp(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        mobile: json["mobile"],
        password: json["password"],
        isActive: json["is_active"],
        delFlag: json["del_flag"],
        firebaseToken: json["firebase_token"],
        userType: json["user_type"],
        address: json["address"],
        societyName: json["society_name"],
        flatNo: json["flat_no"],
        wing: json["wing"],
        pincode: json["pincode"],
        gstNo: json["gst_no"],
        createdAt: DateTime.parse(json["created_at"]),
        from: json["from"],
        imageName: json["image_name"],
        centerId: json["center_id"],
        center: List<CenterOfStore>.from(
            json["center"].map((x) => CenterOfStore.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "mobile": mobile,
        "password": password,
        "is_active": isActive,
        "del_flag": delFlag,
        "firebase_token": firebaseToken,
        "user_type": userType,
        "address": address,
        "society_name": societyName,
        "flat_no": flatNo,
        "wing": wing,
        "pincode": pincode,
        "gst_no": gstNo,
        "created_at": createdAt.toIso8601String(),
        "from": from,
        "image_name": imageName,
        "center_id": centerId,
        "center": List<dynamic>.from(center.map((x) => x.toJson())),
      };
}

class CenterOfStore {
  CenterOfStore({
    @required this.centerName,
    @required this.address,
    @required this.pincode,
    @required this.delFlag,
    @required this.deliveryDays,
    @required this.deliveryTime,
    @required this.id,
  });

  String centerName;
  String address;
  String pincode;
  String delFlag;
  String deliveryDays;
  String deliveryTime;
  String id;

  factory CenterOfStore.fromJson(Map<String, dynamic> json) => CenterOfStore(
        centerName: json["center_name"],
        address: json["address"],
        pincode: json["pincode"],
        delFlag: json["del_flag"],
        deliveryDays: json["delivery_days"],
        deliveryTime: json["delivery_time"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "center_name": centerName,
        "address": address,
        "pincode": pincode,
        "del_flag": delFlag,
        "delivery_days": deliveryDays,
        "delivery_time": deliveryTime,
        "id": id,
      };
}
