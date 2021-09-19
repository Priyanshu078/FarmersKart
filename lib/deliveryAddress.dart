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
  int id;
  String couponId;
  String couponCode;
  String couponValue;
  List productOrderId;
  double deliveryCharges;
  double totalAmount;
  DeliveryAddress(
      {Key key,
      @required this.totalAmount,
      @required this.productOrderId,
      @required this.deliveryCharges,
      @required this.couponCode,
      @required this.couponId,
      @required this.couponValue})
      : super(key: key);
  DeliveryAddress.handyOrder(this.id);

  @override
  _DeliveryAddressState createState() => _DeliveryAddressState();
}

class _DeliveryAddressState extends State<DeliveryAddress> {
  String address;
  bool selected = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
          'Choose Delivery Address',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
      bottomNavigationBar: widget.id == 1
          ? Navigate.handyOrder(widget.id)
          : Navigate(
              totalAmount: widget.totalAmount,
              deliveryCharges: widget.deliveryCharges,
              selected: selected,
              couponId: widget.couponId,
              couponCode: widget.couponCode,
              couponValue: widget.couponValue,
              productOrderId: widget.productOrderId,
            ),
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
                        selected = true;
                        print(selected);
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
  int id;
  double totalAmount;
  double deliveryCharges;
  bool selected;
  String couponId;
  String couponCode;
  String couponValue;
  List productOrderId;
  Navigate(
      {Key key,
      @required this.totalAmount,
      @required this.deliveryCharges,
      @required this.selected,
      @required this.couponId,
      @required this.couponCode,
      @required this.couponValue,
      @required this.productOrderId})
      : super(key: key);
  Navigate.handyOrder(this.id);

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
            widget.id == 1
                ? Container()
                : Container(
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
                        Consumer<APIData>(builder: (context, amount, child) {
                          return Text(
                            (amount.totalAmount).toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          );
                        }),
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
                            double totalAmount =
                                widget.totalAmount + widget.deliveryCharges;
                            if (widget.selected) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PaymentOption(
                                            totalAmount: totalAmount,
                                            couponId: widget.couponId,
                                            couponCode: widget.couponCode,
                                            couponValue: widget.couponValue,
                                            deliveryCharges:
                                                widget.deliveryCharges,
                                            productOrderId:
                                                widget.productOrderId,
                                          )));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text("Please select the address")));
                            }
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
