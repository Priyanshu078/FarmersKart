import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shellcode2/Provider/data.dart';
import 'package:shellcode2/apiData/Constants.dart';
import '../colors.dart';
import 'package:http/http.dart' as http;

class Invoice extends StatefulWidget {
  final List data;
  final double totalAmount;
  int cancel;
  Invoice({Key key, @required this.data, @required this.totalAmount})
      : super(key: key);
  Invoice.cancelOrder(
      {Key key,
      @required this.data,
      @required this.totalAmount,
      @required this.cancel})
      : super(key: key);

  @override
  _InvoiceState createState() => _InvoiceState();
}

class _InvoiceState extends State<Invoice> {
  // var paymentMode = "COD";
  // var address =
  //     "Pristine Prolife Phase-1, Shankar Kalate Nagar Wakad Pune, 411057";
  // var deliveryDate = "Jul 31,2021";
  // var couponAppliedAmount = "";
  double totalAmount = 0;
  // var deliveryCharges = "₹ 40.00";
  // var newTotalAmount = "";
  // var difference = "";

  @override
  Widget build(BuildContext context) {
    // totalAmount = 0;
    // for (int i = 0; i < widget.data.length; i++) {
    //   totalAmount += double.parse(widget.data[i].totalAmount);
    // }
    // totalAmount += double.parse(widget.data[0].deliveryCharges);
    return Scaffold(
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
          'Order Invoice',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 17,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: generateInvoice(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 15, 5, 5),
                        child: Row(
                          children: [
                            Text('Payment Mode :',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 17)),
                            Text(
                              widget.data[0].paymentOption,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 17),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 15, 5, 5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Center Address :',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 17)),
                            Flexible(
                                child: widget.cancel == 1
                                    ? Text("")
                                    : Text(
                                        "${widget.data[0].center[0].centerName}, ${widget.data[0].center[0].address}, ${widget.data[0].center[0].pincode}",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 17)))
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 15, 5, 5),
                        child: Row(
                          children: [
                            Text('Delivery Date :',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 17)),
                            Text("${widget.data[0].deliveryDate}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 17))
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 10, 5, 5),
                        child: Row(
                          children: [
                            Text('Coupon Applied Amount:',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 17)),
                            Text("${widget.data[0].couponValue}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 17))
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 20, 5, 10),
                        child: Text('Order product list:',
                            style: TextStyle(
                                color: Color(0XFFFFA726),
                                fontWeight: FontWeight.w500,
                                fontSize: 18)),
                      ),
                      Container(
                        color: left,
                        padding: EdgeInsets.all(13),
                        margin: EdgeInsets.all(5),
                        child: Row(
                          children: [
                            Text(
                              'Item',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                            Spacer(),
                            Text('Qty',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold)),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(60, 0, 1, 0),
                              child: Text('Price',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold)),
                            )
                          ],
                        ),
                      ),
                      ListView.builder(
                        itemCount: widget.data.length,
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Divider(
                                color: Colors.purple,
                                thickness: 2.50,
                                height: 5,
                              ),
                              Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(12),
                                    margin: EdgeInsets.all(5),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                  "${widget.data[index].productName} ${widget.data[index].weight}",
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w400)),
                                              Spacer(),
                                              Text(
                                                  "${widget.data[index].quantity}",
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w400)),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        45, 0, 1, 0),
                                                child: Text(
                                                    "₹ ${widget.data[index].totalAmount}",
                                                    style: TextStyle(
                                                        color: Colors
                                                            .green.shade800,
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.w400)),
                                              )
                                            ],
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  10, 12, 1, 5),
                                              child: Row(
                                                children: [
                                                  Text('Status:',
                                                      style: TextStyle(
                                                          color:
                                                              Color(0XFFFFA726),
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 16,
                                                          fontStyle: FontStyle
                                                              .italic)),
                                                  Text(
                                                      "${widget.data[index].orderStatus}",
                                                      style: TextStyle(
                                                          color: Colors.purple,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 17)),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ]),
                                  ),
                                ],
                              ),
                              Divider(
                                color: Colors.purple,
                                thickness: 2.50,
                                height: 5,
                              ),
                              SizedBox(height: 2)
                            ],
                          );
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(1, 15, 10, 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text('Total Amount :',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 17)),
                            SizedBox(width: 30),
                            Text("₹ ${snapshot.data["actual_total_amount"]}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 17))
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(1, 8, 10, 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text('Delivery Charges :',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 17)),
                            SizedBox(width: 30),
                            Text("₹ ${widget.data[0].deliveryCharges}",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(1, 8, 10, 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text('New Total Amount :',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 17)),
                            SizedBox(width: 30),
                            Text("",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 17))
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(1, 8, 10, 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text('Difference :',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 17)),
                            SizedBox(width: 30),
                            Text("",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 17))
                          ],
                        ),
                      ),
                    ],
                  );
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
      ),
    );
  }

  Future generateInvoice() async {
    String userId = Provider.of<UserAccountDetails>(context).user.id;
    http.Response response;
    String url =
        "$header/app_api/generateInvoice.php?user_id=u$userId&user_type=Society&order_id=${widget.data[0].orderId}";
    Uri uri = Uri.parse(url);
    response = await http.get(uri);
    var jsonData = jsonDecode(response.body);
    return jsonData;
  }
}

// class Items {
//   final String itemName, itemQty, itemPrice, itemStatus;

//   Items({this.itemName, this.itemQty, this.itemPrice, this.itemStatus});
// }

// List<Items> dummyItem = [
//   Items(
//       itemName: 'Elachi Banana 250 GM',
//       itemPrice: '₹ 35.00',
//       itemQty: '2',
//       itemStatus: 'Delivered'),
//   Items(
//       itemName: 'Tomato 250 GM',
//       itemPrice: '₹ 10.00',
//       itemQty: '2',
//       itemStatus: 'Delivered'),
// ];
