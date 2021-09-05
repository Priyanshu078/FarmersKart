



import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shellcode2/apiData/Constants.dart';
import 'package:shellcode2/Provider/data.dart';
Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

String bannerImagesAPI="$header/app_api/getBannerImages.php";


List bannerImages=[];


Future<List> fetchBannerImages() async{

  http.Response response=await http.get(Uri.parse(bannerImagesAPI));

   if(response.statusCode==200){
     Map data=jsonDecode(response.body);
     List<dynamic> banner=data['banner'];
   List<Banner> bannerList=  banner.map((e) => Banner.fromJson(e)).toList();

     print(bannerList.length);
     for(int i=0;i<bannerList.length;i++)
     {
       bannerImages.add("http://uprank.live/farmerskart/images/banner/${bannerList[i].img}");

     }





   }else{

     print('banner images error');

   }



}


class Welcome {
  Welcome({
    this.banner,
    this.code,
  });

  List<Banner> banner;
  String code;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
    banner: List<Banner>.from(json["banner"].map((x) => Banner.fromJson(x))),
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "banner": List<dynamic>.from(banner.map((x) => x.toJson())),
    "code": code,
  };
}

class Banner {
  Banner({
    this.id,
    this.title,
    this.img,
    this.isActive,
    this.delFlag,
  });

  String id;
  String title;
  String img;
  String isActive;
  String delFlag;

  factory Banner.fromJson(Map<String, dynamic> json) => Banner(
    id: json["id"],
    title: json["title"],
    img: json["img"],
    isActive: json["is_active"],
    delFlag: json["del_flag"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "img": img,
    "is_active": isActive,
    "del_flag": delFlag,
  };
}
