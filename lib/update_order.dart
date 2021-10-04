import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shellcode2/Provider/data.dart';
import 'package:shellcode2/add_Product.dart';
import 'package:shellcode2/apiData/Constants.dart';
import 'package:shellcode2/paymentOption.dart';
import 'package:http/http.dart' as http;

import 'colors.dart';

class UpdateOrder extends StatefulWidget {
  String orderId, couponCode, couponValue, couponId, deliveryCharges;
  bool couponApplied;
  UpdateOrder({
    Key key,
    @required this.orderId,
    @required this.couponId,
    @required this.couponValue,
    @required this.couponCode,
    @required this.deliveryCharges,
    @required this.couponApplied,
  }) : super(key: key);

  @override
  _UpdateOrderState createState() => _UpdateOrderState();
}

class _UpdateOrderState extends State<UpdateOrder> {
  double totalAmount = 0.0;
  List cartId = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Order"),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [left, middle, Colors.purple])),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
                child: Container(
              child: FutureBuilder(
                future: getAddedProducts(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      return ListView.separated(
                          itemBuilder: (context, index) {
                            return Card(
                                margin: EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Text(
                                        '${snapshot.data[index].categoryName}',
                                        style: TextStyle(color: Colors.purple),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 100,
                                          height: 100,
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                "http://uprank.live/farmerskart/images/product/${snapshot.data[index].productImage}",
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    Container(
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.fill,
                                                    colorFilter:
                                                        ColorFilter.mode(
                                                            Colors.transparent,
                                                            BlendMode
                                                                .colorBurn)),
                                              ),
                                            ),
                                            placeholder: (context, url) =>
                                                CircularProgressIndicator(),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                          ),
                                        ),
                                        Flexible(
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 20, right: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${snapshot.data[index].productName}',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      color: Colors
                                                          .purple.shade200,
                                                    ),
                                                    padding: EdgeInsets.all(8),
                                                    child: Text(
                                                        '${snapshot.data[index].weight.toString().split(" ")[0]} ${snapshot.data[index].unit}',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.purple,
                                                            fontSize: 18))),
                                                Row(
                                                  children: [
                                                    Text(
                                                      '₹ ${snapshot.data[index].totalAmount}',
                                                      style: TextStyle(
                                                          color: Colors.purple,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Spacer(),
                                                    IconButton(
                                                      onPressed: () async {
                                                        showDialog(
                                                            context: context,
                                                            builder:
                                                                (context) =>
                                                                    AlertDialog(
                                                                      content: Text(
                                                                          "Do you want to delete product from cart ?"),
                                                                      title: Text(
                                                                          "Delete"),
                                                                      actions: [
                                                                        TextButton(
                                                                            onPressed:
                                                                                () {
                                                                              Navigator.pop(context);
                                                                            },
                                                                            child:
                                                                                Text(
                                                                              "NO",
                                                                              style: TextStyle(color: Colors.black),
                                                                            )),
                                                                        TextButton(
                                                                            onPressed:
                                                                                () async {
                                                                              bool deleted = await deleteFromCart(snapshot.data[index].productId, snapshot.data[index].weight);
                                                                              if (deleted) {
                                                                                Navigator.pop(context);
                                                                                setState(() {});
                                                                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Product Deleted Successfully")));
                                                                              } else {
                                                                                Navigator.pop(context);
                                                                                setState(() {});
                                                                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Something Went Wrong, Please try Again!!")));
                                                                              }
                                                                            },
                                                                            child:
                                                                                Text(
                                                                              "YES",
                                                                              style: TextStyle(color: Colors.black),
                                                                            ))
                                                                      ],
                                                                    ));
                                                      },
                                                      icon: Icon(Icons.delete),
                                                      color: Colors.amber[600],
                                                    ),
                                                  ],
                                                ),
                                                Row(children: [
                                                  InkWell(
                                                    onTap: () async {
                                                      int quantity = int.parse(
                                                          snapshot.data[index]
                                                              .quantity);
                                                      if (quantity > 1) {
                                                        quantity -= 1;
                                                      } else {
                                                        quantity = 1;
                                                      }
                                                      bool added =
                                                          await addProductToCart(
                                                              snapshot
                                                                  .data[index]
                                                                  .productId,
                                                              quantity
                                                                  .toString(),
                                                              snapshot
                                                                  .data[index]
                                                                  .unitPrice,
                                                              snapshot
                                                                  .data[index]
                                                                  .weight,
                                                              snapshot
                                                                  .data[index]
                                                                  .unit,
                                                              snapshot
                                                                  .data[index]
                                                                  .unitOriginalPrice);
                                                      if (added) {
                                                        setState(() {});
                                                        showSnackBar(
                                                            "Product Updated in cart successfully");
                                                      } else {
                                                        setState(() {});
                                                        showSnackBar(
                                                            "Something Went Wrong");
                                                      }
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5)),
                                                          color: Colors.white,
                                                          border: Border.all(
                                                              color:
                                                                  Colors.purple,
                                                              width: 2)),
                                                      child: Icon(
                                                        Icons.remove,
                                                        color:
                                                            Colors.purple[600],
                                                        size: 30,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                      width: 35,
                                                      height: 35,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5)),
                                                          border: Border.all(
                                                              color: Colors
                                                                  .orange),
                                                          color: Colors.purple,
                                                          gradient:
                                                              LinearGradient(
                                                                  colors: [
                                                                left,
                                                                middle,
                                                                Colors.purple
                                                              ])),
                                                      child: Center(
                                                        child: Text(
                                                          '${snapshot.data[index].quantity}',
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      )),
                                                  InkWell(
                                                    onTap: () async {
                                                      int quantity = int.parse(
                                                          snapshot.data[index]
                                                              .quantity);
                                                      quantity += 1;
                                                      bool added =
                                                          await addProductToCart(
                                                              snapshot
                                                                  .data[index]
                                                                  .productId,
                                                              quantity
                                                                  .toString(),
                                                              snapshot
                                                                  .data[index]
                                                                  .unitPrice,
                                                              snapshot
                                                                  .data[index]
                                                                  .weight,
                                                              snapshot
                                                                  .data[index]
                                                                  .unit,
                                                              snapshot
                                                                  .data[index]
                                                                  .unitOriginalPrice);
                                                      if (added) {
                                                        setState(() {});
                                                        showSnackBar(
                                                            "Product Updated in cart successfully");
                                                      } else {
                                                        setState(() {});
                                                        showSnackBar(
                                                            "Something Went Wrong");
                                                      }
                                                    },
                                                    child: Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            5)),
                                                            color: Colors.white,
                                                            border: Border.all(
                                                                color: Colors
                                                                    .purple,
                                                                width: 2)),
                                                        child: Icon(
                                                          Icons.add,
                                                          color: Colors
                                                              .purple[600],
                                                          size: 30,
                                                        )),
                                                  ),
                                                ]),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ));
                          },
                          separatorBuilder: (context, index) {
                            return Divider(
                              height: 10,
                              color: Colors.black,
                            );
                          },
                          itemCount: snapshot.data.length);
                    } else if (snapshot.hasError) {
                      print(snapshot.error);
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            )),
            Consumer<APIData>(builder: (context, data, child) {
              return Padding(
                padding: EdgeInsets.only(bottom: 5.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Colors.purple[600]),
                  padding: EdgeInsets.all(10.0),
                  width: MediaQuery.of(context).size.width,
                  child: Expanded(
                      child: Text(
                    "Total amount : ₹ ${data.totalAddedProductAmount}",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  )),
                ),
              );
            }),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  child: Container(
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
                    child: InkWell(
                      borderRadius: BorderRadius.circular(30),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PaymentOption.updateOrder(
                                    updateOrder: true,
                                    orderNumber: widget.orderId,
                                    totalAmount: Provider.of<APIData>(context,
                                            listen: false)
                                        .totalAddedProductAmount,
                                    couponId: widget.couponId,
                                    couponCode: widget.couponCode,
                                    couponValue: widget.couponValue,
                                    deliveryCharges:
                                        double.parse(widget.deliveryCharges),
                                    productOrderId: cartId,
                                    couponApplied: widget.couponApplied)));
                      },
                      child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(children: [
                            Icon(
                              Icons.check,
                              color: Colors.amber[600],
                            ),
                            Expanded(
                              child: Text(
                                "Place Order",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ])),
                    ),
                  ),
                ),
                Flexible(
                  child: Container(
                    margin: EdgeInsets.only(left: 15),
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
                    child: InkWell(
                      borderRadius: BorderRadius.circular(30),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddProduct(
                                      orderId: widget.orderId,
                                    )));
                      },
                      child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(children: [
                            Icon(
                              Icons.shopping_cart,
                              color: Colors.amber[600],
                            ),
                            Expanded(
                              child: Text(
                                "Add",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ])),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
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

  void showSnackBar(String content) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(content)));
  }

  Future<List> getAddedProducts() async {
    String userId = Provider.of<APIData>(context, listen: false).userId;
    String orderId = widget.orderId;
    String url =
        "$header/app_api/orderupdate_cart.php?user_id=$userId&order_id=$orderId";
    Uri uri = Uri.parse(url);
    http.Response response = await http.get(uri);
    var jsonData = jsonDecode(response.body);
    List addedProducts = [];
    if (jsonData["code"] == "200") {
      for (var item in jsonData["order"]) {
        AddedProductsData addedProductsData = new AddedProductsData(
            item["category_name"],
            item["product_name"],
            item["product_img"],
            item["id"],
            item["user_id"],
            item["order_id"],
            item["address_id"],
            item["quantity"],
            item["product_id"],
            item["unit_price"],
            item["order_status"],
            item["admin_status"],
            item["is_refundable"],
            item["expected_delivery"],
            item["cart"],
            item["created_date"],
            item["total_amount"],
            item["updated_date"],
            item["cancelled_reason"],
            item["wallet"],
            item["weight"],
            item["coupon_value"],
            item["unit"],
            item["unit_original_price"],
            item["specification"]);
        addedProducts.add(addedProductsData);
      }
    }
    totalAmount = 0.0;
    for (var item in addedProducts) {
      totalAmount += double.parse(item.totalAmount);
      cartId.add(item.id);
    }
    print(cartId.toString());
    Provider.of<APIData>(context, listen: false)
        .initializetotalAddedProductAmount(totalAmount);
    return addedProducts;
  }
}

class AddedProductsData {
  String categoryName;
  String productName;
  String productImage;
  String id;
  String userId;
  String orderId;
  String addressId;
  String quantity;
  String productId;
  String unitPrice;
  String orderStatus;
  String adminStatus;
  String isRefundable;
  String expectedDelivery;
  String cart;
  String createdDate;
  String totalAmount;
  String updatedDate;
  String cancelledReason;
  String wallet;
  String weight;
  String couponValue;
  String unit;
  String unitOriginalPrice;
  String specification;
  AddedProductsData(
    this.categoryName,
    this.productName,
    this.productImage,
    this.id,
    this.userId,
    this.orderId,
    this.addressId,
    this.quantity,
    this.productId,
    this.unitPrice,
    this.orderStatus,
    this.adminStatus,
    this.isRefundable,
    this.expectedDelivery,
    this.cart,
    this.createdDate,
    this.totalAmount,
    this.updatedDate,
    this.cancelledReason,
    this.wallet,
    this.weight,
    this.couponValue,
    this.unit,
    this.unitOriginalPrice,
    this.specification,
  );
}
