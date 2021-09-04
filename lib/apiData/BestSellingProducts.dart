import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'Constants.dart';

String BestProductsApi = "$header/app_api/getBestSellingProdcut.php";

List<Product> BestProducts;
List<ProductPrice> BestProductsPrice;

class BestProductCategories {
  // String pId;
  String imageUrl;
  String weight;
  String title;
  double newrate;
  double oldrate;
  String description;
  List<List> data;
  BestProductCategories({
    // @required this.pId,
    @required this.imageUrl,
    @required this.title,
    @required this.newrate,
    @required this.oldrate,
    @required this.weight,
    @required this.description,
    @required this.data,
  });
}

List<BestProductCategories> bestProductCategoryList = [];
Future<List<Product>> fetchBestProductApiData() async {
  print(BestProductsApi);
  http.Response response = await http.get(Uri.parse(BestProductsApi));
  if (response.statusCode == 200) {
    Map ApiData = jsonDecode(response.body);
    List<dynamic> data = ApiData['product'];
    print(data);
    BestProducts = data.map((e) => Product.fromJson(e)).toList();
    print("id");
    print(BestProducts[0].productPrice[0].pId);
    for (int i = 0; i < BestProducts.length; i++) {
      BestProductsPrice = BestProducts[i].productPrice;

      List<List> manyNewOldPrice = [];

      for (int j = 0; j < BestProductsPrice.length; j++) {
        List<String> newOldPrice = [];
        newOldPrice.add("${BestProductsPrice[j].pId}");
        newOldPrice
            .add('${BestProductsPrice[j].weight} ${BestProductsPrice[j].unit}');
        newOldPrice.add('${BestProductsPrice[j].originalPrice}');
        newOldPrice.add('${BestProductsPrice[j].discountedPrice}');
        newOldPrice.add('${BestProductsPrice[j].unit}');

        manyNewOldPrice.add(newOldPrice);
      }

      double newRate;
      if (BestProductsPrice[0].discountedPrice == "")
        newRate = double.parse(BestProductsPrice[0].originalPrice);
      else
        newRate = double.parse(BestProductsPrice[0].discountedPrice);

      bestProductCategoryList.add(BestProductCategories(
          imageUrl: 'assets/bg.jpg',
          title: BestProducts[i].name,
          newrate: newRate,
          oldrate: double.parse(BestProductsPrice[0].originalPrice),
          weight: BestProductsPrice[0].weight,
          description: BestProducts[i].description,
          data: manyNewOldPrice));
    }
  } else
    Exception(response.statusCode);
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
        product:
            List<Product>.from(json["product"].map((x) => Product.fromJson(x))),
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
    this.productPrice,
  });

  CategoryName categoryName;
  String id;
  String category;
  Subcategory subcategory;
  String name;
  String img;
  String description;
  List<ProductPrice> productPrice;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        categoryName: categoryNameValues.map[json["category_name"]],
        id: json["id"],
        category: json["category"],
        subcategory: subcategoryValues.map[json["subcategory"]],
        name: json["name"],
        img: json["img"],
        description: json["description"],
        productPrice: List<ProductPrice>.from(
            json["product_price"].map((x) => ProductPrice.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "category_name": categoryNameValues.reverse[categoryName],
        "id": id,
        "category": category,
        "subcategory": subcategoryValues.reverse[subcategory],
        "name": name,
        "img": img,
        "description": description,
        "product_price":
            List<dynamic>.from(productPrice.map((x) => x.toJson())),
      };
}

enum CategoryName { FRESH_VEGETABLES_FRUIT }

final categoryNameValues = EnumValues(
    {"Fresh Vegetables & fruit": CategoryName.FRESH_VEGETABLES_FRUIT});

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
  UserType userType;
  String originalPrice;
  dynamic discount;
  String discountedPrice;
  String weight;
  String unit;

  factory ProductPrice.fromJson(Map<String, dynamic> json) => ProductPrice(
        pId: json["p_id"],
        userType: userTypeValues.map[json["user_type"]],
        originalPrice: json["original_price"],
        discount: json["discount"],
        discountedPrice: json["discounted_price"],
        weight: json["weight"],
        unit: json["unit"],
      );

  Map<String, dynamic> toJson() => {
        "p_id": pId,
        "user_type": userTypeValues.reverse[userType],
        "original_price": originalPrice,
        "discount": discount,
        "discounted_price": discountedPrice,
        "weight": weight,
        "unit": unit,
      };
}

enum UserType { SOCIETY, USER_TYPE_SOCIETY }

final userTypeValues = EnumValues(
    {"SOCIETY": UserType.SOCIETY, "Society": UserType.USER_TYPE_SOCIETY});

enum Subcategory {
  FRESH_VEGITABLES,
  FRUITS,
  PEELED_OR_CUT_VEGITABLES,
  LEAFY_VEGETABLES
}

final subcategoryValues = EnumValues({
  "Fresh Vegitables": Subcategory.FRESH_VEGITABLES,
  "Fruits": Subcategory.FRUITS,
  "Leafy Vegetables": Subcategory.LEAFY_VEGETABLES,
  "Peeled or Cut vegitables": Subcategory.PEELED_OR_CUT_VEGITABLES
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
