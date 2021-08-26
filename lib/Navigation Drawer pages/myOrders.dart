import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shellcode2/Bottom%20bar%20pages/categories.dart';
import 'package:shellcode2/Bottom%20bar%20pages/wishlist.dart';
import 'package:shellcode2/More%20pages/OrderSummary.dart';
import 'package:shellcode2/More%20pages/complaints.dart';
import 'package:shellcode2/More%20pages/feedback.dart';
import 'package:shellcode2/More%20pages/invoice.dart';
import 'package:shellcode2/More%20pages/trackOrder.dart';
import 'package:shellcode2/Provider/data.dart';
import 'package:shellcode2/apiData/Constants.dart';
import 'package:shellcode2/apiData/orders.dart';
import 'package:shellcode2/colors.dart';
import 'package:shellcode2/home.dart';
import 'package:http/http.dart' as http;

class Orders extends StatefulWidget {
  @override
  _OrdersState createState() => _OrdersState();
}

int val = 0;
double totalAmount = 0;

class _OrdersState extends State<Orders> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Builder(builder: (BuildContext context) {
        final TabController _tabController = DefaultTabController.of(context);
        _tabController.addListener(() {
          if (!_tabController.indexIsChanging) {
            setState(() {
              val = _tabController.index;
            });
          }
        });
        return Scaffold(
          backgroundColor: bgcolor,
          appBar: AppBar(
            centerTitle: true,
            titleSpacing: 0.0,
            elevation: 0,
            //brightness: Brightness.light,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient:
                      LinearGradient(colors: [left, middle, Colors.purple])),
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios, size: 20, color: yellow),
            ),
            title: Text(
              'My Orders',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
          body: DefaultTabController(
            length: 1,
            child: Column(
              children: <Widget>[
                Container(
                  height: 60,
                  constraints: BoxConstraints(maxHeight: 150.0),
                  child: Material(
                    color: bgcolor,
                    child: TabBar(
                      controller: _tabController,
                      indicatorColor: yellow,
                      unselectedLabelColor: Colors.black,
                      tabs: [
                        Tab(
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                                color: val == 0
                                    ? yellow.withOpacity(0.7)
                                    : yellow.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Total Order',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300),
                                )),
                          ),
                        ),
                        Tab(
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                                color: val == 1
                                    ? yellow.withOpacity(0.7)
                                    : yellow.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Today's Order",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300),
                                )),
                          ),
                        ),
                        Tab(
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                                color: val == 2
                                    ? yellow.withOpacity(0.7)
                                    : yellow.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Cancel Order',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      val == 0
                          ? FutureBuilder(
                              future: getTotalOrders(context),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  if (snapshot.hasData) {
                                    return ListView.builder(
                                        itemCount: snapshot.data.length,
                                        itemBuilder: (context, int index) {
                                          totalAmount = 0;
                                          for (int i = 0;
                                              i < snapshot.data[index].length;
                                              i++) {
                                            totalAmount += double.parse(snapshot
                                                .data[index][i].totalAmount);
                                          }
                                          return InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          OrderSummary.allOrders(
                                                              allOrders:
                                                                  snapshot.data[
                                                                      index],
                                                              index: 0)));
                                            },
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              elevation: 10,
                                              child: Container(
                                                  padding: EdgeInsets.all(25.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Align(
                                                        alignment:
                                                            Alignment.topRight,
                                                        child: Container(
                                                          height: 25,
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border(
                                                              top: BorderSide(
                                                                  width: 1.0,
                                                                  color: Colors
                                                                      .greenAccent),
                                                              left: BorderSide(
                                                                  width: 1.0,
                                                                  color: Colors
                                                                      .greenAccent),
                                                              right: BorderSide(
                                                                  width: 1.0,
                                                                  color: Colors
                                                                      .greenAccent),
                                                              bottom: BorderSide(
                                                                  width: 1.0,
                                                                  color: Colors
                                                                      .greenAccent),
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5.0),
                                                          ),
                                                          child: InkWell(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30),
                                                            onTap: () {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          Invoice(
                                                                            data:
                                                                                snapshot.data[index],
                                                                            totalAmount:
                                                                                totalAmount,
                                                                          )));
                                                            },
                                                            child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        5.0),
                                                                child: Text(
                                                                  'Generate Invoice',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          10,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                      color: Colors
                                                                          .greenAccent),
                                                                )),
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        'Order Number: ${snapshot.data[index][0].orderId}',
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      totalAmount > 240
                                                          ? Text(
                                                              'Total Amount: ₹$totalAmount',
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  color: Colors
                                                                      .black),
                                                            )
                                                          : Text(
                                                              'Total Amount: ₹${totalAmount + 40}',
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        '${snapshot.data[index][0].orderStatus} ${snapshot.data[index][0].deliveryDate}',
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color: Colors.grey),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          Align(
                                                            alignment: Alignment
                                                                .topRight,
                                                            child: Container(
                                                              height: 25,
                                                              width: 150,
                                                              decoration:
                                                                  BoxDecoration(
                                                                border: Border(
                                                                  top: BorderSide(
                                                                      width:
                                                                          1.0,
                                                                      color: Colors
                                                                          .orange),
                                                                  left: BorderSide(
                                                                      width:
                                                                          1.0,
                                                                      color: Colors
                                                                          .orange),
                                                                  right: BorderSide(
                                                                      width:
                                                                          1.0,
                                                                      color: Colors
                                                                          .orange),
                                                                  bottom: BorderSide(
                                                                      width:
                                                                          1.0,
                                                                      color: Colors
                                                                          .orange),
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5.0),
                                                              ),
                                                              child: InkWell(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            30),
                                                                onTap: () {
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              Complaints()));
                                                                },
                                                                child: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(
                                                                      'Complaints',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              10,
                                                                          fontWeight: FontWeight
                                                                              .normal,
                                                                          color:
                                                                              Colors.black),
                                                                    )),
                                                              ),
                                                            ),
                                                          ),
                                                          Align(
                                                            alignment: Alignment
                                                                .topRight,
                                                            child: Container(
                                                              height: 25,
                                                              width: 150,
                                                              decoration:
                                                                  BoxDecoration(
                                                                border: Border(
                                                                  top: BorderSide(
                                                                      width:
                                                                          1.0,
                                                                      color: Colors
                                                                          .greenAccent),
                                                                  left: BorderSide(
                                                                      width:
                                                                          1.0,
                                                                      color: Colors
                                                                          .greenAccent),
                                                                  right: BorderSide(
                                                                      width:
                                                                          1.0,
                                                                      color: Colors
                                                                          .greenAccent),
                                                                  bottom: BorderSide(
                                                                      width:
                                                                          1.0,
                                                                      color: Colors
                                                                          .greenAccent),
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5.0),
                                                              ),
                                                              child: InkWell(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            30),
                                                                onTap: () {
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              FeedBack()));
                                                                },
                                                                child: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(
                                                                      'Feedback',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              10,
                                                                          fontWeight: FontWeight
                                                                              .normal,
                                                                          color:
                                                                              Colors.black),
                                                                    )),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          Align(
                                                            alignment: Alignment
                                                                .topRight,
                                                            child: Container(
                                                              height: 25,
                                                              width: 150,
                                                              decoration:
                                                                  BoxDecoration(
                                                                border: Border(
                                                                  top: BorderSide(
                                                                      width:
                                                                          2.0,
                                                                      color: Colors
                                                                          .blue),
                                                                  left: BorderSide(
                                                                      width:
                                                                          2.0,
                                                                      color: Colors
                                                                          .blue),
                                                                  right: BorderSide(
                                                                      width:
                                                                          2.0,
                                                                      color: Colors
                                                                          .blue),
                                                                  bottom: BorderSide(
                                                                      width:
                                                                          2.0,
                                                                      color: Colors
                                                                          .blue),
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5.0),
                                                              ),
                                                              child: InkWell(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            30),
                                                                onTap: () {
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              TrackOrder()));
                                                                },
                                                                child: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(
                                                                      'Track Order',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              10,
                                                                          fontWeight: FontWeight
                                                                              .normal,
                                                                          color:
                                                                              Colors.black),
                                                                    )),
                                                              ),
                                                            ),
                                                          ),
                                                          Align(
                                                            alignment: Alignment
                                                                .topRight,
                                                            child: Container(
                                                              height: 25,
                                                              width: 150,
                                                              decoration:
                                                                  BoxDecoration(
                                                                border: Border(
                                                                  top: BorderSide(
                                                                      width:
                                                                          2.0,
                                                                      color: Colors
                                                                          .red),
                                                                  left: BorderSide(
                                                                      width:
                                                                          2.0,
                                                                      color: Colors
                                                                          .red),
                                                                  right: BorderSide(
                                                                      width:
                                                                          2.0,
                                                                      color: Colors
                                                                          .red),
                                                                  bottom: BorderSide(
                                                                      width:
                                                                          2.0,
                                                                      color: Colors
                                                                          .red),
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5.0),
                                                              ),
                                                              child: InkWell(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            30),
                                                                onTap: () {},
                                                                child: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(
                                                                      'Cancel Order',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              10,
                                                                          fontWeight: FontWeight
                                                                              .normal,
                                                                          color:
                                                                              Colors.orangeAccent),
                                                                    )),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  )),
                                            ),
                                          );
                                        });
                                  } else if (snapshot.hasError) {
                                    print(snapshot.error);
                                  } else {
                                    return Container();
                                  }
                                }
                                return Center(
                                    child: CircularProgressIndicator());
                              })
                          : val == 1
                              ? FutureBuilder(
                                  future: getTodaysOrders(context),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      if (snapshot.hasData) {
                                        return ListView.builder(
                                            itemBuilder: (context, int index) {
                                          totalAmount = 0;
                                          for (int i = 0;
                                              i < snapshot.data[index].length;
                                              i++) {
                                            totalAmount += double.parse(snapshot
                                                .data[index][i].totalAmount);
                                          }
                                          return InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          OrderSummary.todaysOrder(
                                                              todaysOrder:
                                                                  snapshot.data[
                                                                      index],
                                                              index: 1)));
                                            },
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              elevation: 10,
                                              child: Container(
                                                  padding: EdgeInsets.all(30.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Align(
                                                        alignment:
                                                            Alignment.topRight,
                                                        child: Container(
                                                          height: 25,
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border(
                                                              top: BorderSide(
                                                                  width: 1.0,
                                                                  color: Colors
                                                                      .black),
                                                              left: BorderSide(
                                                                  width: 1.0,
                                                                  color: Colors
                                                                      .black),
                                                              right: BorderSide(
                                                                  width: 1.0,
                                                                  color: Colors
                                                                      .black),
                                                              bottom: BorderSide(
                                                                  width: 1.0,
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5.0),
                                                          ),
                                                          child: InkWell(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30),
                                                            onTap: () {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          Invoice(
                                                                            data:
                                                                                snapshot.data[index],
                                                                            totalAmount:
                                                                                totalAmount,
                                                                          )));
                                                            },
                                                            child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        5.0),
                                                                child: Text(
                                                                  'Generate Invoice',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          10,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                      color: Colors
                                                                          .blueGrey),
                                                                )),
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        'Order Number: ${snapshot.data[index][0].orderId}',
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      totalAmount > 240
                                                          ? Text(
                                                              'Total Amount: ₹$totalAmount',
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  color: Colors
                                                                      .black),
                                                            )
                                                          : Text(
                                                              'Total Amount: ₹${totalAmount + 40}',
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        '${snapshot.data[index][0].orderStatus} ${snapshot.data[index][0].deliveryDate}',
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color: Colors.grey),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          Align(
                                                            alignment: Alignment
                                                                .topRight,
                                                            child: Container(
                                                              height: 25,
                                                              width: 150,
                                                              decoration:
                                                                  BoxDecoration(
                                                                border: Border(
                                                                  top: BorderSide(
                                                                      width:
                                                                          1.0,
                                                                      color: Colors
                                                                          .yellow),
                                                                  left: BorderSide(
                                                                      width:
                                                                          1.0,
                                                                      color: Colors
                                                                          .yellow),
                                                                  right: BorderSide(
                                                                      width:
                                                                          1.0,
                                                                      color: Colors
                                                                          .yellow),
                                                                  bottom: BorderSide(
                                                                      width:
                                                                          1.0,
                                                                      color: Colors
                                                                          .yellow),
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5.0),
                                                              ),
                                                              child: InkWell(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            30),
                                                                onTap: () {
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              Complaints()));
                                                                },
                                                                child: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(
                                                                      'Complaints',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              10,
                                                                          fontWeight: FontWeight
                                                                              .normal,
                                                                          color:
                                                                              Colors.black),
                                                                    )),
                                                              ),
                                                            ),
                                                          ),
                                                          Align(
                                                            alignment: Alignment
                                                                .topRight,
                                                            child: Container(
                                                              height: 25,
                                                              width: 150,
                                                              decoration:
                                                                  BoxDecoration(
                                                                border: Border(
                                                                  top: BorderSide(
                                                                      width:
                                                                          1.0,
                                                                      color: Colors
                                                                          .black),
                                                                  left: BorderSide(
                                                                      width:
                                                                          1.0,
                                                                      color: Colors
                                                                          .black),
                                                                  right: BorderSide(
                                                                      width:
                                                                          1.0,
                                                                      color: Colors
                                                                          .black),
                                                                  bottom: BorderSide(
                                                                      width:
                                                                          1.0,
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5.0),
                                                              ),
                                                              child: InkWell(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            30),
                                                                onTap: () {
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              FeedBack()));
                                                                },
                                                                child: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(
                                                                      'Feedback',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              10,
                                                                          fontWeight: FontWeight
                                                                              .normal,
                                                                          color:
                                                                              Colors.white),
                                                                    )),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          Align(
                                                            alignment: Alignment
                                                                .topRight,
                                                            child: Container(
                                                              height: 25,
                                                              width: 150,
                                                              decoration:
                                                                  BoxDecoration(
                                                                border: Border(
                                                                  top: BorderSide(
                                                                      width:
                                                                          2.0,
                                                                      color: Colors
                                                                          .blue),
                                                                  left: BorderSide(
                                                                      width:
                                                                          2.0,
                                                                      color: Colors
                                                                          .blue),
                                                                  right: BorderSide(
                                                                      width:
                                                                          2.0,
                                                                      color: Colors
                                                                          .blue),
                                                                  bottom: BorderSide(
                                                                      width:
                                                                          2.0,
                                                                      color: Colors
                                                                          .blue),
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5.0),
                                                              ),
                                                              child: InkWell(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            30),
                                                                onTap: () {
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              TrackOrder()));
                                                                },
                                                                child: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(
                                                                      'Track Order',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              10,
                                                                          fontWeight: FontWeight
                                                                              .normal,
                                                                          color:
                                                                              Colors.white),
                                                                    )),
                                                              ),
                                                            ),
                                                          ),
                                                          Align(
                                                            alignment: Alignment
                                                                .topRight,
                                                            child: Container(
                                                              height: 25,
                                                              width: 150,
                                                              decoration:
                                                                  BoxDecoration(
                                                                border: Border(
                                                                  top: BorderSide(
                                                                      width:
                                                                          2.0,
                                                                      color: Colors
                                                                          .red),
                                                                  left: BorderSide(
                                                                      width:
                                                                          2.0,
                                                                      color: Colors
                                                                          .red),
                                                                  right: BorderSide(
                                                                      width:
                                                                          2.0,
                                                                      color: Colors
                                                                          .red),
                                                                  bottom: BorderSide(
                                                                      width:
                                                                          2.0,
                                                                      color: Colors
                                                                          .red),
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5.0),
                                                              ),
                                                              child: InkWell(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            30),
                                                                onTap: () {},
                                                                child: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(
                                                                      'Cancel Order',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              10,
                                                                          fontWeight: FontWeight
                                                                              .normal,
                                                                          color:
                                                                              Colors.red),
                                                                    )),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  )),
                                            ),
                                          );
                                        });
                                      } else if (snapshot.hasError) {
                                        print(snapshot.error);
                                      } else {
                                        return Container();
                                      }
                                    }
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  })
                              : FutureBuilder(
                                  future: getCancelOrders(context),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      if (snapshot.hasData) {
                                        return ListView.builder(
                                          itemCount: snapshot.data.length,
                                          itemBuilder: (context, int index) {
                                            totalAmount = 0;
                                            for (int i = 0;
                                                i < snapshot.data[index].length;
                                                i++) {
                                              totalAmount += double.parse(
                                                  snapshot.data[index][i]
                                                      .totalAmount);
                                            }
                                            return InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            OrderSummary.cancelledOrders(
                                                                cancelledOrders:
                                                                    snapshot.data[
                                                                        index],
                                                                index: 2)));
                                              },
                                              child: Card(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                elevation: 10,
                                                child: Container(
                                                    padding:
                                                        EdgeInsets.all(25.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Align(
                                                          alignment: Alignment
                                                              .topRight,
                                                          child: Container(
                                                            height: 25,
                                                            decoration:
                                                                BoxDecoration(
                                                              border: Border(
                                                                top: BorderSide(
                                                                    width: 1.0,
                                                                    color: Colors
                                                                        .greenAccent),
                                                                left: BorderSide(
                                                                    width: 1.0,
                                                                    color: Colors
                                                                        .greenAccent),
                                                                right: BorderSide(
                                                                    width: 1.0,
                                                                    color: Colors
                                                                        .greenAccent),
                                                                bottom: BorderSide(
                                                                    width: 1.0,
                                                                    color: Colors
                                                                        .greenAccent),
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5.0),
                                                            ),
                                                            child: InkWell(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30),
                                                              onTap: () {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            Invoice.cancelOrder(
                                                                              data: snapshot.data[index],
                                                                              totalAmount: totalAmount,
                                                                              cancel: 1,
                                                                            )));
                                                              },
                                                              child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          5.0),
                                                                  child: Text(
                                                                    'Generate Invoice',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            10,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .normal,
                                                                        color: Colors
                                                                            .greenAccent),
                                                                  )),
                                                            ),
                                                          ),
                                                        ),
                                                        Text(
                                                          'Order Number: ${snapshot.data[index][0].orderId}',
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        totalAmount > 240
                                                            ? Text(
                                                                'Total Amount: ₹$totalAmount',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    color: Colors
                                                                        .black),
                                                              )
                                                            : Text(
                                                                'Total Amount: ₹${totalAmount + 40}',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Text(
                                                          '${snapshot.data[index][0].orderStatus}',
                                                          style: TextStyle(
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            Align(
                                                              alignment:
                                                                  Alignment
                                                                      .topRight,
                                                              child: Container(
                                                                height: 25,
                                                                width: 150,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  border:
                                                                      Border(
                                                                    top: BorderSide(
                                                                        width:
                                                                            1.0,
                                                                        color: Colors
                                                                            .orange),
                                                                    left: BorderSide(
                                                                        width:
                                                                            1.0,
                                                                        color: Colors
                                                                            .orange),
                                                                    right: BorderSide(
                                                                        width:
                                                                            1.0,
                                                                        color: Colors
                                                                            .orange),
                                                                    bottom: BorderSide(
                                                                        width:
                                                                            1.0,
                                                                        color: Colors
                                                                            .orange),
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5.0),
                                                                ),
                                                                child: InkWell(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              30),
                                                                  onTap: () {
                                                                    Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                Complaints()));
                                                                  },
                                                                  child: Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      child:
                                                                          Text(
                                                                        'Complaints',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                10,
                                                                            fontWeight:
                                                                                FontWeight.normal,
                                                                            color: Colors.black),
                                                                      )),
                                                                ),
                                                              ),
                                                            ),
                                                            Align(
                                                              alignment:
                                                                  Alignment
                                                                      .topRight,
                                                              child: Container(
                                                                height: 25,
                                                                width: 150,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  border:
                                                                      Border(
                                                                    top: BorderSide(
                                                                        width:
                                                                            1.0,
                                                                        color: Colors
                                                                            .greenAccent),
                                                                    left: BorderSide(
                                                                        width:
                                                                            1.0,
                                                                        color: Colors
                                                                            .greenAccent),
                                                                    right: BorderSide(
                                                                        width:
                                                                            1.0,
                                                                        color: Colors
                                                                            .greenAccent),
                                                                    bottom: BorderSide(
                                                                        width:
                                                                            1.0,
                                                                        color: Colors
                                                                            .greenAccent),
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5.0),
                                                                ),
                                                                child: InkWell(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              30),
                                                                  onTap: () {
                                                                    Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                FeedBack()));
                                                                  },
                                                                  child: Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      child:
                                                                          Text(
                                                                        'Feedback',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                10,
                                                                            fontWeight:
                                                                                FontWeight.normal,
                                                                            color: Colors.black),
                                                                      )),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Container(
                                                            height: 25,
                                                            width: 150,
                                                            decoration:
                                                                BoxDecoration(
                                                              border: Border(
                                                                top: BorderSide(
                                                                    width: 2.0,
                                                                    color: Colors
                                                                        .blue),
                                                                left: BorderSide(
                                                                    width: 2.0,
                                                                    color: Colors
                                                                        .blue),
                                                                right: BorderSide(
                                                                    width: 2.0,
                                                                    color: Colors
                                                                        .blue),
                                                                bottom: BorderSide(
                                                                    width: 2.0,
                                                                    color: Colors
                                                                        .blue),
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5.0),
                                                            ),
                                                            child: InkWell(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30),
                                                              onTap: () {},
                                                              child: Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: Text(
                                                                    'Track Order',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            10,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .normal,
                                                                        color: Colors
                                                                            .black),
                                                                  )),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    )),
                                              ),
                                            );
                                          },
                                        );
                                      } else if (snapshot.hasError) {
                                        print(snapshot.error);
                                      } else {
                                        return Container();
                                      }
                                    }
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Navigate(),
        );
      }),
    );
  }

  Future<List> getTotalOrders(BuildContext context) async {
    String userId =
        Provider.of<UserAccountDetails>(context, listen: false).user.id;
    http.Response response;
    String url = "$header/app_api/get_all_user_orders.php?user_id=$userId";
    Uri uri = Uri.parse(url);
    response = await http.get(uri);
    List totalOrders = [];
    var jsonData = jsonDecode(response.body);
    if (jsonData["code"] == "200") {
      List orderIdList = [];
      for (var item in jsonData["order"]) {
        if (!orderIdList.contains(item["order_id"])) {
          orderIdList.add(item["order_id"]);
        }
      }
      print("orderIdList");
      print(orderIdList);
      for (int i = 0; i < orderIdList.length; i++) {
        List orders = [];
        String orderId = orderIdList[i];
        for (var item1 in jsonData["order"]) {
          List center = [];
          for (var item2 in item1["center"]) {
            CenterData centerData = new CenterData(
                item2["center_name"],
                item2["address"],
                item2["pincode"],
                item2["del_flag"],
                item2["delivery_days"],
                item2["delivery_time"],
                item2["id"]);
            center.add(centerData);
          }
          OrdersData ordersData = new OrdersData(
              item1["category_name"],
              item1["product_name"],
              item1["product_img"],
              item1["id"],
              item1["user_id"],
              item1["order_id"],
              item1["address_id"],
              item1["quantity"],
              item1["product_id"],
              item1["unit_price"],
              item1["order_status"],
              item1["admin_status"],
              item1["cart"],
              item1["created_date"],
              item1["total_amount"],
              item1["updated_date"],
              item1["cancelled_reason"],
              item1["wallet"],
              item1["weight"],
              item1["used_wallet_amount"],
              item1["coupon_value"],
              item1["unit_original_price"],
              item1["center_id"],
              item1["payment_option"],
              item1["delivery_day"],
              item1["delivery_time"],
              item1["coupon_code"],
              item1["coupon_id"],
              item1["delivery_chrges"],
              item1["delivery_date"],
              item1["specification"],
              center);
          if (orderId == item1["order_id"]) {
            orders.add(ordersData);
          }
        }
        totalOrders.add(orders);
      }
      return totalOrders;
    }
  }

  Future<List> getTodaysOrders(BuildContext context) async {
    String userId =
        Provider.of<UserAccountDetails>(context, listen: false).user.id;
    http.Response response;
    String url = "$header/app_api/get_user_today_order.php?user_id=$userId";
    Uri uri = Uri.parse(url);
    response = await http.get(uri);
    List orderIdList = [];
    List todaysOrder = [];
    var jsonData = jsonDecode(response.body);
    if (jsonData["code"] == "200") {
      List orderList = jsonData["order"];
      for (var item in jsonData["order"]) {
        if (!orderIdList.contains(item["order_id"])) {
          orderIdList.add(item["order_id"]);
        }
      }
      for (int i = 0; i < orderIdList.length; i++) {
        List orders = [];
        String orderId = orderIdList[i];
        for (var item1 in orderList) {
          List centerList = [];
          for (var item2 in item1["center"]) {
            CenterData centerData = new CenterData(
                item2["center_name"],
                item2["address"],
                item2["pincode"],
                item2["del_flag"],
                item2["delivery_days"],
                item2["delivery_time"],
                item2["id"]);
            centerList.add(centerData);
          }
          OrdersData ordersData = new OrdersData(
              item1["category_name"],
              item1["product_name"],
              item1["product_img"],
              item1["id"],
              item1["user_id"],
              item1["order_id"],
              item1["address_id"],
              item1["quantity"],
              item1["product_id"],
              item1["unit_price"],
              item1["order_status"],
              item1["admin_status"],
              item1["cart"],
              item1["created_date"],
              item1["total_amount"],
              item1["updated_date"],
              item1["cancelled_reason"],
              item1["wallet"],
              item1["weight"],
              item1["used_wallet_amount"],
              item1["coupon_value"],
              item1["unit_original_price"],
              item1["center_id"],
              item1["payment_option"],
              item1["delivery_day"],
              item1["delivery_time"],
              item1["coupon_code"],
              item1["coupon_id"],
              item1["delivery_chrges"],
              item1["delivery_date"],
              item1["specification"],
              centerList);
          if (orderId == item1["order_id"]) {
            orders.add(ordersData);
          }
        }
        print(orders);
        todaysOrder.add(orders);
      }
      print(todaysOrder);
      return todaysOrder;
    }
  }

  Future<List> getCancelOrders(BuildContext context) async {
    String userId =
        Provider.of<UserAccountDetails>(context, listen: false).user.id;
    http.Response response;
    String url = "$header/app_api/get_user_cancelled_order.php?user_id=$userId";
    Uri uri = Uri.parse(url);
    response = await http.get(uri);
    List ordersIdList = [];
    List cancelledOrders = [];
    var jsonData = jsonDecode(response.body);
    if (jsonData["code"] == "200") {
      List orderList = jsonData["order"];
      for (var item in orderList) {
        if (!ordersIdList.contains(item["order_id"])) {
          ordersIdList.add(item["order_id"]);
        }
      }
      for (int i = 0; i < ordersIdList.length; i++) {
        List orders = [];
        String orderId = ordersIdList[i];
        for (var item1 in orderList) {
          List centerList = [];
          // for (var item2 in item1["center"]) {
          //   CenterData centerData = new CenterData(
          //       item2["center_name"],
          //       item2["address"],
          //       item2["pincode"],
          //       item2["del_flag"],
          //       item2["delivery_days"],
          //       item2["delivery_time"],
          //       item2["id"]);
          //   centerList.add(centerData);
          // }
          OrdersData ordersData = new OrdersData(
              item1["category_name"],
              item1["product_name"],
              item1["product_img"],
              item1["id"],
              item1["user_id"],
              item1["order_id"],
              item1["address_id"],
              item1["quantity"],
              item1["product_id"],
              item1["unit_price"],
              item1["order_status"],
              item1["admin_status"],
              item1["cart"],
              item1["created_date"],
              item1["total_amount"],
              item1["updated_date"],
              item1["cancelled_reason"],
              item1["wallet"],
              item1["weight"],
              item1["used_wallet_amount"],
              item1["coupon_value"],
              item1["unit_original_price"],
              item1["center_id"],
              item1["payment_option"],
              item1["delivery_day"],
              item1["delivery_time"],
              item1["coupon_code"],
              item1["coupon_id"],
              item1["delivery_chrges"],
              item1["delivery_date"],
              item1["specification"],
              centerList);
          if (orderId == item1["order_id"]) {
            orders.add(ordersData);
          }
        }
        cancelledOrders.add(orders);
      }
    }
    return cancelledOrders;
  }
}

class Navigate extends StatefulWidget {
  const Navigate({Key key}) : super(key: key);

  @override
  _NavigateState createState() => _NavigateState();
}

class _NavigateState extends State<Navigate> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: bgcolor,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: BottomNavigationBar(
            backgroundColor: lightbg,
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
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Home()));
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Wishlist()));
                      },
                      child: Icon(CupertinoIcons.heart)),
                  title: Text('Wishlist')),
            ],
          ),
        ));
  }
}

// class Categories {
//   String orderNo;
//   double amount;
//   String status;
//   //String classTitle;
//   Categories({
//     @required this.orderNo,
//     @required this.amount,
//     @required this.status,
//   });
// }

// List<Categories> category1 = [
//   Categories(orderNo: 'nlML00', amount: 198.00, status: 'Replacement Today'),
//   Categories(orderNo: 'nlML00', amount: 198.00, status: 'Replacement Today'),
//   Categories(orderNo: 'nlML00', amount: 198.00, status: 'Replacement Today'),
//   Categories(orderNo: 'nlML00', amount: 198.00, status: 'Replacement Today'),
// ];
