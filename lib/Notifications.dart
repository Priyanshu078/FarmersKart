import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shellcode2/Provider/data.dart';
import 'package:shellcode2/apiData/Constants.dart';
import 'package:shellcode2/colors.dart';

class Notifications extends StatefulWidget {
  Notifications({Key key}) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [left, middle, Colors.purple])),
        ),
      ),
      body: FutureBuilder(
          future: getNotifications(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return ListView.separated(
                    itemBuilder: (context, index) {
                      return Column(children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                          child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                snapshot.data[index].message,
                                style: TextStyle(
                                    color: Colors.amber[400],
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              )),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                          child: Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                "Received at : " +
                                    snapshot.data[index].timeStamp,
                                style: TextStyle(
                                    color: Colors.purple[600],
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              )),
                        )
                      ]);
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        height: 10,
                        color: Colors.black,
                      );
                    },
                    itemCount: snapshot.data.length);
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

  Future<List> getNotifications() async {
    String UserId = Provider.of<APIData>(context, listen: false).userId;
    Dio dio = new Dio();
    String url = "$header/app_api/inapp_notifications.php?user_id=$UserId";
    Response response = await dio.get(url);
    var jsonData = jsonDecode(response.data);
    List notifications = [];
    for (var item in jsonData["records"]) {
      Notification notification =
          new Notification(item["message"], item["timestamp"]);
      notifications.add(notification);
    }
    return notifications;
  }
}

class Notification {
  String message;
  String timeStamp;
  Notification(this.message, this.timeStamp);
}
