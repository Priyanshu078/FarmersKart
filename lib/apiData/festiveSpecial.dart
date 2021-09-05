

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shellcode2/apiData/Constants.dart';


List<ProductPrice> festiveSpecialProductPrice;
List<Product> festiveSpecialProduct;
List<FestiveSpecialCategories> festiveSpecialList=[];

String immunityBoosterApi="$header/app_api/get_special_category_product.php?category=festival%20special&user_type=Society";


Future<void> fetchFestiveSpecialProductApiData() async{

  http.Response response= await http.get(Uri.parse(immunityBoosterApi));
  if(response.statusCode==200){

    Map ApiData=jsonDecode(response.body);
    List<dynamic> data =ApiData['product'];
    print(data);
    festiveSpecialProduct=data.map((e) => Product.fromJson(e)).toList();

    for(int i=0;i<festiveSpecialProduct.length;i++){
      festiveSpecialProductPrice=festiveSpecialProduct[i].productPrice;

      List<List> manyNewOldPrice=[];


      for(int j=0;j<festiveSpecialProductPrice.length;j++){

        List<String> newOldPrice=[];
        newOldPrice.add("${festiveSpecialProductPrice[j].pId}");
        newOldPrice.add('${festiveSpecialProductPrice[j].weight} ${festiveSpecialProductPrice[j].unit}');
        newOldPrice.add('${festiveSpecialProductPrice[j].originalPrice}');
        newOldPrice.add('${festiveSpecialProductPrice[j].discountedPrice}');
        newOldPrice.add('${festiveSpecialProductPrice[j].unit}');

        manyNewOldPrice.add(newOldPrice);
      }



      double newRate;
      if(festiveSpecialProductPrice[0].discountedPrice=="")
        newRate=double.parse(festiveSpecialProductPrice[0].originalPrice);
      else
        newRate=double.parse(festiveSpecialProductPrice[0].discountedPrice);

      festiveSpecialList.add(FestiveSpecialCategories(imageUrl: festiveSpecialProduct[i].img, title: festiveSpecialProduct[i].name, newrate: newRate, oldrate:double.parse(festiveSpecialProductPrice[0].originalPrice), weight: festiveSpecialProductPrice[0].weight, description: festiveSpecialProduct[i].description, data: manyNewOldPrice,productId: festiveSpecialProduct[i].id));
    }



  }else
    Exception(response.statusCode);



}






class  FestiveSpecialCategories{
  String imageUrl;
  String weight;
  String title;
  double newrate;
  double oldrate;
  String description;
  List<List> data;
  String productId;
  FestiveSpecialCategories({
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
