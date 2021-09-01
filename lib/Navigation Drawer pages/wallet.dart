import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shellcode2/Provider/data.dart';
import 'package:shellcode2/apiData/Constants.dart';
import 'package:shellcode2/apiData/creditedWalletAmount.dart';
import 'package:shellcode2/colors.dart';
import 'package:http/http.dart' as http;

class Wallet extends StatefulWidget {
  const Wallet({Key key}) : super(key: key);

  @override
  _WalletState createState() => _WalletState();
}

String selectedChoice = "";

class _WalletState extends State<Wallet> {
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
                return Container(
                  padding: EdgeInsets.all(30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
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
                                    snapshot.data,
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
                                '0',
                                style: TextStyle(
                                    color: Colors.deepPurple,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.8),
                              )
                            ],
                          ),
                          GestureDetector(
                            onTap: () {},
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
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Divider(
                        color: Colors.greenAccent,
                      ),
                      SizedBox(
                        height: 20,
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
                                            separatorBuilder: (context, index) {
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
                                                                  fontSize: 15,
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
                          : Container(),
                    ],
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

  Future<String> walletAmount() async {
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
}
