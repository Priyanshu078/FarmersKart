import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shellcode2/ComplaintsDescription.dart';
import 'package:shellcode2/Provider/data.dart';
import 'package:shellcode2/apiData/Constants.dart';

import 'colors.dart';

class ComplaintStatus extends StatefulWidget {
  const ComplaintStatus({Key key}) : super(key: key);

  @override
  _ComplaintStatusState createState() => _ComplaintStatusState();
}

class _ComplaintStatusState extends State<ComplaintStatus> {
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
      body: FutureBuilder(
        future: getUserCompaints(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return ListView.separated(
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ComplaintsDescription(productId: "OverAll", complaintText: snapshot.data[index].complaintText, date: snapshot.data[index].createdAt, adminComment: snapshot.data[index].adminComment, complaintStatus: snapshot.data[index].status, orderId: snapshot.data[index].orderId)));
                      },
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(8, 5, 0, 5),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Order Id : ${snapshot.data[index].orderId}",
                                  style: TextStyle(
                                      color: Colors.purple[600],
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(8, 5, 0, 5),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Status : ${snapshot.data[index].status}",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.amber[600],
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 8, 8, 5),
                              child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: Text(
                                    snapshot.data[index].createdAt,
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.purple[600]),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(height: 10, color: Colors.black);
                  },
                  itemCount: snapshot.data.length);
            } else if (snapshot.hasError) {
              print(snapshot.error);
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Future<List> getUserCompaints() async {
    http.Response response;
    String userId = Provider.of<APIData>(context, listen: false).userId;
    String url = "$header/app_api/getusercomplaints.php?user_id=$userId";
    Uri uri = Uri.parse(url);
    response = await http.get(uri);
    List complaint = [];
    var jsonData = jsonDecode(response.body);
    if (jsonData["code"] == "200") {
      for (var item in jsonData["data"]) {
        Complaints complaints = new Complaints(
            item["image_name"],
            item["complaints_text"],
            item["created_at"],
            item["status"],
            item["order_id"],
            item["admin_comment"]);
        complaint.add(complaints);
      }
    }
    return complaint;
  }
}

class Complaints {
  String imageName;
  String complaintText;
  String createdAt;
  String status;
  String orderId;
  String adminComment;
  Complaints(
    this.imageName,
    this.complaintText,
    this.createdAt,
    this.status,
    this.orderId,
    this.adminComment,
  );
}
