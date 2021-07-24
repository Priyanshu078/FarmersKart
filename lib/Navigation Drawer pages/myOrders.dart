import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shellcode2/Bottom%20bar%20pages/categories.dart';
import 'package:shellcode2/Bottom%20bar%20pages/wishlist.dart';
import 'package:shellcode2/colors.dart';
import 'package:shellcode2/home.dart';

class Orders extends StatefulWidget {
  @override
  _OrdersState createState() => _OrdersState();
}

int val=0;
class _OrdersState extends State<Orders> with SingleTickerProviderStateMixin{

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Builder(builder: (BuildContext context) {
      final TabController _tabController = DefaultTabController.of(context)!;
      _tabController.addListener(() {
        if (!_tabController.indexIsChanging) {
          setState(() {
            val = _tabController.index;
          });
        }
          });
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        centerTitle: true,
        titleSpacing: 0.0,
        elevation: 0,
        //brightness: Brightness.light,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [left,middle,Colors.purple]
              )
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios,
              size: 20,
              color: yellow),
        ),
        title: Text('My Orders',
        style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 18,
            color: Colors.white,
          ),),
      ),
      body: DefaultTabController(
        length: 1,
        child: Column(
        children: <Widget>[
          Container(
            height: 60,
            constraints: BoxConstraints(maxHeight: 150.0),
            child: Material(
              color: bgcolor,
              child: TabBar(
                controller: _tabController,
                indicatorColor: yellow,
                unselectedLabelColor: Colors.black,
                tabs: [
                  Tab(child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                        color: val ==0? yellow.withOpacity(0.7):yellow.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    child: Align(
                        alignment: Alignment.center,
                        child: Text('Total Order',style: TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.w300),)),
                  ),),
                  Tab(child:
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                        color: val ==1? yellow.withOpacity(0.7):yellow.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    child: Align(
                        alignment: Alignment.center,
                        child: Text("Today's Order",style: TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.w300),)),
                  ),),
                  Tab(child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                        color: val ==2? yellow.withOpacity(0.7):yellow.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    child: Align(
                        alignment: Alignment.center,
                        child: Text('Cancel Order',style: TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.w300),)),
                  ),),
                ],
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                SingleChildScrollView(child: val==0? Container(
                  child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                for(int i=0; i<category1.length; i++) ...{
                  Container(
                      padding: EdgeInsets.all(30.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              height: 25,
                              decoration: BoxDecoration(
                                  border: Border(
                                    top: BorderSide(width: 1.0, color: Colors.greenAccent),
                                    left: BorderSide(width: 1.0, color: Colors.greenAccent),
                                    right: BorderSide(width: 1.0, color: Colors.greenAccent),
                                    bottom: BorderSide(width: 1.0, color: Colors.greenAccent),
                                  ),
                                  borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(30),
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text('Gnerate invoice',style: TextStyle(fontSize: 10,fontWeight: FontWeight.normal,color: Colors.greenAccent),)
                                ),
                              ),
                            ),
                          ),
                          Text('Order Number: ${category1[i].orderNo}',style: TextStyle(fontSize: 12,fontWeight: FontWeight.normal,color: Colors.black),),
                          SizedBox(
                            height: 10,
                          ),
                          Text('Total Amount: ₹${category1[i].amount}',style: TextStyle(fontSize: 12,fontWeight: FontWeight.normal,color: Colors.black),),
                          SizedBox(
                            height: 10,
                          ),
                          Text('${category1[i].status}',style: TextStyle(fontSize: 10,fontWeight: FontWeight.normal,color: Colors.grey),),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  height: 25,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(width: 1.0, color: Colors.orange),
                                      left: BorderSide(width: 1.0, color: Colors.orange),
                                      right: BorderSide(width: 1.0, color: Colors.orange),
                                      bottom: BorderSide(width: 1.0, color: Colors.orange),
                                    ),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(30),
                                    onTap: () {},
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: Text('Complaints',style: TextStyle(fontSize: 10,fontWeight: FontWeight.normal,color: Colors.black),)
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  height: 25,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(width: 1.0, color: Colors.greenAccent),
                                      left: BorderSide(width: 1.0, color: Colors.greenAccent),
                                      right: BorderSide(width: 1.0, color: Colors.greenAccent),
                                      bottom: BorderSide(width: 1.0, color: Colors.greenAccent),
                                    ),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(30),
                                    onTap: () {},
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: Text('Feedback',style: TextStyle(fontSize: 10,fontWeight: FontWeight.normal,color: Colors.black),)
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  height: 25,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(width: 2.0, color: Colors.blue),
                                      left: BorderSide(width: 2.0, color: Colors.blue),
                                      right: BorderSide(width: 2.0, color: Colors.blue),
                                      bottom: BorderSide(width: 2.0, color: Colors.blue),
                                    ),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(30),
                                    onTap: () {},
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: Text('Track Order',style: TextStyle(fontSize: 10,fontWeight: FontWeight.normal,color: Colors.black),)
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  height: 25,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(width: 2.0, color: Colors.red),
                                      left: BorderSide(width: 2.0, color: Colors.red),
                                      right: BorderSide(width: 2.0, color: Colors.red),
                                      bottom: BorderSide(width: 2.0, color: Colors.red),
                                    ),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(30),
                                    onTap: () {},
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: Text('Cancel Order',style: TextStyle(fontSize: 10,fontWeight: FontWeight.normal,color: Colors.orangeAccent),)
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                  ),
                },
              ],
                )):val==1?
                Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                        for(int i=0; i<category1.length; i++) ...{
                          Container(
                              padding: EdgeInsets.all(30.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Container(
                                      height: 25,
                                      decoration: BoxDecoration(
                                        border: Border(
                                          top: BorderSide(width: 1.0, color: Colors.black),
                                          left: BorderSide(width: 1.0, color: Colors.black),
                                          right: BorderSide(width: 1.0, color: Colors.black),
                                          bottom: BorderSide(width: 1.0, color: Colors.black),
                                        ),
                                        borderRadius: BorderRadius.circular(5.0),
                                      ),
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(30),
                                        onTap: () {},
                                        child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text('Generate invoice',style: TextStyle(fontSize: 10,fontWeight: FontWeight.normal,color: Colors.blueGrey),)
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text('Order Number: ${category1[i].orderNo}',style: TextStyle(fontSize: 12,fontWeight: FontWeight.normal,color: Colors.black),),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text('Total Amount: ₹${category1[i].amount}',style: TextStyle(fontSize: 12,fontWeight: FontWeight.normal,color: Colors.black),),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text('${category1[i].status}',style: TextStyle(fontSize: 10,fontWeight: FontWeight.normal,color: Colors.grey),),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Container(
                                          height: 25,
                                          width: 150,
                                          decoration: BoxDecoration(
                                            border: Border(
                                              top: BorderSide(width: 1.0, color: Colors.yellow),
                                              left: BorderSide(width: 1.0, color: Colors.yellow),
                                              right: BorderSide(width: 1.0, color: Colors.yellow),
                                              bottom: BorderSide(width: 1.0, color: Colors.yellow),
                                            ),
                                            borderRadius: BorderRadius.circular(5.0),
                                          ),
                                          child: InkWell(
                                            borderRadius: BorderRadius.circular(30),
                                            onTap: () {},
                                            child: Align(
                                                alignment: Alignment.center,
                                                child: Text('Complaints',style: TextStyle(fontSize: 10,fontWeight: FontWeight.normal,color: Colors.black),)
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Container(
                                          height: 25,
                                          width: 150,
                                          decoration: BoxDecoration(
                                            border: Border(
                                              top: BorderSide(width: 1.0, color: Colors.black),
                                              left: BorderSide(width: 1.0, color: Colors.black),
                                              right: BorderSide(width: 1.0, color: Colors.black),
                                              bottom: BorderSide(width: 1.0, color: Colors.black),
                                            ),
                                            borderRadius: BorderRadius.circular(5.0),
                                          ),
                                          child: InkWell(
                                            borderRadius: BorderRadius.circular(30),
                                            onTap: () {},
                                            child: Align(
                                                alignment: Alignment.center,
                                                child: Text('Feedback',style: TextStyle(fontSize: 10,fontWeight: FontWeight.normal,color: Colors.white),)
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Container(
                                          height: 25,
                                          width: 150,
                                          decoration: BoxDecoration(
                                            border: Border(
                                              top: BorderSide(width: 2.0, color: Colors.blue),
                                              left: BorderSide(width: 2.0, color: Colors.blue),
                                              right: BorderSide(width: 2.0, color: Colors.blue),
                                              bottom: BorderSide(width: 2.0, color: Colors.blue),
                                            ),
                                            borderRadius: BorderRadius.circular(5.0),
                                          ),
                                          child: InkWell(
                                            borderRadius: BorderRadius.circular(30),
                                            onTap: () {},
                                            child: Align(
                                                alignment: Alignment.center,
                                                child: Text('Track Order',style: TextStyle(fontSize: 10,fontWeight: FontWeight.normal,color: Colors.white),)
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Container(
                                          height: 25,
                                          width: 150,
                                          decoration: BoxDecoration(
                                            border: Border(
                                              top: BorderSide(width: 2.0, color: Colors.red),
                                              left: BorderSide(width: 2.0, color: Colors.red),
                                              right: BorderSide(width: 2.0, color: Colors.red),
                                              bottom: BorderSide(width: 2.0, color: Colors.red),
                                            ),
                                            borderRadius: BorderRadius.circular(5.0),
                                          ),
                                          child: InkWell(
                                            borderRadius: BorderRadius.circular(30),
                                            onTap: () {},
                                            child: Align(
                                                alignment: Alignment.center,
                                                child: Text('Cancel Order',style: TextStyle(fontSize: 10,fontWeight: FontWeight.normal,color: Colors.red),)
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              )
                          ),
                        },
                      ],
                    )):
                  Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:[
                          for(int i=0; i<category1.length; i++) ...{
                            Container(
                                padding: EdgeInsets.all(30.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Container(
                                        height: 25,
                                        decoration: BoxDecoration(
                                          border: Border(
                                            top: BorderSide(width: 1.0, color: Colors.greenAccent),
                                            left: BorderSide(width: 1.0, color: Colors.greenAccent),
                                            right: BorderSide(width: 1.0, color: Colors.greenAccent),
                                            bottom: BorderSide(width: 1.0, color: Colors.greenAccent),
                                          ),
                                          borderRadius: BorderRadius.circular(5.0),
                                        ),
                                        child: InkWell(
                                          borderRadius: BorderRadius.circular(30),
                                          onTap: () {},
                                          child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Text('Gnerate invoice',style: TextStyle(fontSize: 10,fontWeight: FontWeight.normal,color: Colors.greenAccent),)
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text('Order Number: ${category1[i].orderNo}',style: TextStyle(fontSize: 12,fontWeight: FontWeight.normal,color: Colors.white),),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text('Total Amount: ₹${category1[i].amount}',style: TextStyle(fontSize: 12,fontWeight: FontWeight.normal,color: Colors.white),),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text('${category1[i].status}',style: TextStyle(fontSize: 10,fontWeight: FontWeight.normal,color: Colors.grey),),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: Container(
                                            height: 25,
                                            width: 150,
                                            decoration: BoxDecoration(
                                              border: Border(
                                                top: BorderSide(width: 1.0, color: Colors.orange),
                                                left: BorderSide(width: 1.0, color: Colors.orange),
                                                right: BorderSide(width: 1.0, color: Colors.orange),
                                                bottom: BorderSide(width: 1.0, color: Colors.orange),
                                              ),
                                              borderRadius: BorderRadius.circular(5.0),
                                            ),
                                            child: InkWell(
                                              borderRadius: BorderRadius.circular(30),
                                              onTap: () {},
                                              child: Align(
                                                  alignment: Alignment.center,
                                                  child: Text('Complaints',style: TextStyle(fontSize: 10,fontWeight: FontWeight.normal,color: Colors.white),)
                                              ),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: Container(
                                            height: 25,
                                            width: 150,
                                            decoration: BoxDecoration(
                                              border: Border(
                                                top: BorderSide(width: 1.0, color: Colors.greenAccent),
                                                left: BorderSide(width: 1.0, color: Colors.greenAccent),
                                                right: BorderSide(width: 1.0, color: Colors.greenAccent),
                                                bottom: BorderSide(width: 1.0, color: Colors.greenAccent),
                                              ),
                                              borderRadius: BorderRadius.circular(5.0),
                                            ),
                                            child: InkWell(
                                              borderRadius: BorderRadius.circular(30),
                                              onTap: () {},
                                              child: Align(
                                                  alignment: Alignment.center,
                                                  child: Text('Feedback',style: TextStyle(fontSize: 10,fontWeight: FontWeight.normal,color: Colors.white),)
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Container(
                                        height: 25,
                                        width: 150,
                                        decoration: BoxDecoration(
                                          border: Border(
                                            top: BorderSide(width: 2.0, color: Colors.blue),
                                            left: BorderSide(width: 2.0, color: Colors.blue),
                                            right: BorderSide(width: 2.0, color: Colors.blue),
                                            bottom: BorderSide(width: 2.0, color: Colors.blue),
                                          ),
                                          borderRadius: BorderRadius.circular(5.0),
                                        ),
                                        child: InkWell(
                                          borderRadius: BorderRadius.circular(30),
                                          onTap: () {},
                                          child: Align(
                                              alignment: Alignment.center,
                                              child: Text('Track Order',style: TextStyle(fontSize: 10,fontWeight: FontWeight.normal,color: Colors.white),)
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                            ),
                          },
                        ],
                      )),),
              ],
            ),
          ),
        ],
      ),
      ),
      bottomNavigationBar: Navigate(),
      );

        }),
    );
  }
}


class Navigate extends StatefulWidget {
  const Navigate({Key? key}) : super(key: key);

  @override
  _NavigateState createState() => _NavigateState();
}

class _NavigateState extends State<Navigate> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: bgcolor,
        child: ClipRRect(
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
                icon:  GestureDetector(
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Home()));
                    },
                    child: Icon(Icons.home)),
                title:  Text('Home'),
              ),
              BottomNavigationBarItem(
                icon:  GestureDetector(
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Category()));
                    },
                    child: Icon(Icons.list)),
                title:  Text('Categories'),
              ),
              BottomNavigationBarItem(
                  icon: GestureDetector(
                      onTap: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Wishlist()));
                      },
                      child: Icon(CupertinoIcons.heart)), title: Text('Wishlist')),
            ],
          ),
        ));
  }
}

class Categories{
  String orderNo;
  double amount;
  String status;
  //String classTitle;
  Categories({
    required this.orderNo,
    required this.amount,
    required this.status,
  });
}

List<Categories> category1 =[
  Categories(orderNo: 'nlML00', amount: 198.00,status: 'Replacement Today'),
  Categories(orderNo: 'nlML00', amount: 198.00,status: 'Replacement Today'),
  Categories(orderNo: 'nlML00', amount: 198.00,status: 'Replacement Today'),
  Categories(orderNo: 'nlML00', amount: 198.00,status: 'Replacement Today'),

];