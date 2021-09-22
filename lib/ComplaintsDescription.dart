import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

class ComplaintsDescription extends StatefulWidget {
  String productId;
  String complaintText;
  String date;
  String adminComment;
  String complaintStatus;
  String orderId;
  ComplaintsDescription({Key key, @required this.productId, @required this.complaintText, @required this.date, @required this.adminComment, @required this.complaintStatus, this.orderId}) : super(key: key);

  @override
  _ComplaintsDescriptionState createState() => _ComplaintsDescriptionState();
}

class _ComplaintsDescriptionState extends State<ComplaintsDescription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Complaints Status"),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [left, middle, Colors.purple])),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(width: 1.0, color: yellow),
                    left: BorderSide(width: 1.0, color: yellow),
                    right: BorderSide(width: 1.0, color: yellow),
                    bottom: BorderSide(width: 1.0, color: yellow),
                  ),
                  borderRadius: BorderRadius.circular(5.0),
                  gradient:
                  LinearGradient(colors: [left, middle, Colors.purple])),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text(
                    'Product Id : ${widget.productId}',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(width: 1.0, color: yellow),
                    left: BorderSide(width: 1.0, color: yellow),
                    right: BorderSide(width: 1.0, color: yellow),
                    bottom: BorderSide(width: 1.0, color: yellow),
                  ),
                  borderRadius: BorderRadius.circular(5.0),
                  gradient:
                  LinearGradient(colors: [left, middle, Colors.purple])),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text(
                    'Complaint Text : ${widget.complaintText}',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(width: 1.0, color: yellow),
                    left: BorderSide(width: 1.0, color: yellow),
                    right: BorderSide(width: 1.0, color: yellow),
                    bottom: BorderSide(width: 1.0, color: yellow),
                  ),
                  borderRadius: BorderRadius.circular(5.0),
                  gradient:
                  LinearGradient(colors: [left, middle, Colors.purple])),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text(
                    'Created At : ${widget.date}',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(width: 1.0, color: yellow),
                    left: BorderSide(width: 1.0, color: yellow),
                    right: BorderSide(width: 1.0, color: yellow),
                    bottom: BorderSide(width: 1.0, color: yellow),
                  ),
                  borderRadius: BorderRadius.circular(5.0),
                  gradient:
                  LinearGradient(colors: [left, middle, Colors.purple])),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text(
                    'Admin Comment : ${widget.adminComment}',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(width: 1.0, color: yellow),
                    left: BorderSide(width: 1.0, color: yellow),
                    right: BorderSide(width: 1.0, color: yellow),
                    bottom: BorderSide(width: 1.0, color: yellow),
                  ),
                  borderRadius: BorderRadius.circular(5.0),
                  gradient:
                  LinearGradient(colors: [left, middle, Colors.purple])),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text(
                    'Complaint Status : ${widget.complaintStatus}',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(width: 1.0, color: yellow),
                    left: BorderSide(width: 1.0, color: yellow),
                    right: BorderSide(width: 1.0, color: yellow),
                    bottom: BorderSide(width: 1.0, color: yellow),
                  ),
                  borderRadius: BorderRadius.circular(5.0),
                  gradient:
                  LinearGradient(colors: [left, middle, Colors.purple])),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text(
                    'Order Id : ${widget.orderId}',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
