import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shellcode2/Provider/data.dart';
import 'colors.dart';

enum Payment { online, cod }

class PaymentOption extends StatefulWidget {
  const PaymentOption({Key key}) : super(key: key);

  @override
  _PaymentOptionState createState() => _PaymentOptionState();
}

class _PaymentOptionState extends State<PaymentOption> {
  Razorpay _razorpay;
  bool checkbox = false;
  Payment option;
  var wallet = '3';
  var amount = '70.0';

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
    showSnackBar("Success " + response.paymentId);
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
    super.dispose();
    _razorpay.clear();
  }

  void initiateRazorpay() {
    Map<String, dynamic> options = {
      'key': 'rzp_test_UbDUVjXf0eL5Uf',
      'amount': '100',
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
      body: SingleChildScrollView(
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
                  Text(
                    '₹ $wallet',
                    style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.w700,
                        fontSize: 20),
                  ),
                ],
              ),
              SizedBox(height: 15),
              CheckboxListTile(
                  value: checkbox,
                  onChanged: (_) {
                    setState(() {
                      checkbox = !checkbox;
                    });
                  },
                  title: Text(
                    'check this to use wallet amount',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: Colors.purple),
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
                  Text(
                    '₹ $amount',
                    style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.w700,
                        fontSize: 20),
                  ),
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
              Column(
                children: [
                  ListTile(
                    title: Text('Online payment',
                        style: TextStyle(fontSize: 18, color: Colors.orange)),
                    leading: Radio(
                      value: Payment.online,
                      groupValue: option,
                      onChanged: (value) {
                        setState(() {
                          option = value;
                          print(option);
                        });
                      },
                      activeColor: Colors.purple,
                    ),
                  ),
                  ListTile(
                    title: Text('COD',
                        style: TextStyle(fontSize: 18, color: Colors.orange)),
                    leading: Radio(
                      value: Payment.cod,
                      groupValue: option,
                      onChanged: (value) {
                        setState(() {
                          option = value;
                          print(option);
                        });
                      },
                      activeColor: Colors.purple,
                    ),
                  )
                ],
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  initiateRazorpay();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.purple,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 80, vertical: 25),
                  child: Text(
                    'MAKE PAYMENT',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void showSnackBar(String content) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(content)));
  }
}
