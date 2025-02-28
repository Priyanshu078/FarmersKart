import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shellcode2/Navigation%20Drawer%20pages/myOrders.dart';
import 'package:shellcode2/Provider/data.dart';
import 'package:shellcode2/apiData/CartProducts.dart';
import 'package:shellcode2/apiData/Constants.dart';
import 'package:shellcode2/apiData/coupon.dart';
import 'package:shellcode2/colors.dart';
import 'package:shellcode2/Bottom%20bar%20pages/wishlist.dart';
import 'package:shellcode2/Bottom%20bar%20pages/categories.dart';
import 'package:shellcode2/deliveryAddress.dart';
import 'package:shellcode2/home.dart';
import 'package:http/http.dart' as http;

class Cart extends StatefulWidget {
  const Cart({Key key}) : super(key: key);

  @override
  CartState createState() => CartState();
}

class CartState extends State<Cart> {
  TextEditingController specificationController = new TextEditingController();
  TextEditingController couponController = new TextEditingController();
  String title1 = '';
  double totalCost = 0;
  double totalDiscount = 0;
  double deliveryCharges = 40.00;
  List productOrderId = [];
  String couponId = "";
  String couponCode = "";
  String couponValue = "";
  bool couponApplied = false;

  @override
  void initState() {
    // getCartProducts();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // if (totalAmount > 240) {
    //   Provider.of<APIData>(context,
    //       listen: false)
    //       .initializeTotalAmount(totalAmount);
    // } else {
    //   Provider.of<APIData>(context,
    //       listen: false)
    //       .initializeTotalAmount(
    //       totalAmount + 40);
    // }
    //        print('ishan');

    String userId = Provider.of<APIData>(context, listen: false).user.id;
    String pincode = Provider.of<APIData>(context, listen: false).user.pincode;
    return Scaffold(
      backgroundColor: lightbg,
      appBar: AppBar(
        centerTitle: true,
        titleSpacing: 0.0,
        elevation: 0,
        //brightness: Brightness.light,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [left, middle, Colors.purple])),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, size: 20, color: yellow),
        ),
        title: Text(
          'Review Basket',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.location_on,
                  color: Colors.red,
                ),
              ),
              Text(
                "Deliver to ",
                style: TextStyle(fontSize: 15, color: Colors.green),
              ),
              Text(
                "$pincode",
                style: TextStyle(fontSize: 15),
              )
            ],
          ),
          Expanded(
              child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FutureBuilder(
                    future: getCartProducts(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          return Expanded(
                              child: ListView.builder(
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (context, int index) {
                                    try {
                                      double totalAmount = 0;
                                      for (int i = 0;
                                          i < snapshot.data[index].length;
                                          i++) {
                                        totalAmount += double.parse(snapshot
                                            .data[index][i].totalAmount);
                                        totalDiscount += (double.parse(snapshot
                                                .data[index][i]
                                                .unitOriginalPrice) -
                                            double.parse(snapshot
                                                .data[index][i].unitPrice));
                                      }
                                      print("Hello WOrld");
                                      // if (totalAmount > 240) {
                                      //   Provider.of<APIData>(context,
                                      //       listen: false)
                                      //       .initializeTotalAmount(totalAmount);
                                      // } else {
                                      //   Provider.of<APIData>(context,
                                      //       listen: false)
                                      //       .initializeTotalAmount(
                                      //       totalAmount + 40);
                                      // }

                                      print(totalAmount);
                                      print(Provider.of<APIData>(context,
                                              listen: false)
                                          .totalAmount);
                                    } catch (e) {
                                      print(e);
                                    }
                                    if (snapshot.data.length == 0) {
                                      return Container();
                                    } else {
                                      return Container(
                                        child: Column(children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  snapshot.data[index][0]
                                                      .categoryName,
                                                  style: TextStyle(
                                                      color: Colors.purple[600],
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  snapshot.data[index].length
                                                          .toString() +
                                                      " Items",
                                                  style: TextStyle(
                                                      color: Colors.purple[600],
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Container(
                                              child: Column(
                                                children: [
                                                  for (int i = 0;
                                                      i <
                                                          snapshot.data[index]
                                                              .length;
                                                      i++) ...{
                                                    Container(
                                                      color: Colors.white,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Padding(
                                                                  padding: EdgeInsets
                                                                      .fromLTRB(
                                                                          8,
                                                                          16,
                                                                          8,
                                                                          0),
                                                                  child:
                                                                      Container(
                                                                    height: 85,
                                                                    width: 85,
                                                                    child:
                                                                        CachedNetworkImage(
                                                                      imageUrl:
                                                                          "http://uprank.live/farmerskart/images/product/${snapshot.data[index][i].productImage}",
                                                                      imageBuilder:
                                                                          (context, imageProvider) =>
                                                                              Container(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          image: DecorationImage(
                                                                              image: imageProvider,
                                                                              fit: BoxFit.fill,
                                                                              colorFilter: ColorFilter.mode(Colors.transparent, BlendMode.colorBurn)),
                                                                        ),
                                                                      ),
                                                                      placeholder:
                                                                          (context, url) =>
                                                                              CircularProgressIndicator(),
                                                                      errorWidget: (context,
                                                                              url,
                                                                              error) =>
                                                                          Icon(Icons
                                                                              .error),
                                                                    ),
                                                                  )),
                                                              Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceAround,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Padding(
                                                                      padding: EdgeInsets.only(
                                                                          top:
                                                                              8,
                                                                          left:
                                                                              8,
                                                                          bottom:
                                                                              8),
                                                                      child:
                                                                          Text(
                                                                        snapshot
                                                                            .data[index][i]
                                                                            .productName
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.purple[600],
                                                                            fontSize: 15),
                                                                      )),
                                                                  Padding(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              8),
                                                                      child:
                                                                          Text(
                                                                        snapshot
                                                                            .data[index][i]
                                                                            .weight,
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.amber[600],
                                                                            fontSize: 15),
                                                                      )),
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Text(
                                                                        "₹ ${snapshot.data[index][i].unitPrice}",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.purple[600],
                                                                            fontSize: 15),
                                                                      ),
                                                                      SizedBox(
                                                                        width: snapshot.data[index][i].unitPrice ==
                                                                                snapshot.data[index][i].unitOriginalPrice
                                                                            ? 100
                                                                            : 45,
                                                                      ),
                                                                      snapshot.data[index][i].unitPrice == snapshot.data[index][i].unitOriginalPrice
                                                                          ? Container()
                                                                          : Text(
                                                                              "₹ ${snapshot.data[index][i].unitOriginalPrice}",
                                                                              style: TextStyle(color: Colors.purple[600], fontSize: 15, decoration: TextDecoration.lineThrough)),
                                                                      snapshot.data[index][i].unitPrice !=
                                                                              snapshot.data[index][i].unitOriginalPrice
                                                                          ? SizedBox(
                                                                              width: 45,
                                                                            )
                                                                          : Container(),
                                                                      IconButton(
                                                                          onPressed:
                                                                              () {
                                                                            showDialog(
                                                                                context: context,
                                                                                builder: (context) => AlertDialog(
                                                                                      content: Text("Do you want to delete product from cart ?"),
                                                                                      title: Text("Delete"),
                                                                                      actions: [
                                                                                        TextButton(
                                                                                            onPressed: () {
                                                                                              Navigator.pop(context);
                                                                                            },
                                                                                            child: Text(
                                                                                              "NO",
                                                                                              style: TextStyle(color: Colors.black),
                                                                                            )),
                                                                                        TextButton(
                                                                                            onPressed: () async {
                                                                                              bool deleted = await deleteFromCart(snapshot.data[index][i].productId, snapshot.data[index][i].weight);
                                                                                              if (deleted) {
                                                                                                Navigator.pop(context);
                                                                                                setState(() {});
                                                                                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Deleted Successfully")));
                                                                                              } else {
                                                                                                Navigator.pop(context);
                                                                                                setState(() {});
                                                                                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Something Went Wrong, Please try Again!!")));
                                                                                              }
                                                                                            },
                                                                                            child: Text(
                                                                                              "YES",
                                                                                              style: TextStyle(color: Colors.black),
                                                                                            ))
                                                                                      ],
                                                                                    ));
                                                                          },
                                                                          icon:
                                                                              Icon(Icons.delete)),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 15,
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets.only(
                                                                right: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width /
                                                                    10),
                                                            child: InkWell(
                                                              onTap: () {
                                                                setState(() {});
                                                              },
                                                              child: Align(
                                                                alignment: Alignment
                                                                    .centerRight,
                                                                child: CustomStepper(
                                                                    1,
                                                                    10,
                                                                    1,
                                                                    1.0,
                                                                    int.parse(snapshot
                                                                        .data[index]
                                                                            [i]
                                                                        .quantity),
                                                                    snapshot
                                                                        .data[index]
                                                                            [i]
                                                                        .productId,
                                                                    int.parse(snapshot
                                                                        .data[index]
                                                                            [i]
                                                                        .quantity),
                                                                    snapshot
                                                                        .data[index]
                                                                            [i]
                                                                        .unitPrice,
                                                                    snapshot
                                                                        .data[
                                                                            index]
                                                                            [i]
                                                                        .weight,
                                                                    snapshot
                                                                        .data[
                                                                            index]
                                                                            [i]
                                                                        .unit,
                                                                    snapshot
                                                                        .data[
                                                                            index]
                                                                            [i]
                                                                        .unitOriginalPrice),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 15,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Flexible(
                                                                flex: 2,
                                                                child: Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              8.0),
                                                                  child:
                                                                      TextField(
                                                                    controller:
                                                                        specificationController,
                                                                    decoration:
                                                                        InputDecoration(
                                                                      hintText:
                                                                          "Enter specification",
                                                                      border: OutlineInputBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(10)),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Flexible(
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          8.0),
                                                                  child: MaterialButton(
                                                                      minWidth: MediaQuery.of(context).size.width / 4,
                                                                      color: Colors.purple[600],
                                                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                                                      elevation: 10,
                                                                      child: Text(
                                                                        "SAVE",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                            fontSize: 15),
                                                                      ),
                                                                      onPressed: () {
                                                                        addSpecification(
                                                                            snapshot.data[index][i].productId,
                                                                            specificationController.text);
                                                                      }),
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                  },
                                                ],
                                              ),
                                            ),
                                          ),
                                        ]),
                                      );
                                    }
                                  }));
                        } else if (snapshot.hasError) {
                          print(snapshot.error);
                        } else {
                          if (snapshot.data.length == 0) {
                            return Container();
                          } else {
                            return CircularProgressIndicator();
                          }
                        }
                      }
                      return Expanded(child: Container());
                    }),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 6,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  flex: 2,
                                  child: TextField(
                                    controller: couponController,
                                    decoration: InputDecoration(
                                      hintText: "Enter Coupon Code",
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: MaterialButton(
                                    minWidth:
                                        MediaQuery.of(context).size.width / 3,
                                    color: Colors.purple[600],
                                    child: Text(
                                      "Apply",
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.white),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    elevation: 10,
                                    onPressed: () {
                                      getCoupon();
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Delivery Charge",
                                  style: TextStyle(fontSize: 15),
                                ),
                                Consumer<APIData>(
                                    builder: (context, charges, child) {
                                  return Text(
                                    "₹ ${charges.deliveryCharges}",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.purple[600]),
                                  );
                                }),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              "Delivery charges can be waived off on addition of items worth Rs.200",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.green),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
          Padding(
            padding: EdgeInsets.all(5.0),
            child: Container(
              color: Colors.amber[600],
              height: MediaQuery.of(context).size.height / 9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Consumer<APIData>(builder: (context, data, child) {
                          return Flexible(
                              child: Text("₹ " + data.totalAmount.toString()));
                        }),
                        Consumer<APIData>(builder: (context, data, child) {
                          return Flexible(
                              child: Text("Saved  ₹ " +
                                  data.discountAmount.toString()));
                        }),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: MaterialButton(
                        height:
                            (MediaQuery.of(context).size.height / 9) * 2 / 3,
                        minWidth: MediaQuery.of(context).size.width / 3,
                        color: Colors.purple[600],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 10,
                        child: Text(
                          "PLACE ORDER",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          print(Provider.of<APIData>(context, listen: false)
                              .centerId);
                          if (Provider.of<APIData>(context, listen: false)
                                  .address ==
                              null) {
                            Provider.of<APIData>(context, listen: false)
                                .initializeAddress(
                                    Provider.of<APIData>(context, listen: false)
                                        .user
                                        .address);
                          }
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DeliveryAddress(
                                      totalAmount: totalAmount,
                                      productOrderId: productOrderId,
                                      deliveryCharges: deliveryCharges,
                                      couponCode: couponController.text,
                                      couponId: couponId,
                                      couponValue: couponValue,
                                      couponApplied: couponApplied,
                                    )),
                          );
                        }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Navigate(),
    );
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
    String orderNumber = '';
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

  void addSpecification(String productId, String specification) async {
    String userId = Provider.of<APIData>(context, listen: false).user.id;
    http.Response response;
    String url =
        "$header/app_api/addProductSpecification.php?user_id=$userId&product_id=$productId&specification=$specification";
    Uri uri = Uri.parse(url);
    response = await http.get(uri);
    var jsonData = jsonDecode(response.body);
    if (jsonData["code"] == "200") {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Specification Added Successfully")));
      setState(() {});
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Something Went Wrong")));
    }
  }

  Future<bool> deleteFromCart(String productId, String weight) async {
    String userId = Provider.of<APIData>(context, listen: false).userId;
    bool deleted = false;
    http.Response response;
    String url =
        "$header/app_api/deletefromcart_order.php?user_id=$userId&product_id=$productId&weight=$weight";
    Uri uri = Uri.parse(url);
    response = await http.get(uri);
    var jsonData = jsonDecode(response.body);
    if (jsonData["code"] == "200") {
      deleted = true;
    } else {
      deleted = false;
    }
    return deleted;
  }

  Future<List> getCartProducts() async {
    String userId = Provider.of<APIData>(context, listen: false).user.id;
    http.Response response;
    String url = "$header/app_api/getCartProducts.php?user_id=$userId";
    print(url);
    Uri uri = Uri.parse(url);
    response = await http.get(uri);
    var jsonData = jsonDecode(response.body);
    List cartproductsList = jsonData["order"];
    List productCategories = [];
    if (jsonData["code"] == "200") {
      for (int i = 0; i < cartproductsList.length; i++) {
        String category = cartproductsList[i]["category_name"];
        if (!productCategories.contains(category)) {
          productCategories.add(category);
        }
      }
    }
    List bakery = [];
    List vegetables = [];
    List grocery = [];
    List dairy = [];
    List pooja = [];
    for (int i = 0; i < cartproductsList.length; i++) {
      String category = cartproductsList[i]["category_name"];
      switch (category) {
        case "Fresh Vegetables & fruit":
          ProductsCart productsCart = new ProductsCart(
              cartproductsList[i]["category_name"],
              cartproductsList[i]["product_name"],
              cartproductsList[i]["product_img"],
              cartproductsList[i]["id"],
              cartproductsList[i]["user_id"],
              cartproductsList[i]["order_id"],
              cartproductsList[i]["quantity"],
              cartproductsList[i]["product_id"],
              cartproductsList[i]["unit_price"],
              cartproductsList[i]["order_status"],
              cartproductsList[i]["admin_status"],
              cartproductsList[i]["cart"],
              cartproductsList[i]["created_date"],
              cartproductsList[i]["total_amount"],
              cartproductsList[i]["updated_date"],
              cartproductsList[i]["cancelled_reason"],
              cartproductsList[i]["wallet"],
              cartproductsList[i]["weight"],
              cartproductsList[i]["specification"],
              cartproductsList[i]["coupon_value"],
              cartproductsList[i]["unit"],
              cartproductsList[i]["unit_original_price"],
              cartproductsList[i]["address_id"]);
          vegetables.add(productsCart);
          break;
        case "Grocery & Staples":
          ProductsCart productsCart = new ProductsCart(
              cartproductsList[i]["category_name"],
              cartproductsList[i]["product_name"],
              cartproductsList[i]["product_img"],
              cartproductsList[i]["id"],
              cartproductsList[i]["user_id"],
              cartproductsList[i]["order_id"],
              cartproductsList[i]["quantity"],
              cartproductsList[i]["product_id"],
              cartproductsList[i]["unit_price"],
              cartproductsList[i]["order_status"],
              cartproductsList[i]["admin_status"],
              cartproductsList[i]["cart"],
              cartproductsList[i]["created_date"],
              cartproductsList[i]["total_amount"],
              cartproductsList[i]["updated_date"],
              cartproductsList[i]["cancelled_reason"],
              cartproductsList[i]["wallet"],
              cartproductsList[i]["weight"],
              cartproductsList[i]["specification"],
              cartproductsList[i]["coupon_value"],
              cartproductsList[i]["unit"],
              cartproductsList[i]["unit_original_price"],
              cartproductsList[i]["address_id"]);
          grocery.add(productsCart);
          break;
        case "Bakery & Confectionery":
          ProductsCart productsCart = new ProductsCart(
              cartproductsList[i]["category_name"],
              cartproductsList[i]["product_name"],
              cartproductsList[i]["product_img"],
              cartproductsList[i]["id"],
              cartproductsList[i]["user_id"],
              cartproductsList[i]["order_id"],
              cartproductsList[i]["quantity"],
              cartproductsList[i]["product_id"],
              cartproductsList[i]["unit_price"],
              cartproductsList[i]["order_status"],
              cartproductsList[i]["admin_status"],
              cartproductsList[i]["cart"],
              cartproductsList[i]["created_date"],
              cartproductsList[i]["total_amount"],
              cartproductsList[i]["updated_date"],
              cartproductsList[i]["cancelled_reason"],
              cartproductsList[i]["wallet"],
              cartproductsList[i]["weight"],
              cartproductsList[i]["specification"],
              cartproductsList[i]["coupon_value"],
              cartproductsList[i]["unit"],
              cartproductsList[i]["unit_original_price"],
              cartproductsList[i]["address_id"]);
          bakery.add(productsCart);
          break;
        case "Dairy":
          ProductsCart productsCart = new ProductsCart(
              cartproductsList[i]["category_name"],
              cartproductsList[i]["product_name"],
              cartproductsList[i]["product_img"],
              cartproductsList[i]["id"],
              cartproductsList[i]["user_id"],
              cartproductsList[i]["order_id"],
              cartproductsList[i]["quantity"],
              cartproductsList[i]["product_id"],
              cartproductsList[i]["unit_price"],
              cartproductsList[i]["order_status"],
              cartproductsList[i]["admin_status"],
              cartproductsList[i]["cart"],
              cartproductsList[i]["created_date"],
              cartproductsList[i]["total_amount"],
              cartproductsList[i]["updated_date"],
              cartproductsList[i]["cancelled_reason"],
              cartproductsList[i]["wallet"],
              cartproductsList[i]["weight"],
              cartproductsList[i]["specification"],
              cartproductsList[i]["coupon_value"],
              cartproductsList[i]["unit"],
              cartproductsList[i]["unit_original_price"],
              cartproductsList[i]["address_id"]);
          dairy.add(productsCart);
          break;
        case "Pooja ":
          ProductsCart productsCart = new ProductsCart(
              cartproductsList[i]["category_name"],
              cartproductsList[i]["product_name"],
              cartproductsList[i]["product_img"],
              cartproductsList[i]["id"],
              cartproductsList[i]["user_id"],
              cartproductsList[i]["order_id"],
              cartproductsList[i]["quantity"],
              cartproductsList[i]["product_id"],
              cartproductsList[i]["unit_price"],
              cartproductsList[i]["order_status"],
              cartproductsList[i]["admin_status"],
              cartproductsList[i]["cart"],
              cartproductsList[i]["created_date"],
              cartproductsList[i]["total_amount"],
              cartproductsList[i]["updated_date"],
              cartproductsList[i]["cancelled_reason"],
              cartproductsList[i]["wallet"],
              cartproductsList[i]["weight"],
              cartproductsList[i]["specification"],
              cartproductsList[i]["coupon_value"],
              cartproductsList[i]["unit"],
              cartproductsList[i]["unit_original_price"],
              cartproductsList[i]["address_id"]);
          pooja.add(productsCart);
          break;
      }
    }
    List differentCategoryData = [];
    if (vegetables.isNotEmpty) {
      differentCategoryData.add(vegetables);
    }
    if (grocery.isNotEmpty) {
      differentCategoryData.add(grocery);
    }
    if (bakery.isNotEmpty) {
      differentCategoryData.add(bakery);
    }
    if (dairy.isNotEmpty) {
      differentCategoryData.add(dairy);
    }
    if (pooja.isNotEmpty) {
      differentCategoryData.add(pooja);
    }

    totalAmount = 0;
    totalDiscount = 0;
    if (differentCategoryData.length != 0) {
      for (int i = 0; i < differentCategoryData.length; i++) {
        for (int j = 0; j < differentCategoryData[i].length; j++) {
          totalAmount += double.parse(differentCategoryData[i][j].totalAmount);
          totalDiscount +=
              (double.parse(differentCategoryData[i][j].unitOriginalPrice) -
                  double.parse(differentCategoryData[i][j].unitPrice));
          if (!productOrderId.contains(differentCategoryData[i][j].id)) {
            productOrderId.add(differentCategoryData[i][j].id);
          }
        }
      }
      print("Hello WOrld 2");
      print(productOrderId);
      if (totalAmount > 200) {
        Provider.of<APIData>(context, listen: false)
            .initializeTotalAmount(totalAmount);

        Provider.of<APIData>(context, listen: false).initializeTotalDiscount(
          totalDiscount +
              Provider.of<APIData>(context, listen: false).deliveryCharges,
        );

        Provider.of<APIData>(context, listen: false).changeDeliveryCharges(0);
      } else {
        Provider.of<APIData>(context, listen: false).changeDeliveryCharges(40);
        Provider.of<APIData>(context, listen: false).initializeTotalAmount(
            totalAmount +
                Provider.of<APIData>(context, listen: false).deliveryCharges);

        Provider.of<APIData>(context, listen: false)
            .initializeTotalDiscount(totalDiscount);
      }
    } else {
      Provider.of<APIData>(context, listen: false)
          .initializeTotalAmount(totalAmount);
      print(Provider.of<APIData>(context, listen: false).totalAmount);
      Provider.of<APIData>(context, listen: false)
          .initializeTotalDiscount(totalDiscount);
    }
    int itemCount = 0;
    if (differentCategoryData.length != 0) {
      for (var item in differentCategoryData) {
        itemCount += item.length;
      }
    } else {
      itemCount = 0;
    }
    print(totalAmount);
    Provider.of<APIData>(context, listen: false)
        .inititalizeCartProductCount(itemCount);
    return differentCategoryData;
  }

  Future getCoupon() async {
    List couponData = [];
    String coupon = couponController.text;
    http.Response response;
    String url = "$header/app_api/getCoupon.php?coupon=$coupon";
    Uri uri = Uri.parse(url);
    response = await http.get(uri);
    var jsonData = jsonDecode(response.body);
    if (jsonData["code"] == "200") {
      if (Provider.of<APIData>(context, listen: false).totalAmount <
          double.parse(jsonData["coupon"][0]["minimum_order_amount"])) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(jsonData["msg"] +
                "\n" +
                "minimum order Amount Required " +
                jsonData["coupon"][0]["minimum_order_amount"])));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content:
                Text(jsonData["msg"] + "\n" + "Coupon Applied Successfully")));
        couponApplied = true;
        couponValue = jsonData["coupon"][0]["value"];
        couponId = jsonData["coupon"][0]["id"];
        Provider.of<APIData>(context, listen: false).initializeTotalAmount(
            Provider.of<APIData>(context, listen: false).totalAmount -
                double.parse(jsonData["coupon"][0]["value"]));
        Provider.of<APIData>(context, listen: false).initializeTotalDiscount(
            Provider.of<APIData>(context, listen: false).discountAmount +
                double.parse(jsonData["coupon"][0]["value"]));
      }
      for (var item in jsonData["coupon"]) {
        Coupon coupon = new Coupon(
            item["id"],
            item["code"],
            item["type"],
            item["value"],
            item["expiry"],
            item["minimum_order_amount"],
            item["del_flag"],
            item["hidden_coupon"]);
        couponData.add(coupon);
      }
      return couponData;
    } else if (jsonData["code"] == "401") {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(jsonData["msg"])));
    } else if (jsonData["code"] == "402") {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(jsonData["msg"])));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(jsonData["msg"])));
    }
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
      height: 40,
      width: 150,
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
              onTap: () {
                if (proQuantity > 1) {
                  setState(
                    () {
                      value =
                          value == lowerLimit ? lowerLimit : value -= stepValue;
                    },
                  );
                  proQuantity -= 1;
                  addProductToCart(productid, proQuantity.toString(), unitprice,
                      Weight, Unit, originalprice);
                }
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
                  child: Text(
                    '${value}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: InkWell(
              child: Icon(Icons.add, color: Colors.greenAccent, size: 20),
              onTap: () {
                setState(
                  () {
                    value =
                        value == upperLimit ? upperLimit : value += stepValue;
                  },
                );
                proQuantity += 1;
                addProductToCart(productid, proQuantity.toString(), unitprice,
                    Weight, Unit, originalprice);
              },
            ),
          ),
        ],
      ),
    );
  }
}

