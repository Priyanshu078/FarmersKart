import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shellcode2/Provider/data.dart';
import 'package:shellcode2/apiData/Constants.dart';
import 'package:shellcode2/apiData/creditedWalletAmount.dart';
import 'package:shellcode2/apiData/walletHistory.dart';
import 'package:shellcode2/colors.dart';
import 'package:http/http.dart' as http;

class Wallet extends StatefulWidget {
  const Wallet({Key key}) : super(key: key);

  @override
  _WalletState createState() => _WalletState();
}

String selectedChoice = "";

class _WalletState extends State<Wallet> {
  String transactionId = "";
  Razorpay _razorpay;
  TextEditingController moneyController = new TextEditingController();
  @override
  void initState() {
    super.initState();
    _razorpay = new Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _paymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _paymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _paymentExternalWallet);
  }

  void _paymentSuccess(PaymentSuccessResponse response) {
    transactionId = response.paymentId;
    print(response.paymentId);
    print(response.orderId);
    showSnackBar("Success " + response.paymentId);
    refillUserWallet();
  }

  void _paymentError(PaymentFailureResponse response) {
    showSnackBar("Error " + response.message + response.code.toString());
  }

  void _paymentExternalWallet(ExternalWalletResponse response) {
    showSnackBar("External Wallet used " + response.walletName);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void initiateRazorpay() {
    Map<String, dynamic> options = {
      'key': 'rzp_test_UbDUVjXf0eL5Uf',
      'amount': int.parse(moneyController.text) * 100,
      'name': 'FarmersKart',
      'description': 'Shoping',
      'prefill': {
        'contact':
            '${Provider.of<APIData>(context, listen: false).user.mobile}',
        'email': '${Provider.of<APIData>(context, listen: false).user.email}'
      },
      'external': {
        'wallets': ['paytm']
      }
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
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
          'Wallet',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
      body: FutureBuilder(
          future: walletAmount(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 8 / 9,
                    padding: EdgeInsets.all(30.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Farmers Kart Wallet',
                                  style: TextStyle(
                                      color: Colors.purple,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.8),
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      ' ₹ ',
                                      style: TextStyle(
                                          color: Colors.deepPurple,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 0.8),
                                    ),
                                    Text(
                                      snapshot.data.toString(),
                                      style: TextStyle(
                                          color: Colors.deepPurple,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 0.8),
                                    )
                                  ],
                                )
                              ],
                            ),
                            CircleAvatar(
                              maxRadius: 30,
                              backgroundColor: Colors.orange.withOpacity(0.5),
                              child: Icon(
                                Icons.account_balance_wallet_outlined,
                                color: Colors.white,
                                size: 35,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      ' ₹ ',
                                      style: TextStyle(
                                          color: Colors.deepPurple,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 0.8),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 2,
                                    child: TextField(
                                      controller: moneyController,
                                      cursorColor: Colors.purple[600],
                                      decoration: InputDecoration(
                                          hintText: "Amount (₹)"),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Flexible(
                              child: GestureDetector(
                                onTap: () {
                                  initiateRazorpay();
                                },
                                child: Container(
                                  height: 50,
                                  width: 150,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      color: Colors.purple[700]),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'ADD MONEY',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Divider(
                          color: Colors.black,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(3.0),
                              child: ChoiceChip(
                                label: Text('   Debit Amount   '),
                                labelStyle: TextStyle(
                                    color: Colors.white, fontSize: 12.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                backgroundColor: Colors.yellow[800],
                                selectedColor:
                                    Colors.deepOrangeAccent.withOpacity(0.9),
                                selected: selectedChoice == 'Debit Amount',
                                onSelected: (selected) {
                                  setState(() {
                                    selectedChoice = 'Debit Amount';
                                  });
                                },
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(3.0),
                              child: ChoiceChip(
                                label: Text('   Credit Amount   '),
                                labelStyle: TextStyle(
                                    color: Colors.white, fontSize: 12.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                backgroundColor: Colors.yellow[800],
                                selectedColor:
                                    Colors.deepOrangeAccent.withOpacity(0.9),
                                selected: selectedChoice == 'Credit Amount',
                                onSelected: (selected) {
                                  setState(() {
                                    selectedChoice = 'Credit Amount';
                                  });
                                },
                              ),
                            )
                          ],
                        ),
                        selectedChoice == 'Credit Amount'
                            ? Expanded(
                                child: FutureBuilder(
                                    future: creditedWalletAmount(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        if (snapshot.hasData) {
                                          return ListView.separated(
                                              separatorBuilder:
                                                  (context, index) {
                                                return Divider(
                                                  height: 15,
                                                  color: Colors.black,
                                                );
                                              },
                                              itemCount: snapshot.data.length,
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding: EdgeInsets.all(10),
                                                  child: Container(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Column(
                                                          children: [
                                                            Text(
                                                                '${snapshot.data[index].date.split(" ")[0]}',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .black)),
                                                            Text(
                                                                "${snapshot.data[index].modeOfPayment}"),
                                                            Text(
                                                                "${snapshot.data[index].date.split(" ")[1]}"),
                                                          ],
                                                        ),
                                                        Column(
                                                          children: [
                                                            Text(
                                                              '+ ${snapshot.data[index].amount}',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .green),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              });
                                        } else if (snapshot.hasError) {
                                          print(snapshot.error);
                                        } else {
                                          return Container();
                                        }
                                      }
                                      return Container();
                                    }))
                            : Expanded(
                                child: FutureBuilder(
                                    future: getWalletHistory(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        if (snapshot.hasData) {
                                          return ListView.separated(
                                              separatorBuilder:
                                                  (context, index) {
                                                return Divider(
                                                  height: 15,
                                                  color: Colors.black,
                                                );
                                              },
                                              itemCount: snapshot.data.length,
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding: EdgeInsets.all(10),
                                                  child: Container(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 8.0,
                                                                      bottom:
                                                                          8.0),
                                                              child: Text(
                                                                  '${snapshot.data[index].orderID}',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          15,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                          .black)),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 8.0,
                                                                      bottom:
                                                                          8.0),
                                                              child: Text(
                                                                  "${snapshot.data[index].date.split(" ")[0]}"),
                                                            ),
                                                          ],
                                                        ),
                                                        Column(
                                                          children: [
                                                            Text(
                                                              '- ${snapshot.data[index].amount}',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .red),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              });
                                        } else if (snapshot.hasError) {
                                          print(snapshot.error);
                                        } else {
                                          return Container();
                                        }
                                      }
                                      return Container();
                                    })),
                      ],
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                print(snapshot.error);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }

  Future walletAmount() async {
    String userId = Provider.of<APIData>(context, listen: false).user.id;
    http.Response response;
    String url = "$header/app_api/getUserWallet.php?user_id=$userId";
    Uri uri = Uri.parse(url);
    response = await http.get(uri);
    var jsonData = jsonDecode(response.body);
    return jsonData["total"];
  }

  Future<List> creditedWalletAmount() async {
    String userId = Provider.of<APIData>(context, listen: false).user.id;
    http.Response response;
    String url = "$header/app_api/getCreditedWalletAmount.php?user_id=$userId";
    Uri uri = Uri.parse(url);
    response = await http.get(uri);
    var jsonData = jsonDecode(response.body);
    List credit = [];
    if (jsonData["code"] == "200") {
      for (var item in jsonData["credit"]) {
        CreditWalletAmount creditWalletAmount = new CreditWalletAmount(
            item["created_at"], item["mode_of_payment"], item["amount"]);
        credit.add(creditWalletAmount);
      }
    }
    return credit;
  }

  Future<List> getWalletHistory() async {
    String userId = Provider.of<APIData>(context, listen: false).user.id;
    http.Response response;
    String url = "$header/app_api/getWalletHistory.php?user_id=$userId";
    Uri uri = Uri.parse(url);
    response = await http.get(uri);
    var jsonData = jsonDecode(response.body);
    List debit = [];
    if (jsonData["code"] == "200") {
      for (var item in jsonData["order"]) {
        WalletHistory walletHistory = new WalletHistory(
            item["order_id"], item["created_date"], item["used_wallet_amount"]);
        debit.add(walletHistory);
      }
    }
    return debit;
  }

  void refillUserWallet() async {
    String userId = Provider.of<APIData>(context, listen: false).user.id;
    String paymentMode = "upi";
    http.Response response;
    String url =
        "$header/app_api/refillUserWallet.php?user_id=$userId&amount=${moneyController.text}&txn_id=$transactionId&mode_of_payment=$paymentMode";
    Uri uri = Uri.parse(url);
    response = await http.get(uri);
    var jsonData = jsonDecode(response.body);
    if (jsonData["code"] == "200") {
      showSnackBar("Amount Added to the wallet");
    }
  }

  void showSnackBar(String content) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(content)));
  }
}
