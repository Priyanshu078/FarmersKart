import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shellcode2/apiData/Constants.dart';

List<UserFavProductCategories> userFavProductList = [];
List<Product> favProducts;
List<ProductPrice> favProductsPrice;
Future<void> fetchGetUserFav(String userId) async {
  print(
      "$header/app_api/getUserFavProduct.php?user_id=$userId&user_type=Society");

  http.Response response = await http.get(Uri.parse(
      "$header/app_api/getUserFavProduct.php?user_id=$userId&user_type=Society"));
  print(response.statusCode);
  if (response.statusCode == 200) {
    var apiData = jsonDecode(response.body);
    List<dynamic> data = apiData['product'];
    print(data);
    favProducts = data.map((e) => Product.fromJson(e)).toList();

    for (int i = 0; i < favProducts.length; i++) {
      favProductsPrice = favProducts[i].productPrice;

      List<List> manyNewOldPrice = [];

      for (int j = 0; j < favProductsPrice.length; j++) {
        List<String> newOldPrice = [];
        newOldPrice
            .add('${favProductsPrice[j].weight} ${favProductsPrice[j].unit}');
        newOldPrice.add('${favProductsPrice[j].originalPrice}');
        newOldPrice.add('${favProductsPrice[j].discountedPrice}');

        manyNewOldPrice.add(newOldPrice);
      }

      double newRate;
      if (favProductsPrice[0].discountedPrice == "")
        newRate = double.parse(favProductsPrice[0].originalPrice);
      else
        newRate = double.parse(favProductsPrice[0].discountedPrice);

      userFavProductList.add(UserFavProductCategories(
          title: favProducts[i].name,
          weight: manyNewOldPrice,
          rate: newRate.toInt(),
          imageURL: favProducts[i].img,
          categoryName: favProducts[i].categoryName,
          discount: favProductsPrice[0].discount));
    }
  } else {}
}

class UserFavProductCategories {
  String imageURL;
  String title;
  int rate;
  List weight;
  String categoryName;
  int discount;
  UserFavProductCategories({
    @required this.imageURL,
    @required this.title,
    @required this.rate,
    @required this.weight,
    @required this.categoryName,
    @required this.discount,
  });
}

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Welcome({
    this.product,
    this.code,
    this.msg,
  });

  List<Product> product;
  String code;
  String msg;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        product:
            List<Product>.from(json["product"].map((x) => Product.fromJson(x))),
        code: json["code"],
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "product": List<dynamic>.from(product.map((x) => x.toJson())),
        "code": code,
        "msg": msg,
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
        productPrice: List<ProductPrice>.from(
            json["product_price"].map((x) => ProductPrice.fromJson(x))),
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
        "product_price":
            List<dynamic>.from(productPrice.map((x) => x.toJson())),
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
