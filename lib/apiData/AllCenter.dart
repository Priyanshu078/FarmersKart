

import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:shellcode2/apiData/Constants.dart';

List<String> centerName=[];
List<AllCenterApi> centers ;

String allCenterApi="$header/app_api/getAllCenters.php";


Future<void> fetchAllCenter()async {

  http.Response response =await http.get(Uri.parse(allCenterApi));

  if(response.statusCode==200){

    Map apiDAta=jsonDecode(response.body);
    List<dynamic> data=apiDAta['center'];

    centers=data.map((e) => AllCenterApi.fromJson(e)).toList();

    for(int i=0;i<centers.length;i++)
      {
         centerName.add(centers[i].centerName);

      }


  }

}


















Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Welcome({
    this.center,
    this.code,
  });

  List<AllCenterApi> center;
  String code;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
    center: List<AllCenterApi>.from(json["center"].map((x) => AllCenterApi.fromJson(x))),
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "center": List<dynamic>.from(center.map((x) => x.toJson())),
    "code": code,
  };
}

class AllCenterApi {
  AllCenterApi({
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

  factory AllCenterApi.fromJson(Map<String, dynamic> json) => AllCenterApi(
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
