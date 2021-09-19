import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shellcode2/colors.dart';

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
  @override
  Widget build(BuildContext context) {
    if (widget.index == 0) {
      totalAmount = 0;
      for (int i = 0; i < widget.allOrders.length; i++) {
        totalAmount += double.parse(widget.allOrders[i].totalAmount);
      }
    } else if (widget.index == 1) {
      totalAmount = 0;
      for (int i = 0; i < widget.todaysOrder.length; i++) {
        totalAmount += double.parse(widget.todaysOrder[i].totalAmount);
      }
    } else {
      totalAmount = 0;
      for (int i = 0; i < widget.cancelledOrders.length; i++) {
        totalAmount += double.parse(widget.cancelledOrders[i].totalAmount);
      }
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
                          totalAmount > 240
                              ? Text(
                                  "₹ $totalAmount",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold),
                                )
                              : Text(
                                  "₹ ${totalAmount + 40}",
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width / 3 + 10,
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
                      itemCount: widget.allOrders.length,
                      itemBuilder: (context, int index) {
                        print(widget.allOrders[index].productImage);
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
                              totalAmount > 240
                                  ? Text(
                                      "₹ $totalAmount",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold),
                                    )
                                  : Text(
                                      "₹ ${totalAmount + 40}",
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
                                "${widget.todaysOrder[0].paymentOption}",
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
                              Text(
                                "${widget.todaysOrder[0].center[0].centerName} , ${widget.todaysOrder[0].center[0].address} , ${widget.todaysOrder[0].center[0].pincode}",
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
                              totalAmount > 240
                                  ? Text(
                                      "₹ $totalAmount",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold),
                                    )
                                  : Text(
                                      "₹ ${totalAmount + 40}",
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
