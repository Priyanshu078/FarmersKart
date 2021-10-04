import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shellcode2/Navigation%20Drawer%20pages/handyOrder.dart';
import 'package:shellcode2/Provider/data.dart';
import 'package:shellcode2/apiData/Constants.dart';
import 'package:shellcode2/home.dart';
import 'colors.dart';
import 'package:http/http.dart' as http;

enum Payment { online, cod }

class PaymentOption extends StatefulWidget {
  List productOrderId;
  double totalAmount;
  String couponId;
  String couponCode;
  String couponValue;
  double deliveryCharges;
  bool couponApplied;
  bool paynow = false;
  String orderNumber;
  bool updateOrder;
  PaymentOption(
      {Key key,
      @required this.totalAmount,
      @required this.couponId,
      @required this.couponCode,
      @required this.couponValue,
      @required this.deliveryCharges,
      @required this.productOrderId,
      @required this.couponApplied})
      : super(key: key);

  PaymentOption.updateOrder(
      {Key key,
      @required this.updateOrder,
      @required this.orderNumber,
      @required this.totalAmount,
      @required this.couponId,
      @required this.couponCode,
      @required this.couponValue,
      @required this.deliveryCharges,
      @required this.productOrderId,
      @required this.couponApplied})
      : super(key: key);

  PaymentOption.paynow(
      {Key key,
      @required this.paynow,
      @required this.orderNumber,
      @required this.totalAmount,
      @required this.couponId,
      @required this.couponCode,
      @required this.couponValue,
      @required this.deliveryCharges,
      @required this.productOrderId,
      @required this.couponApplied})
      : super(key: key);

  @override
  _PaymentOptionState createState() => _PaymentOptionState();
}

