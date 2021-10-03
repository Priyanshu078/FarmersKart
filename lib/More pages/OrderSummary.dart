import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shellcode2/colors.dart';
import 'package:shellcode2/paymentOption.dart';
import 'package:intl/intl.dart';
import 'package:shellcode2/update_order.dart';

class OrderSummary extends StatefulWidget {
  List allOrders;
  List cancelledOrders;
  List todaysOrder;
  int index;
  OrderSummary({Key key}) : super(key: key);
  OrderSummary.allOrders(
      {Key key, @required this.allOrders, @required this.index})
      : super(key: key);
  OrderSummary.cancelledOrders(
      {Key key, @required this.cancelledOrders, @required this.index})
      : super(key: key);
  OrderSummary.todaysOrder(
      {Key key, @required this.todaysOrder, @required this.index})
      : super(key: key);

  @override
  _OrderSummaryState createState() => _OrderSummaryState();
}

class _OrderSummaryState extends State<OrderSummary> {
  double totalAmount = 0;
  List cartId = [];

  String getDateTime() {
    String formattedDateTime =
        DateFormat('yyyy-MM-dd \n kk:mm:ss').format(DateTime.now()).toString();
    return formattedDateTime;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.index == 0) {
      totalAmount = 0;
      for (int i = 0; i < widget.allOrders.length; i++) {
        totalAmount += double.parse(widget.allOrders[i].totalAmount);
      }
      totalAmount += double.parse(widget.allOrders[0].deliveryCharges);
      if (widget.allOrders[0].couponValue != '') {
        totalAmount -= double.parse(widget.allOrders[0].couponValue);
      }
    } else if (widget.index == 1) {
      totalAmount = 0;
      for (int i = 0; i < widget.todaysOrder.length; i++) {
        totalAmount += double.parse(widget.todaysOrder[i].totalAmount);
      }
      totalAmount += double.parse(widget.todaysOrder[0].deliveryCharges);
      if (widget.todaysOrder[0].couponValue != '') {
        totalAmount -= double.parse(widget.todaysOrder[0].couponValue);
      }
    } else {
      totalAmount = 0;
      for (int i = 0; i < widget.cancelledOrders.length; i++) {
        totalAmount += double.parse(widget.cancelledOrders[i].totalAmount);
      }
      totalAmount += double.parse(widget.cancelledOrders[0].deliveryCharges);
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Order Summary"),
        centerTitle: true,
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
      ),
      body: widget.index == 0
          ? Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Container(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width / 3 + 10,
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Total Amount ",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.purple[600]),
                                    ),
                                    Text(
                                      ":",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.purple[600]),
                                    )
                                  ])),
                          Text(
                            "₹ $totalAmount",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.red,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width / 3 + 10,
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Coupon Code ",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.purple[600]),
                                    ),
                                    Text(
                                      ":",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.purple[600]),
                                    )
                                  ])),
                          widget.allOrders[0].couponCode == ""
                              ? Text(
                                  "NA",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                )
                              : Text(
                                  "${widget.allOrders[0].couponCode}",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width / 3 +
                                            10,
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Payment Mode ",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.purple[600]),
                                          ),
                                          Text(
                                            ":",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.purple[600]),
                                          )
                                        ])),
                                Text(
                                  "${widget.allOrders[0].paymentOption}",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                )
                              ]),
                          widget.allOrders[0].paymentOption == 'COD'
                              ? Container(
                                  decoration: BoxDecoration(
                                      border: Border(
                                        top: BorderSide(
                                            width: 1.0, color: yellow),
                                        left: BorderSide(
                                            width: 1.0, color: yellow),
                                        right: BorderSide(
                                            width: 1.0, color: yellow),
                                        bottom: BorderSide(
                                            width: 1.0, color: yellow),
                                      ),
                                      borderRadius: BorderRadius.circular(5.0),
                                      gradient: LinearGradient(colors: [
                                        left,
                                        middle,
                                        Colors.purple
                                      ])),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(30),
                                    onTap: () {
                                      bool couponApplied = false;
                                      if (widget.allOrders[0].couponCode !=
                                          "") {
                                        couponApplied = true;
                                      }
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PaymentOption.paynow(
                                                      paynow: true,
                                                      orderNumber: widget
                                                          .allOrders[0].orderId,
                                                      totalAmount: totalAmount,
                                                      couponId: widget
                                                          .allOrders[0]
                                                          .couponId,
                                                      couponCode: widget
                                                          .allOrders[0]
                                                          .couponCode,
                                                      couponValue: widget
                                                          .allOrders[0]
                                                          .couponValue,
                                                      deliveryCharges:
                                                          double.parse(widget
                                                              .allOrders[0]
                                                              .deliveryCharges),
                                                      productOrderId: cartId,
                                                      couponApplied:
                                                          couponApplied)));
                                    },
                                    child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          "Pay Now",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        )),
                                  ),
                                )
                              : Container()
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width / 3 + 10,
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Center Address ",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.purple[600]),
                                    ),
                                    Text(
                                      ":",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.purple[600]),
                                    )
                                  ])),
                          Flexible(
                              child: Text(
                            "${widget.allOrders[0].center[0].centerName} , ${widget.allOrders[0].center[0].address} , ${widget.allOrders[0].center[0].pincode}",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ))
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width / 3 + 10,
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Delivery Date ",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.purple[600]),
                                    ),
                                    Text(
                                      ":",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.purple[600]),
                                    )
                                  ])),
                          Text(
                            "${widget.allOrders[0].deliveryDate}",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width / 3 + 10,
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Delivery Time ",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.purple[600],
                                      ),
                                    ),
                                    Text(
                                      ":",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.purple[600]),
                                    )
                                  ])),
                          Text(
                            "${widget.allOrders[0].deliveryTime}",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      getDateTime().split(" ")[0].trim() ==
                              widget.allOrders[0].createdDate
                                  .toString()
                                  .split(" ")[0]
                                  .trim()
                          ? SizedBox(
                              height: 20,
                            )
                          : Container(),
                      getDateTime().split(" ")[0].trim() ==
                              widget.allOrders[0].createdDate
                                  .toString()
                                  .split(" ")[0]
                                  .trim()
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Anything forgot to add : ",
                                  style: TextStyle(
                                      color: Colors.purple[600],
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                Flexible(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                          top: BorderSide(
                                              width: 1.0, color: yellow),
                                          left: BorderSide(
                                              width: 1.0, color: yellow),
                                          right: BorderSide(
                                              width: 1.0, color: yellow),
                                          bottom: BorderSide(
                                              width: 1.0, color: yellow),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        gradient: LinearGradient(colors: [
                                          left,
                                          middle,
                                          Colors.purple
                                        ])),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(30),
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    UpdateOrder()));
                                      },
                                      child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                            "Update Order Now",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          )),
                                    ),
                                  ),
                                )
                              ],
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.only(left: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Order product list :",
                    style: TextStyle(
                        color: Colors.amber,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: ListView.builder(
                      itemCount: widget.allOrders.length,
                      itemBuilder: (context, int index) {
                        print(widget.allOrders[index].productImage);
                        cartId = [];
                        for (int i = 0; i < widget.allOrders.length; i++) {
                          cartId.add(widget.allOrders[i].id);
                        }
                        return Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          elevation: 5,
                          child: Container(
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(16),
                                  child: Row(
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
                                          child: Container(
                                            height: 75,
                                            width: 75,
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  "http://uprank.live/farmerskart/images/product/${widget.allOrders[index].productImage}",
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                      Container(
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.fill,
                                                      colorFilter:
                                                          ColorFilter.mode(
                                                              Colors
                                                                  .transparent,
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
                                        ),
                                      ),
                                      Flexible(
                                        child: Text(
                                          "${widget.allOrders[index].productName} ${widget.allOrders[index].weight}",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.purple[600]),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Row(children: [
                                    Text("Status : ",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.amber,
                                            fontWeight: FontWeight.bold)),
                                    Text(
                                        "${widget.allOrders[index].orderStatus}",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.purple[600],
                                            fontWeight: FontWeight.bold)),
                                  ]),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              )
            ])
          : widget.index == 1
              ? Column(children: [
                  Container(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  width: MediaQuery.of(context).size.width / 3 +
                                      10,
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Total Amount ",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.purple[600]),
                                        ),
                                        Text(
                                          ":",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.purple[600]),
                                        )
                                      ])),
                              Text(
                                "₹ $totalAmount",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  width: MediaQuery.of(context).size.width / 3 +
                                      10,
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Coupon Code ",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.purple[600]),
                                        ),
                                        Text(
                                          ":",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.purple[600]),
                                        )
                                      ])),
                              widget.todaysOrder[0].couponCode == ""
                                  ? Text(
                                      "NA",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    )
                                  : Text(
                                      "${widget.todaysOrder[0].couponCode}",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                    3 +
                                                10,
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Payment Mode ",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.purple[600]),
                                              ),
                                              Text(
                                                ":",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.purple[600]),
                                              )
                                            ])),
                                    Text(
                                      "${widget.todaysOrder[0].paymentOption}",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                widget.todaysOrder[0].paymentOption == 'COD'
                                    ? Container(
                                        decoration: BoxDecoration(
                                            border: Border(
                                              top: BorderSide(
                                                  width: 1.0, color: yellow),
                                              left: BorderSide(
                                                  width: 1.0, color: yellow),
                                              right: BorderSide(
                                                  width: 1.0, color: yellow),
                                              bottom: BorderSide(
                                                  width: 1.0, color: yellow),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            gradient: LinearGradient(colors: [
                                              left,
                                              middle,
                                              Colors.purple
                                            ])),
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          onTap: () {
                                            bool couponApplied = false;
                                            if (widget.todaysOrder[0]
                                                    .couponCode !=
                                                "") {
                                              couponApplied = true;
                                            }
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        PaymentOption.paynow(
                                                            paynow: true,
                                                            orderNumber: widget
                                                                .todaysOrder[0]
                                                                .orderId,
                                                            totalAmount:
                                                                totalAmount,
                                                            couponId: widget
                                                                .todaysOrder[0]
                                                                .couponId,
                                                            couponCode:
                                                                widget
                                                                    .todaysOrder[
                                                                        0]
                                                                    .couponCode,
                                                            couponValue: widget
                                                                .todaysOrder[0]
                                                                .couponValue,
                                                            deliveryCharges:
                                                                double.parse(widget
                                                                    .todaysOrder[
                                                                        0]
                                                                    .deliveryCharges),
                                                            productOrderId:
                                                                cartId,
                                                            couponApplied:
                                                                couponApplied)));
                                          },
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Text(
                                                "Pay Now",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                        ),
                                      )
                                    : Container()
                              ]),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  width: MediaQuery.of(context).size.width / 3 +
                                      10,
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Center Address ",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.purple[600]),
                                        ),
                                        Text(
                                          ":",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.purple[600]),
                                        )
                                      ])),
                              Flexible(
                                child: Text(
                                  "${widget.todaysOrder[0].center[0].centerName} , ${widget.todaysOrder[0].center[0].address} , ${widget.todaysOrder[0].center[0].pincode}",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  width: MediaQuery.of(context).size.width / 3 +
                                      10,
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Delivery Date ",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.purple[600]),
                                        ),
                                        Text(
                                          ":",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.purple[600]),
                                        )
                                      ])),
                              Text(
                                "${widget.todaysOrder[0].deliveryDate}",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  width: MediaQuery.of(context).size.width / 3 +
                                      10,
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Delivery Time ",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.purple[600]),
                                        ),
                                        Text(
                                          ":",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.purple[600]),
                                        )
                                      ])),
                              Text(
                                "${widget.todaysOrder[0].deliveryTime}",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          getDateTime().split(" ")[0].trim() ==
                                  widget.todaysOrder[0].createdDate
                                      .toString()
                                      .split(" ")[0]
                                      .trim()
                              ? SizedBox(
                                  height: 20,
                                )
                              : Container(),
                          getDateTime().split(" ")[0].trim() ==
                                  widget.todaysOrder[0].createdDate
                                      .toString()
                                      .split(" ")[0]
                                      .trim()
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Anything forgot to add : ",
                                      style: TextStyle(
                                          color: Colors.purple[600],
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Flexible(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border(
                                              top: BorderSide(
                                                  width: 1.0, color: yellow),
                                              left: BorderSide(
                                                  width: 1.0, color: yellow),
                                              right: BorderSide(
                                                  width: 1.0, color: yellow),
                                              bottom: BorderSide(
                                                  width: 1.0, color: yellow),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            gradient: LinearGradient(colors: [
                                              left,
                                              middle,
                                              Colors.purple
                                            ])),
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        UpdateOrder()));
                                          },
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Text(
                                                "Update Order Now",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Order product list :",
                        style: TextStyle(
                            color: Colors.amber,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(16),
                      child: ListView.builder(
                          itemCount: widget.todaysOrder.length,
                          itemBuilder: (context, int index) {
                            cartId = [];
                            for (int i = 0;
                                i < widget.todaysOrder.length;
                                i++) {
                              cartId.add(widget.todaysOrder[i].id);
                            }
                            return Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              elevation: 5,
                              child: Container(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(16),
                                      child: Row(
                                        children: [
                                          Align(
                                            alignment: Alignment.topCenter,
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(right: 8.0),
                                              child: Container(
                                                height: 75,
                                                width: 75,
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                      "http://uprank.live/farmerskart/images/product/${widget.todaysOrder[index].productImage}",
                                                  imageBuilder: (context,
                                                          imageProvider) =>
                                                      Container(
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: imageProvider,
                                                          fit: BoxFit.fill,
                                                          colorFilter:
                                                              ColorFilter.mode(
                                                                  Colors
                                                                      .transparent,
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
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                              "${widget.todaysOrder[index].productName} ${widget.todaysOrder[index].weight}",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.purple[600]),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Row(children: [
                                        Text("Status : ",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.amber,
                                                fontWeight: FontWeight.bold)),
                                        Text(
                                            "${widget.todaysOrder[index].orderStatus}",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.purple[600],
                                                fontWeight: FontWeight.bold)),
                                      ]),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                  )
                ])
              : Column(children: [
                  Container(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  width: MediaQuery.of(context).size.width / 3 +
                                      10,
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Total Amount ",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.purple[600]),
                                        ),
                                        Text(
                                          ":",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.purple[600]),
                                        )
                                      ])),
                              Text(
                                "₹ $totalAmount",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  width: MediaQuery.of(context).size.width / 3 +
                                      10,
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Coupon Code ",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.purple[600]),
                                        ),
                                        Text(
                                          ":",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.purple[600]),
                                        )
                                      ])),
                              widget.cancelledOrders[0].couponCode == null
                                  ? Text(
                                      "NA",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    )
                                  : Text(
                                      "${widget.cancelledOrders[0].couponCode}",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  width: MediaQuery.of(context).size.width / 3 +
                                      10,
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Payment Mode ",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.purple[600]),
                                        ),
                                        Text(
                                          ":",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.purple[600]),
                                        )
                                      ])),
                              Text(
                                "${widget.cancelledOrders[0].paymentOption}",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  width: MediaQuery.of(context).size.width / 3 +
                                      10,
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Center Address ",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.purple[600]),
                                        ),
                                        Text(
                                          ":",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.purple[600]),
                                        )
                                      ])),
                              widget.cancelledOrders[0].addressId == null
                                  ? Text("")
                                  : Text(
                                      "${widget.cancelledOrders[0].addressId}",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  width: MediaQuery.of(context).size.width / 3 +
                                      10,
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Delivery Date ",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.purple[600]),
                                        ),
                                        Text(
                                          ":",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.purple[600]),
                                        )
                                      ])),
                              Text(
                                "${widget.cancelledOrders[0].deliveryDate}",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  width: MediaQuery.of(context).size.width / 3 +
                                      10,
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Delivery Time ",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.purple[600]),
                                        ),
                                        Text(
                                          ":",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.purple[600]),
                                        )
                                      ])),
                              Text(
                                "${widget.cancelledOrders[0].deliveryTime}",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Order product list :",
                        style: TextStyle(
                            color: Colors.amber,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(16),
                      child: ListView.builder(
                          itemCount: widget.cancelledOrders.length,
                          itemBuilder: (context, int index) {
                            return Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              elevation: 5,
                              child: Container(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(16),
                                      child: Row(
                                        children: [
                                          Align(
                                            alignment: Alignment.topCenter,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                height: 75,
                                                width: 75,
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                      "http://uprank.live/farmerskart/images/product/${widget.cancelledOrders[index].productImage}",
                                                  imageBuilder: (context,
                                                          imageProvider) =>
                                                      Container(
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: imageProvider,
                                                          fit: BoxFit.fill,
                                                          colorFilter:
                                                              ColorFilter.mode(
                                                                  Colors
                                                                      .transparent,
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
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                              "${widget.cancelledOrders[index].productName} ${widget.cancelledOrders[index].weight}",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.purple[600]),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Row(children: [
                                        Text("Status : ",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.amber,
                                                fontWeight: FontWeight.bold)),
                                        Text(
                                            "${widget.cancelledOrders[index].orderStatus}",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.purple[600],
                                                fontWeight: FontWeight.bold)),
                                      ]),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                  )
                ]),
    );
  }
}
