import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shellcode2/apiData/Constants.dart';

class OfferData {
  List productPrice;
  String categoryName;
  String id;
  String category;
  String subCategory;
  String name;
  String img;
  String description;
  OfferData(this.productPrice, this.categoryName, this.id, this.category,
      this.subCategory, this.name, this.img, this.description);
}

class ProductPrice {
  String p_Id;
  String userType;
  String originalPrice;
  String discount;
  String discountedPrice;
  String weight;
  String unit;
  ProductPrice(this.p_Id, this.userType, this.originalPrice, this.discount,
      this.discountedPrice, this.weight, this.unit);
}

List offersData = [];

class Data {
  Future<bool> getOffersData() async {
    bool gotData = false;
    http.Response response;
    Uri url =
        Uri.parse("$header/app_api/getOffersProducts.php?user_type=Society");
    try {
      response = await http.get(url);
    } catch (e) {
      print(e);
    }
    var jsonData = jsonDecode(response.body);
    print(jsonData);
    for (var item1 in jsonData["product"]) {
      List price = [];
      for (var item2 in item1["product_price"]) {
        ProductPrice productPrice = new ProductPrice(
            item2["p_id"],
            item2["user_type"],
            item2["original_price"],
            item2["discount"],
            item2["discounted_price"],
            item2["weight"],
            item2["unit"]);
        price.add(productPrice);
      }
      OfferData offerData = new OfferData(
          price,
          item1["category_name"],
          item1["id"],
          item1["category"],
          item1["subcategory"],
          item1["name"],
          item1["img"],
          item1["description"]);
      offersData.add(offerData);
    }
    gotData = true;
    print(offersData);
    print("productPrice");
    print(offersData[0].productPrice[0].weight);
    print(offersData.length);
    return gotData;
  }
}