class _PaymentOptionState extends State<PaymentOption> {
  Razorpay _razorpay;
  // bool checkbox = false;
  Payment option;
  double totalAmount = 0.0;
  double walletamount = 0;
  // var amount = '70.0';
  bool onlinePayment = false;
  bool cashOnDelivery = false;
  bool paymentSuccesfull = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _razorpay = new Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, paymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, paymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, externalWalletPayment);
  }

  void paymentSuccess(PaymentSuccessResponse response) {
    paymentSuccesfull = true;
    showSnackBar("Success " + response.paymentId);
    String orderIds = getOrderIds();
    placeOrder(orderIds);
    if (Provider.of<APIData>(context, listen: false).walletUsed) {
      updateUserWallet();
    }
  }

  void paymentError(PaymentFailureResponse response) {
    showSnackBar("Error " + response.message + response.code.toString());
  }

  void externalWalletPayment(ExternalWalletResponse response) {
    showSnackBar("External wallet used " + response.walletName);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // Provider.of<APIData>(context, listen: false).useWallet();
    // print(Provider.of<APIData>(context, listen: false).walletUsed);
    super.dispose();
    _razorpay.clear();
  }

  void initiateRazorpay() {
    Map<String, dynamic> options = {
      'key': 'rzp_test_UbDUVjXf0eL5Uf',
      'amount': Provider.of<APIData>(context, listen: false).totalAmount * 100,
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
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (Provider.of<APIData>(context, listen: false).choice != null) {
      Provider.of<APIData>(context, listen: false)
          .initializepaymentChoice(null);
    }
    if (Provider.of<APIData>(context, listen: false).walletUsed) {
      Provider.of<APIData>(context, listen: false).useWallet();
    }
    if (widget.paynow) {
      Provider.of<APIData>(context, listen: false)
          .initializeTotalAmount(widget.totalAmount);
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        titleSpacing: 0.0,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [left, middle, Colors.purple])),
        ),
        title: Text(
          'Payment Option',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 17,
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
                    padding: EdgeInsets.fromLTRB(2, 15, 2, 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Wallet Amount:',
                              style: TextStyle(
                                  color: Colors.purple,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20),
                            ),
                            Consumer<APIData>(builder: (context, data, child) {
                              return Text(
                                '₹ ${data.walletAmount}',
                                style: TextStyle(
                                    color: Colors.orange,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20),
                              );
                            }),
                          ],
                        ),
                        SizedBox(height: 15),
                        int.parse(snapshot.data) > 0
                            ? Consumer<APIData>(
                                builder: (context, wallet, child) {
                                return CheckboxListTile(
                                    value: wallet.walletUsed,
                                    onChanged: (_) {
                                      setState(() {
                                        Provider.of<APIData>(context,
                                                listen: false)
                                            .useWallet();
                                      });
                                    },
                                    title: Text(
                                      'check this to use wallet amount',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18),
                                    ),
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    activeColor: Colors.purple);
                              })
                            : Container(),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Amount to be paid:',
                              style: TextStyle(
                                  color: Colors.purple,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20),
                            ),
                            widget.updateOrder
                                ? Consumer<APIData>(
                                    builder: (context, amount, child) {
                                    return Text(
                                      '₹ ${amount.totalAddedProductAmount}',
                                      style: TextStyle(
                                          color: Colors.orange,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20),
                                    );
                                  })
                                : Consumer<APIData>(
                                    builder: (context, amount, child) {
                                    return Text(
                                      '₹ ${amount.totalAmount}',
                                      style: TextStyle(
                                          color: Colors.orange,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20),
                                    );
                                  }),
                          ],
                        ),
                        SizedBox(height: 40),
                        Text(
                          'Select payment option',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        SizedBox(height: 30),
                        !(Provider.of<APIData>(context, listen: false)
                                        .walletUsed ==
                                    true &&
                                Provider.of<APIData>(context, listen: false)
                                        .totalAmount ==
                                    0)
                            ? Container(
                                child: Column(
                                  children: [
                                    Consumer<APIData>(
                                        builder: (context, payment, child) {
                                      return RadioListTile(
                                        value: Payment.online,
                                        groupValue: payment.choice,
                                        title: Text(
                                          "Online Payment",
                                          style: TextStyle(
                                              color: Colors.orange,
                                              fontSize: 18),
                                        ),
                                        onChanged: (value) {
                                          Provider.of<APIData>(context,
                                                  listen: false)
                                              .initializepaymentChoice(value);
                                          onlinePayment = true;
                                          cashOnDelivery = false;
                                        },
                                        activeColor: Colors.purple,
                                      );
                                    }),
                                    widget.paynow
                                        ? Container()
                                        : Consumer<APIData>(
                                            builder: (context, payment, child) {
                                            return RadioListTile(
                                              value: Payment.cod,
                                              groupValue: payment.choice,
                                              title: Text(
                                                "COD",
                                                style: TextStyle(
                                                    color: Colors.orange,
                                                    fontSize: 18),
                                              ),
                                              onChanged: (value) {
                                                Provider.of<APIData>(context,
                                                        listen: false)
                                                    .initializepaymentChoice(
                                                        value);
                                                cashOnDelivery = true;
                                                onlinePayment = false;
                                              },
                                              activeColor: Colors.purple,
                                            );
                                          })
                                  ],
                                ),
                              )
                            : Container(),
                        SizedBox(height: 30),
                        Consumer<APIData>(builder: (context, data, child) {
                          return ElevatedButton(
                            onPressed: () {
                              String orderIds = getOrderIds();
                              if (onlinePayment == true) {
                                initiateRazorpay();
                                if (widget.couponApplied) {
                                  applyCoupon();
                                }
                                print(1);
                              } else if (cashOnDelivery == true) {
                                placeOrder(orderIds);
                                if (Provider.of<APIData>(context, listen: false)
                                    .walletUsed) {
                                  updateUserWallet();
                                }
                                if (widget.couponApplied) {
                                  applyCoupon();
                                }
                                print(2);
                              } else if (Provider.of<APIData>(context,
                                              listen: false)
                                          .walletUsed ==
                                      true &&
                                  Provider.of<APIData>(context, listen: false)
                                          .totalAmount ==
                                      0) {
                                placeOrder(orderIds);
                                updateUserWallet();
                                if (widget.couponApplied) {
                                  applyCoupon();
                                }
                                print(3);
                              } else {
                                showSnackBar("Please select a payment option");
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.purple,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 80, vertical: 25),
                              child: Text(
                                data.paymentText,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ),
                          );
                        })
                      ],
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                print(snapshot.error);
              } else {
                return Center();
              }
            }
            return Center();
          }),
    );
  }

  void placeOrder(String productOrderID) async {
    String userId = Provider.of<APIData>(context, listen: false).user.id;
    String centerId = Provider.of<APIData>(context, listen: false).centerId;
    String paymentOption = "";
    if (onlinePayment) {
      paymentOption = "Online Payment";
    } else {
      paymentOption = "COD";
    }
    String deliveryDay = "";
    String deliveryTime = "";
    String couponCode = widget.couponCode;
    String couponId = widget.couponId;
    String couponValue = widget.couponValue;
    double deliveryCharges =
        Provider.of<APIData>(context, listen: false).deliveryCharges;
    String orderNumber = widget.paynow
        ? widget.orderNumber
        : widget.updateOrder
            ? widget.orderNumber
            : randomNumber();
    String walletUsed = "";
    if (Provider.of<APIData>(context, listen: false).walletUsed) {
      walletUsed = "YES";
    } else {
      walletUsed = "NO";
    }
    double walletAmountUsed = walletUsed == 'YES'
        ? Provider.of<APIData>(context, listen: false).walletAmountUsed
        : 0;
    String userExpectedDeliveryDate = "";
    http.Response response;
    String url =
        "$header/app_api/updateOrderStatus.php?id=$productOrderID&user_id=$userId&center_id=$centerId&payment_option=$paymentOption&delivery_day=$deliveryDay&delivery_time=$deliveryTime&coupon_code=$couponCode&coupon_id=$couponId&coupon_value=$couponValue&delivery_chrges=$deliveryCharges&user_expected_delivery_date=$userExpectedDeliveryDate&wallet=$walletUsed&used_wallet_amount=$walletAmountUsed&order_number=$orderNumber";
    Uri uri = Uri.parse(url);
    print(url);
    response = await http.get(uri);
    var jsonData = jsonDecode(response.body);
    if (jsonData["code"] == "200") {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                content: Text("Thank you for ordering with us"),
                title:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Icon(
                      Icons.check,
                      color: Colors.green,
                      size: 40,
                    ),
                  ),
                  Flexible(child: Text("Order Placed Successfully"))
                ]),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => Home()));
                      },
                      child: Text(
                        "OK",
                        style: TextStyle(color: Colors.black),
                      ))
                ],
              ));
    } else {
      showSnackBar("Something Went Wrong");
    }
  }

  String getOrderIds() {
    String orderIds = "";
    for (int i = 0; i < widget.productOrderId.length; i++) {
      if (i == 0) {
        orderIds += widget.productOrderId[i];
      } else {
        orderIds += ",";
        orderIds += widget.productOrderId[i];
      }
    }
    return orderIds;
  }

  Future walletAmount() async {
    String userId = Provider.of<APIData>(context, listen: false).user.id;
    http.Response response;
    String url = "$header/app_api/getUserWallet.php?user_id=$userId";
    Uri uri = Uri.parse(url);
    response = await http.get(uri);
    var jsonData = jsonDecode(response.body);
    walletamount = double.parse(jsonData["total"]);
    Provider.of<APIData>(context, listen: false)
        .initializeWalletAmount(walletamount);
    return jsonData["total"];
  }

  String randomNumber() {
    Random random = new Random();
    var next = random.nextDouble() * 1000000;
    while (next < 100000) {
      next *= 10;
    }
    String number = next.toString().split(".")[0];
    return number;
  }

  void showSnackBar(String content) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(content)));
  }

  void applyCoupon() async {
    String coupon = widget.couponApplied ? widget.couponCode : "";
    http.Response response;
    String url = "$header/app_api/applyCoupon.php?coupon=$coupon";
    Uri uri = Uri.parse(url);
    response = await http.get(uri);
    var jsonData = jsonDecode(response.body);
    if (jsonData["code"] == "200") {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Coupon Applied Successfully")));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Something Went Wrong")));
    }
  }

  void updateUserWallet() async {
    String userId = Provider.of<APIData>(context, listen: false).user.id;
    http.Response response;
    double amount = Provider.of<APIData>(context, listen: false).walletAmount -
        Provider.of<APIData>(context, listen: false).walletAmountUsed;
    print(amount);
    Provider.of<APIData>(context, listen: false).initializeWalletAmount(amount);
    print(Provider.of<APIData>(context, listen: false).walletAmount);
    String url =
        "$header/app_api/updateUserWallet.php?id=$userId&amount=$amount";
    Uri uri = Uri.parse(url);
    response = await http.get(uri);
    var jsonData = jsonDecode(response.body);
    if (jsonData["code"] == "200") {
      showSnackBar("Wallet Updated");
    }
  }
}
