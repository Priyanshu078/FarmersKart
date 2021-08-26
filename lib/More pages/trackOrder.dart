import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../colors.dart';

class TrackOrder extends StatefulWidget {
  const TrackOrder({Key key}) : super(key: key);

  @override
  _TrackOrderState createState() => _TrackOrderState();
}

class _TrackOrderState extends State<TrackOrder> {

  var date = "Fri, 30 Jul";
  var orderID = "a6ecMO";
  var amount = "85.00";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Track Order',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 17,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height*0.15,
              width: double.infinity,
              padding: EdgeInsets.all(20),
              color: Colors.grey.shade100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: MediaQuery.of(context).size.width*0.105),
                      Text(date,
                        style: TextStyle(color: Colors.purple, fontSize: 18),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Order ID: $orderID',
                          style: TextStyle(color: left, fontSize: 18)
                      ),
                      SizedBox(width: 40),
                      Text('Amt :$amount',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)
                      )
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30,20,0,0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.green.shade900,
                    radius: 11,
                    child: Icon(
                        Icons.check,
                        size: 18,
                        color: Colors.white
                    ),
                  ),
                  SizedBox(width: 10),
                  Text('Order Received',
                    style: TextStyle(fontSize: 14),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30,0,0,0),
              child: ListView.builder(
                itemCount: trackOrder.length,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemBuilder: (context, index){
                  return Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 45,
                            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 3),
                            child: VerticalDivider(
                              color: Colors.grey,
                              thickness: 5,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.green,
                            radius: 11,
                          ),
                          SizedBox(width: 10),
                          Text(trackOrder[index].itemName +", "+ trackOrder[index].itemStatus,
                            style: TextStyle(fontSize: 14),
                          )
                        ],
                      )
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Track {
  final String itemName, itemStatus;

  Track({
    this.itemName,
    this.itemStatus
  });
}

List<Track> trackOrder = [
  Track(
      itemName: 'Elachi Banana',
      itemStatus: 'Delivered'
  ),
  Track(
      itemName: 'Tomato',
      itemStatus: 'Delivered'
  ),
];