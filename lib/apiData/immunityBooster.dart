
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shellcode2/apiData/Constants.dart';
import 'package:http/http.dart' as http;

List<ProductPrice> immunityBoosterProductPrice;
List<Product> immunityBoosterProduct;
List<ImmunityBoosterCategories> immunityBoosterList=[];

String immunityBoosterApi="$header/app_api/get_special_category_product.php?category=Immunity%20Booster&user_type=Society";


Future<void> fetchImmunityBoosterProductApiData() async{

  http.Response response= await http.get(Uri.parse(immunityBoosterApi));
  if(response.statusCode==200){

    Map ApiData=jsonDecode(response.body);
    List<dynamic> data =ApiData['product'];
    print(data);
    immunityBoosterProduct=data.map((e) => Product.fromJson(e)).toList();

    for(int i=0;i<immunityBoosterProduct.length;i++){
      immunityBoosterProductPrice=immunityBoosterProduct[i].productPrice;

      List<List> manyNewOldPrice=[];


      for(int j=0;j<immunityBoosterProductPrice.length;j++){

        List<String> newOldPrice=[];
        newOldPrice.add('${immunityBoosterProductPrice[j].weight} ${immunityBoosterProductPrice[j].unit}');
        newOldPrice.add('${immunityBoosterProductPrice[j].originalPrice}');
        newOldPrice.add('${immunityBoosterProductPrice[j].discountedPrice}');

        manyNewOldPrice.add(newOldPrice);
      }



      double newRate;
      if(immunityBoosterProductPrice[0].discountedPrice=="")
        newRate=double.parse(immunityBoosterProductPrice[0].originalPrice);
      else
        newRate=double.parse(immunityBoosterProductPrice[0].discountedPrice);

      immunityBoosterList.add(ImmunityBoosterCategories(imageUrl: immunityBoosterProduct[i].img, title: immunityBoosterProduct[i].name, newrate: newRate, oldrate:double.parse(immunityBoosterProductPrice[0].originalPrice), weight: immunityBoosterProductPrice[0].weight, description: immunityBoosterProduct[i].description, data: manyNewOldPrice,productId: immunityBoosterProduct[i].id));
    }



  }else
    Exception(response.statusCode);



}







class ImmunityBoosterCategories {
  String imageUrl;
  String weight;
  String title;
  double newrate;
  double oldrate;
  String description;
  String productId;

  List<List> data;
  ImmunityBoosterCategories({
    @required this.imageUrl,
    @required this.title,
    @required this.newrate,
    @required this.oldrate,
    @required this.weight,
    @required this.description,
    @required this.data,
    @required this.productId,
  });
}


Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Welcome({
    this.product,
    this.code,
  });

  List<Product> product;
  String code;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
    product: List<Product>.from(json["product"].map((x) => Product.fromJson(x))),
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "product": List<dynamic>.from(product.map((x) => x.toJson())),
    "code": code,
  };
}

class Product {
  Product({
    this.categoryName,
    this.id,
    this.category,
    this.subcategory,
    this.name,
    this.img,
    this.description,
    this.delFlag,
    this.rating,
    this.productPrice,
  });

  String categoryName;
  String id;
  String category;
  String subcategory;
  String name;
  String img;
  String description;
  String delFlag;
  String rating;
  List<ProductPrice> productPrice;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    categoryName: json["category_name"],
    id: json["id"],
    category: json["category"],
    subcategory: json["subcategory"],
    name: json["name"],
    img: json["img"],
    description: json["description"],
    delFlag: json["del_flag"],
    rating: json["rating"],
    productPrice: List<ProductPrice>.from(json["product_price"].map((x) => ProductPrice.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "category_name": categoryName,
    "id": id,
    "category": category,
    "subcategory": subcategory,
    "name": name,
    "img": img,
    "description": description,
    "del_flag": delFlag,
    "rating": rating,
    "product_price": List<dynamic>.from(productPrice.map((x) => x.toJson())),
  };
}

class ProductPrice {
  ProductPrice({
    this.pId,
    this.userType,
    this.originalPrice,
    this.discount,
    this.discountedPrice,
    this.weight,
    this.unit,
  });

  String pId;
  String userType;
  String originalPrice;
  int discount;
  String discountedPrice;
  String weight;
  String unit;

  factory ProductPrice.fromJson(Map<String, dynamic> json) => ProductPrice(
    pId: json["p_id"],
    userType: json["user_type"],
    originalPrice: json["original_price"],
    discount: json["discount"],
    discountedPrice: json["discounted_price"],
    weight: json["weight"],
    unit: json["unit"],
  );

  Map<String, dynamic> toJson() => {
    "p_id": pId,
    "user_type": userType,
    "original_price": originalPrice,
    "discount": discount,
    "discounted_price": discountedPrice,
    "weight": weight,
    "unit": unit,
  };
}
