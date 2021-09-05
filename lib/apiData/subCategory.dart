


import 'dart:convert';

import 'package:shellcode2/apiData/Constants.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

String subCategoryApi="$header/app_api/getCategoryProducts.php?user_type=Society";

List<Product> subCategoryProducts;
List<ProductPrice>subCategoryProductPrice;
List<General> subCategoryProductsList=[];

Future<List<Product>> fetchSubCategotyProductApiData(String category, String subcategory) async{

  print(category);
  print(subcategory);
  String url=subCategoryApi+"&category=${category}&subcategory=${subcategory}";
  print(url);
  http.Response response= await http.get(Uri.parse(url));
  if(response.statusCode==200){

    subCategoryProductsList=[];
    Map ApiData=jsonDecode(response.body);
    List<dynamic> data =ApiData['product'];
    print(data);
    subCategoryProducts=data.map((e) => Product.fromJson(e)).toList();

    for(int i=0;i<subCategoryProducts.length;i++){
      subCategoryProductPrice=subCategoryProducts[i].productPrice;

      List<List> manyNewOldPrice=[];


      for(int j=0;j<subCategoryProductPrice.length;j++){

        List<String> newOldPrice=[];
        newOldPrice.add('${subCategoryProductPrice[j].weight} ${subCategoryProductPrice[j].unit}');
        newOldPrice.add('${subCategoryProductPrice[j].originalPrice}');
        newOldPrice.add('${subCategoryProductPrice[j].discountedPrice}');

        manyNewOldPrice.add(newOldPrice);
      }



      double newRate;
      if(subCategoryProductPrice[0].discountedPrice=="")
        newRate=double.parse(subCategoryProductPrice[0].originalPrice);
      else
        newRate=double.parse(subCategoryProductPrice[0].discountedPrice);


      subCategoryProductsList.add(General(imageUrl: subCategoryProducts[i].img, title: subCategoryProducts[i].name, newrate: newRate, oldrate:double.parse(subCategoryProductPrice[0].originalPrice), weight: subCategoryProductPrice[0].weight, description: subCategoryProducts[i].description, data: manyNewOldPrice,productId: subCategoryProducts[i].id,discount: subCategoryProductPrice[0].discount,fav: 0));
    }



  }else
    Exception(response.statusCode);



}

class General {
  String title;
  String imageUrl;
  String weight;
  double oldrate;
  double newrate;
  String description;
  String productId;
  dynamic discount;
  int fav;

  List<List> data;
  General({
    @required this.title,
    @required this.weight,
    @required this.oldrate,
    @required this.newrate,
    @required this.imageUrl,
    @required this.description,
    @required this.data,
    @required this.productId,
    @required this.discount,
    @required this.fav,

  });
}

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
    this.rating,
    this.categoryName,
    this.id,
    this.category,
    this.subcategory,
    this.name,
    this.img,
    this.description,
    this.delFlag,
    this.productPrice,
  });

  String rating;
  String categoryName;
  String id;
  String category;
  String subcategory;
  String name;
  String img;
  String description;
  String delFlag;
  List<ProductPrice> productPrice;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    rating: json["rating"],
    categoryName: json["category_name"],
    id: json["id"],
    category: json["category"],
    subcategory: json["subcategory"],
    name: json["name"],
    img: json["img"],
    description: json["description"],
    delFlag: json["del_flag"],
    productPrice: List<ProductPrice>.from(json["product_price"].map((x) => ProductPrice.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "rating": rating,
    "category_name": categoryName,
    "id": id,
    "category": category,
    "subcategory": subcategory,
    "name": name,
    "img": img,
    "description": description,
    "del_flag": delFlag,
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
  dynamic discount;
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
