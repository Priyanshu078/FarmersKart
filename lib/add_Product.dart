import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shellcode2/Provider/data.dart';
import 'More pages/ImmunityMore.dart';
import 'apiData/Constants.dart';
import 'colors.dart';

class AddProduct extends StatefulWidget {
  String orderId;
  AddProduct({Key key, @required this.orderId}) : super(key: key);

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  int selectedIndex;
  List temp = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add Product"),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient:
                    LinearGradient(colors: [left, middle, Colors.purple])),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: FutureBuilder(
              future: getAllCategories(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return ListView.separated(
                        itemBuilder: (context, index) {
                          return InkWell(
                            splashColor: Colors.grey,
                            onTap: () {
                              showModalBottomSheet(
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                context: context,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20))),
                                builder: (BuildContext context) {
                                  return buildSheet(
                                      snapshot.data[index].id.toString());
                                },
                              );
                            },
                            child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                elevation: 5.0,
                                child: Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.fromLTRB(
                                          8.0, 8.0, 16.0, 8.0),
                                      height:
                                          MediaQuery.of(context).size.width *
                                              1 /
                                              3,
                                      width: MediaQuery.of(context).size.width *
                                          1 /
                                          3,
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            "https://uprank.live/farmerskart/images/category/${snapshot.data[index].logo}",
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.fill,
                                                colorFilter: ColorFilter.mode(
                                                    Colors.transparent,
                                                    BlendMode.colorBurn)),
                                          ),
                                        ),
                                        placeholder: (context, url) =>
                                            CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                    ),
                                    Expanded(
                                        child: Text(
                                      "${snapshot.data[index].name}",
                                      style: TextStyle(
                                          color: Colors.purple[600],
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ))
                                  ],
                                )),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Divider(height: 10, color: Colors.grey);
                        },
                        itemCount: snapshot.data.length);
                  } else if (snapshot.hasError) {
                    print(snapshot.error);
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              }),
        ));
  }

  Future<List> getAllCategories() async {
    List categories = [];
    String url = "$header/app_api/getAllCategories.php";
    Uri uri = Uri.parse(url);
    http.Response response = await http.get(uri);
    var jsonData = jsonDecode(response.body);
    if (jsonData["code"] == "200") {
      for (var item in jsonData["category"]) {
        Category category = new Category(item["id"], item["name"],
            item["del_flag"], item["logo"], item["subcategory"]);
        categories.add(category);
      }
    }
    return categories;
  }

  Widget buildSheet(String category) {
    Provider.of<APIData>(context, listen: false).initializeIndex(-1);
    return DraggableScrollableSheet(
        initialChildSize: 0.8,
        // minChildSize: 1,
        // maxChildSize: 1,
        builder: (context, controller) {
          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                color: Colors.white),
            child: Padding(
              padding: EdgeInsets.fromLTRB(5, 16, 5, 16),
              child: FutureBuilder(
                  future: getCategoryProducts(category),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.all(10),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          spreadRadius: 1,
                                          blurRadius: 1,
                                          offset: Offset(0, 1),
                                          color: Colors.black38)
                                    ]),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 20, 10, 20),
                                      child: Container(
                                        height: 70,
                                        width: 70,
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              "http://uprank.live/farmerskart/images/product/${snapshot.data[index].img}",
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover,
                                                  colorFilter: ColorFilter.mode(
                                                      Colors.transparent,
                                                      BlendMode.colorBurn)),
                                            ),
                                          ),
                                          placeholder: (context, url) =>
                                              CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          (1 / 2 + 1 / 8),
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            snapshot.data[index].name,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                              color: Colors.deepPurple,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      addToDoPopUpCard(context,
                                                          index, temp));
                                            },
                                            child: Hero(
                                              tag: addToDoPopUpCard,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  border: Border(
                                                    top: BorderSide(
                                                        width: 2.0,
                                                        color: Colors.purple),
                                                    left: BorderSide(
                                                        width: 2.0,
                                                        color: Colors.purple),
                                                    right: BorderSide(
                                                        width: 2.0,
                                                        color: Colors.purple),
                                                    bottom: BorderSide(
                                                        width: 2.0,
                                                        color: Colors.purple),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Flexible(
                                                      child: Text(
                                                        " ${snapshot.data[index].productPrice[0].weight} ${snapshot.data[index].productPrice[0].unit}",
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          color: yellow,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                      ),
                                                    ),
                                                    Icon(
                                                      Icons.keyboard_arrow_down,
                                                      color: yellow,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              snapshot
                                                          .data[index]
                                                          .productPrice[0]
                                                          .discountedPrice ==
                                                      ""
                                                  ? Text(
                                                      "₹  ${snapshot.data[index].productPrice[0].originalPrice}",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 12,
                                                        color: Colors.purple,
                                                      ),
                                                    )
                                                  : Text(
                                                      "₹  ${snapshot.data[index].productPrice[0].discountedPrice}",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 12,
                                                        color: Colors.purple,
                                                      ),
                                                    ),
                                              RatingBar.builder(
                                                unratedColor: Colors.grey[300],
                                                itemCount: 5,
                                                initialRating: 0,
                                                direction: Axis.horizontal,
                                                allowHalfRating: true,
                                                itemSize: 18,
                                                itemBuilder: (context, _) =>
                                                    Icon(
                                                  Icons.star,
                                                  size: 1.0,
                                                  color: yellow,
                                                ),
                                                onRatingUpdate: (rating) {
                                                  print(rating);
                                                },
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: InkWell(
                                              onTap: () async {
                                                Provider.of<APIData>(context,
                                                        listen: false)
                                                    .initializeIndex(index);
                                                Provider.of<APIData>(context,
                                                        listen: false)
                                                    .initializeProductQuantity(
                                                        1);
                                                bool added = await addProductToCart(
                                                    snapshot.data[index].id,
                                                    Provider.of<APIData>(
                                                            context,
                                                            listen: false)
                                                        .productQuantity
                                                        .toString(),
                                                    snapshot
                                                                .data[index]
                                                                .productPrice[0]
                                                                .discountedPrice ==
                                                            ""
                                                        ? snapshot
                                                            .data[index]
                                                            .productPrice[0]
                                                            .originalPrice
                                                        : snapshot
                                                            .data[index]
                                                            .productPrice[0]
                                                            .discountedPrice,
                                                    snapshot.data[index]
                                                        .productPrice[0].weight,
                                                    snapshot.data[index]
                                                        .productPrice[0].unit,
                                                    snapshot
                                                        .data[index]
                                                        .productPrice[0]
                                                        .originalPrice);
                                                if (added) {
                                                  showSnackBar(
                                                      "Added to cart Successfully");
                                                } else {
                                                  showSnackBar(
                                                      "Something Went Wrong");
                                                }
                                              },
                                              child: Consumer<APIData>(builder:
                                                  (context, data, child) {
                                                return Container(
                                                  child: index == data.index
                                                      ? Container(
                                                          child: CustomStepper(
                                                              1,
                                                              10,
                                                              Provider.of<APIData>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .productQuantity,
                                                              20.0,
                                                              1,
                                                              snapshot
                                                                  .data[index]
                                                                  .id,
                                                              Provider.of<APIData>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .productQuantity,
                                                              snapshot.data[index].productPrice[0].discountedPrice ==
                                                                      ""
                                                                  ? snapshot
                                                                      .data[
                                                                          index]
                                                                      .productPrice[
                                                                          0]
                                                                      .originalPrice
                                                                  : snapshot
                                                                      .data[
                                                                          index]
                                                                      .productPrice[
                                                                          0]
                                                                      .discountedPrice,
                                                              snapshot
                                                                  .data[index]
                                                                  .productPrice[
                                                                      0]
                                                                  .weight,
                                                              snapshot
                                                                  .data[index]
                                                                  .productPrice[
                                                                      0]
                                                                  .unit,
                                                              snapshot
                                                                  .data[index]
                                                                  .productPrice[0]
                                                                  .originalPrice),
                                                        )
                                                      : Container(
                                                          height: 25,
                                                          width: 80,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5.0),
                                                            color: Colors
                                                                .purple[700],
                                                          ),
                                                          child: Align(
                                                            alignment: Alignment
                                                                .center,
                                                            child: Text(
                                                              "ADD",
                                                              style: TextStyle(
                                                                  fontSize: 10,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          )),
                                                );
                                              }),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            });
                      } else if (snapshot.hasError) {
                        print(snapshot.error);
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    }
                    return Center(child: CircularProgressIndicator());
                  }),
            ),
          );
        });
  }

  Widget CustomStepper(
      int lowerLimit,
      int upperLimit,
      int stepValue,
      dynamic iconSize,
      int value,
      String productid,
      int proQuantity,
      String unitprice,
      String Weight,
      String Unit,
      String originalprice) {
    return Container(
      height: 30,
      width: 120,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.purple),
          borderRadius: BorderRadius.circular(5)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 1,
            child: InkWell(
              child: Icon(
                Icons.remove,
                color: Colors.deepPurple,
                size: 20,
              ),
              onTap: () async {
                int quantity = 0;
                if (Provider.of<APIData>(context, listen: false)
                        .productQuantity >
                    1) {
                  quantity = Provider.of<APIData>(context, listen: false)
                          .productQuantity -
                      1;
                } else {
                  quantity = 1;
                }
                Provider.of<APIData>(context, listen: false)
                    .initializeProductQuantity(quantity);
                //   proQuantity -= 1;
                bool added = await addProductToCart(
                    productid,
                    quantity.toString(),
                    unitprice,
                    Weight,
                    Unit,
                    originalprice);
                if (added) {
                  showSnackBar("Added to cart Successfully");
                } else {
                  showSnackBar("Something Went Wrong");
                }
                // }
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                  gradient:
                      LinearGradient(colors: [left, middle, Colors.purple])),
              width: iconSize,
              child: Center(
                child: FittedBox(
                  child: Consumer<APIData>(builder: (context, data, child) {
                    return Text(
                      '${data.productQuantity}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    );
                  }),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: InkWell(
              child: Icon(Icons.add, color: Colors.greenAccent, size: 20),
              onTap: () async {
                int quantity = Provider.of<APIData>(context, listen: false)
                        .productQuantity +
                    1;
                Provider.of<APIData>(context, listen: false)
                    .initializeProductQuantity(quantity);
                // proQuantity += 1;
                bool added = await addProductToCart(
                    productid,
                    quantity.toString(),
                    unitprice,
                    Weight,
                    Unit,
                    originalprice);
                if (added) {
                  showSnackBar("Added to cart Successfully");
                } else {
                  showSnackBar("Something Went Wrong");
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void showSnackBar(String content) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(content)));
  }

  Future<bool> addProductToCart(
      String productid,
      String proQuantity,
      String unitprice,
      String Weight,
      String Unit,
      String originalprice) async {
    http.Response response;
    String userId = Provider.of<APIData>(context, listen: false).user.id;
    String productId = productid;
    print(productId);
    String Quantity = proQuantity;
    String unitPrice = unitprice;
    print(unitPrice);
    String weight = Weight;
    print(weight);
    String unit = Unit;
    print(unit);
    String orderNumber = widget.orderId;
    String originalPrice = originalprice;
    print(originalPrice);
    String url =
        "$header/app_api/addtocart_order.php?user_id=$userId&product_id=$productId&quantity=$Quantity&unit_price=$unitPrice&weight=$weight&unit=$unit&unit_original_price=$originalPrice&order_number=$orderNumber";
    print(url);
    Uri uri = Uri.parse(url);
    response = await http.get(uri);
    var jsonData = jsonDecode(response.body);
    bool added = false;
    if (jsonData["code"] == "200") {
      added = true;
    } else {
      added = false;
    }
    return added;
  }

  Future<List> getCategoryProducts(String category) async {
    List categoryProducts = [];
    temp = [];
    String userType = "Society";
    String subCategory = "All";
    String url =
        "$header/app_api/getCategoryProducts.php?user_type=$userType&category=$category&subcategory=$subCategory";
    Uri uri = Uri.parse(url);
    http.Response response = await http.get(uri);
    var jsonData = jsonDecode(response.body);
    for (var item1 in jsonData["product"]) {
      List<ProductPrice> price = [];
      for (var item2 in item1["product_price"]) {
        ProductPrice productPrice = new ProductPrice(
            pId: item2["p_id"],
            userType: item2["user_type"],
            originalPrice: item2["original_price"],
            discount: item2["discount"],
            discountedPrice: item2["discounted_price"],
            weight: item2["weight"],
            unit: item2["unit"]);
        price.add(productPrice);
      }
      Product product = new Product(
          rating: item1["rating"],
          categoryName: item1["category_name"],
          id: item1["id"],
          category: item1["category"],
          subcategory: item1["subcategory"],
          name: item1["name"],
          img: item1["img"],
          description: item1["description"],
          delFlag: item1["del_flag"],
          productPrice: price);
      categoryProducts.add(product);
    }
    temp = categoryProducts;
    return categoryProducts;
  }
}

class ProductPrice {
  ProductPrice({
    @required this.pId,
    @required this.userType,
    @required this.originalPrice,
    @required this.discount,
    @required this.discountedPrice,
    @required this.weight,
    @required this.unit,
  });

  String pId;
  String userType;
  String originalPrice;
  dynamic discount;
  String discountedPrice;
  String weight;
  String unit;
}

class Product {
  Product({
    @required this.rating,
    @required this.categoryName,
    @required this.id,
    @required this.category,
    @required this.subcategory,
    @required this.name,
    @required this.img,
    @required this.description,
    @required this.delFlag,
    @required this.productPrice,
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
}

class Category {
  String id;
  String name;
  String delFlag;
  String logo;
  String subCategory;
  Category(this.id, this.name, this.delFlag, this.logo, this.subCategory);
}

Widget addToDoPopUpCard(BuildContext context, int index, List temp) {
  return AlertDialog(
    content: Hero(
      tag: addToDoPopUpCard,
      child: Material(
        color: lightbg,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Available quantities for',
                  style: TextStyle(
                      color: Colors.purple,
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  'Farmerskart - ${temp[index].name}',
                  style: TextStyle(
                      height: 2,
                      color: Colors.purple,
                      fontSize: 18,
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.w700),
                ),
                const Divider(
                  color: Colors.orange,
                  thickness: 0.8,
                ),
                for (int k = 0; k < temp[index].productPrice.length; k++) ...{
                  Container(
                    height: 35,
                    decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(width: 1.0, color: yellow),
                          left: BorderSide(width: 1.0, color: yellow),
                          right: BorderSide(width: 1.0, color: yellow),
                          bottom: BorderSide(width: 1.0, color: yellow),
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                        gradient: LinearGradient(
                            colors: [left, middle, Colors.purple])),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${temp[index].productPrice[k].weight} ${temp[index].productPrice[k].unit} -',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                          Spacer(
                            flex: 2,
                          ),
                          temp[index].productPrice[k].discountedPrice != ""
                              ? Text(
                                  '₹${temp[index].productPrice[k].originalPrice}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: Colors.white,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                )
                              : Text(
                                  '₹${temp[index].productPrice[k].originalPrice}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                          Spacer(
                            flex: 2,
                          ),
                          temp[index].productPrice[k].discountedPrice != ""
                              ? Text(
                                  '₹${temp[index].productPrice[k].discountedPrice}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                )
                              : Container()
                        ],
                      ),
                    ),
                  ),
                  const Divider(
                    color: Colors.white,
                    thickness: 0.2,
                  ),
                },
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
