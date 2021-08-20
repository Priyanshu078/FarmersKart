import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class OrderSummary extends StatefulWidget {
  OrderSummary({Key key}) : super(key: key);

  @override
  _OrderSummaryState createState() => _OrderSummaryState();
}

class _OrderSummaryState extends State<OrderSummary> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Summary"),
        centerTitle: true,
      ),
      body: Center(
        child: Text("Order"),
      ),
    );
  }
}
