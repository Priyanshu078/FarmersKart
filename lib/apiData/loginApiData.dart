

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shellcode2/apiData/Constants.dart';
import 'package:http/http.dart' as http;

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());


List<UserOfApp> user;

String Login='$header/app_api/login.php?';
Future<List<UserOfApp>> fetchLoginApiData (String mobile, String password) async {

      String url=Login+'&mobile=$mobile&password=$password';
      print('jello');
      print(url);
      http.Response response= await http.get(Uri.parse(url));

      print(response.statusCode);

       if(response.statusCode==200){
         
         Map apiData= jsonDecode(response.body);
         String code=apiData['code'];
        List<dynamic>  data=apiData['user'];

         print(code);
          if(code=='200'){
            
            user=  data.map((e) => UserOfApp.fromJson(e)).toList();
            print(user);
          }else
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
    user: List<UserOfApp>.from(json["user"].map((x) => UserOfApp.fromJson(x))),
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "user": List<dynamic>.from(user.map((x) => x.toJson())),
    "code": code,
  };
}

class UserOfApp {
  UserOfApp({
    this.id,
    this.name,
    this.email,
    this.mobile,
    this.password,
    this.isActive,
    this.delFlag,
    this.firebaseToken,
    this.userType,
    this.address,
    this.societyName,
    this.flatNo,
    this.wing,
    this.pincode,
    this.gstNo,
    this.createdAt,
    this.from,
    this.imageName,
    this.centerId,
    this.center,
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
    center: List<CenterOfStore>.from(json["center"].map((x) => CenterOfStore.fromJson(x))),
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
    this.centerName,
    this.address,
    this.pincode,
    this.delFlag,
    this.deliveryDays,
    this.deliveryTime,
    this.id,
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
