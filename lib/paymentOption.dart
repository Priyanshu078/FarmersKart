import 'package:flutter/material.dart';
import 'colors.dart';

enum Payment { online, cod }

class PaymentOption extends StatefulWidget {
  const PaymentOption({Key key}) : super(key: key);

  @override
  _PaymentOptionState createState() => _PaymentOptionState();
}

class _PaymentOptionState extends State<PaymentOption> {
  bool checkbox = false;
  Payment option;
  var wallet = '3';
  var amount = '70.0';

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
                onPressed: () {},
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
}
