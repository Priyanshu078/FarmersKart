import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shellcode2/Provider/data.dart';
import 'package:shellcode2/newAddress.dart';
import 'package:shellcode2/paymentOption.dart';
import 'Bottom bar pages/categories.dart';
import 'Bottom bar pages/wishlist.dart';
import 'colors.dart';
import 'home.dart';

class DeliveryAddress extends StatefulWidget {
  const DeliveryAddress({Key key}) : super(key: key);

  @override
  _DeliveryAddressState createState() => _DeliveryAddressState();
}

class _DeliveryAddressState extends State<DeliveryAddress> {
  String address;

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
          'Choose Delivery Address',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
      bottomNavigationBar: Navigate(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Text(
                    'SAVED ADDRESS',
                    style: TextStyle(color: Colors.orange, fontSize: 18),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NewAddress()));
                    },
                    child: Text(
                      '+ADD NEW \n  ADDRESS',
                      style: TextStyle(
                          color: Colors.blue.shade700,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 15),
            ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: 1,
              itemBuilder: (context, index) {
                return Consumer<APIData>(builder: (context, account, child) {
                  return RadioListTile(
                    value: account.address,
                    groupValue: address,
                    title: Text(
                      account.address,
                      style: TextStyle(color: Colors.orange, fontSize: 18),
                    ),
                    onChanged: (value) async {
                      setState(() {
                        address = value;
                        print(address);
                      });
                    },
                    activeColor: Colors.purple,
                  );
                });
              },
            ),
          ],
        ),
      ),
    );
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
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                color: Colors.amberAccent.shade400,
                child: Row(
                  children: [
                    Text(
                      '₹ ',
                      style: TextStyle(
                          color: Colors.purple,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '70.0',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.purple,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: Text(
                          'MAKE PAYMENT',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PaymentOption()));
                      },
                    )
                  ],
                )),
            ClipRRect(
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Category()));
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
            ),
          ],
        ));
  }
}
