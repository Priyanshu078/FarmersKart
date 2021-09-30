
import 'dart:convert';

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
    this.productPrice,
    this.categoryName,
    this.id,
    this.category,
    this.subcategory,
    this.name,
    this.img,
    this.description,
    this.delFlag,
    this.rating,
  });

  List<ProductPrice> productPrice;
  CategoryName categoryName;
  String id;
  String category;
  Subcategory subcategory;
  String name;
  String img;
  String description;
  String delFlag;
  String rating;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    productPrice: List<ProductPrice>.from(json["product_price"].map((x) => ProductPrice.fromJson(x))),
    categoryName: categoryNameValues.map[json["category_name"]],
    id: json["id"],
    category: json["category"],
    subcategory: subcategoryValues.map[json["subcategory"]],
    name: json["name"],
    img: json["img"],
    description: json["description"],
    delFlag: json["del_flag"],
    rating: json["rating"],
  );

  Map<String, dynamic> toJson() => {
    "product_price": List<dynamic>.from(productPrice.map((x) => x.toJson())),
    "category_name": categoryNameValues.reverse[categoryName],
    "id": id,
    "category": category,
    "subcategory": subcategoryValues.reverse[subcategory],
    "name": name,
    "img": img,
    "description": description,
    "del_flag": delFlag,
    "rating": rating,
  };
}

enum CategoryName { FRESH_VEGETABLES_FRUIT }

final categoryNameValues = EnumValues({
  "Fresh Vegetables & fruit": CategoryName.FRESH_VEGETABLES_FRUIT
});

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
  Unit unit;

  factory ProductPrice.fromJson(Map<String, dynamic> json) => ProductPrice(
    pId: json["p_id"],
    userType: userTypeValues.map[json["user_type"]],
    originalPrice: json["original_price"],
    discount: json["discount"],
    discountedPrice: json["discounted_price"],
    weight: json["weight"],
    unit: unitValues.map[json["unit"]],
  );

  Map<String, dynamic> toJson() => {
    "p_id": pId,
    "user_type": userTypeValues.reverse[userType],
    "original_price": originalPrice,
    "discount": discount,
    "discounted_price": discountedPrice,
    "weight": weight,
    "unit": unitValues.reverse[unit],
  };
}

enum Unit { GM, KG, UNIT_KG, BUNCH, PACK, PS, UNIT_PS }

final unitValues = EnumValues({
  "Bunch": Unit.BUNCH,
  "GM": Unit.GM,
  "kg": Unit.KG,
  "Pack": Unit.PACK,
  " Ps": Unit.PS,
  " kg": Unit.UNIT_KG,
  "PS": Unit.UNIT_PS
});

enum UserType { SOCIETY, USER_TYPE_SOCIETY }

final userTypeValues = EnumValues({
  "Society": UserType.SOCIETY,
  "SOCIETY": UserType.USER_TYPE_SOCIETY
});

enum Subcategory { FRESH_VEGITABLES, FLOWER, EXTOTIC_VEGETABLES, FRUITS, LEAFY_VEGETABLES, PEELED_OR_CUT_VEGITABLES }

final subcategoryValues = EnumValues({
  "Extotic Vegetables": Subcategory.EXTOTIC_VEGETABLES,
  "Flower": Subcategory.FLOWER,
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