// class CustomStepper extends StatefulWidget {
//   CustomStepper({
//     @required this.lowerLimit,
//     @required this.upperLimit,
//     @required this.stepValue,
//     @required this.iconSize,
//     @required this.value,
//   });
//
//   final int lowerLimit;
//   final int upperLimit;
//   final int stepValue;
//   final double iconSize;
//   int value;
//
//   @override
//   _CustomStepperState createState() => _CustomStepperState();
// }

// class _CustomStepperState extends State<CustomStepper> {
//   @override
//   Widget CustomStepper(BuildContext context, lowerLimit, upperLimit,stepValue,iconSize,value) {
//     return Container(
//       height: 40,
//       width: 150,
//       decoration: BoxDecoration(
//           border: Border.all(color: Colors.purple),
//           borderRadius: BorderRadius.circular(5)),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           Expanded(
//             flex: 1,
//             child: GestureDetector(
//               child: Icon(
//                 Icons.remove,
//                 color: Colors.deepPurple,
//                 size: 20,
//               ),
//               onTap: () {
//                 setState(
//                   () {
//                     value = value == lowerLimit
//                         ? lowerLimit
//                         : value -= stepValue;
//                   },
//                 );
//               },
//             ),
//           ),
//           Expanded(
//             flex: 1,
//             child: Container(
//               decoration: BoxDecoration(
//                   gradient:
//                       LinearGradient(colors: [left, middle, Colors.purple])),
//               width: iconSize,
//               child: Center(
//                 child: FittedBox(
//                   child: Text(
//                     '${value}',
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: Colors.white,
//                       fontWeight: FontWeight.w600,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             flex: 1,
//             child: GestureDetector(
//               child: Icon(Icons.add, color: Colors.greenAccent, size: 20),
//               onTap: () {
//                 setState(
//                   () {
//                     value = value == upperLimit
//                         ? upperLimit
//                         : value += stepValue;
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class Navigate extends StatefulWidget {
  const Navigate({Key key}) : super(key: key);

  @override
  _NavigateState createState() => _NavigateState();
}

class _NavigateState extends State<Navigate> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30.0),
        topRight: Radius.circular(30.0),
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.grey[300],
        //type: BottomNavigationBarType.fixed,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey[500],
        showUnselectedLabels: true,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Home()));
                },
                child: Icon(Icons.home)),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Category()));
                },
                child: Icon(Icons.list)),
            title: Text('Categories'),
          ),
          BottomNavigationBarItem(
              icon: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Wishlist()));
                  },
                  child: Icon(CupertinoIcons.heart)),
              title: Text('Wishlist')),
        ],
      ),
    ));
  }
}
//Best selling products
