import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shellcode2/add_Product.dart';
import 'package:shellcode2/paymentOption.dart';

import 'colors.dart';

class UpdateOrder extends StatefulWidget {
  UpdateOrder({Key key}) : super(key: key);

  @override
  _UpdateOrderState createState() => _UpdateOrderState();
}

class _UpdateOrderState extends State<UpdateOrder> {
  double totalAmount = 0.0;
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
            Expanded(child: Container()),
            Padding(
              padding: EdgeInsets.only(bottom: 5.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.purple[500]),
                padding: EdgeInsets.all(10.0),
                width: MediaQuery.of(context).size.width,
                child: Expanded(
                    child: Text(
                  "Total amount : ₹ $totalAmount",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                )),
              ),
            ),
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
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => PaymentOption(
                        //             totalAmount: totalAmount,
                        //             couponId: couponId,
                        //             couponCode: couponCode,
                        //             couponValue: couponValue,
                        //             deliveryCharges: deliveryCharges,
                        //             productOrderId: productOrderId,
                        //             couponApplied: couponApplied)));
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
                                builder: (context) => AddProduct()));
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
}
