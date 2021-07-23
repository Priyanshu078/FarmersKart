import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shellcode2/Bottom%20bar%20pages/categories.dart';
import 'package:shellcode2/Bottom%20bar%20pages/wishlist.dart';
import 'package:shellcode2/colors.dart';
import 'package:shellcode2/home.dart';

class HandyOrder extends StatefulWidget {
  const HandyOrder({Key? key}) : super(key: key);

  @override
  _HandyOrderState createState() => _HandyOrderState();
}
String title2='';
class _HandyOrderState extends State<HandyOrder> {
  final _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightbg,
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
        title: Text('Handy Order',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 18,
            color: Colors.white,
          ),),

      ),
      body: Container(
        padding: EdgeInsets.only(top: 20.0),
        child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
                alignment: Alignment.center,
                child: Text('Click product list image & Upload',style: TextStyle(color: Colors.white,fontSize: 16),)),
            SizedBox(
              height: 20,
            ),
           // ..camera
            SizedBox(
              height: 20,
            ),
            MaterialButton(
              minWidth: double.infinity,
              height: 30,
              onPressed: null,
              //() {
              // Navigator.push(context,
              //   MaterialPageRoute(builder: (context) => login2()));
              //},
              color: bgcolor,
              elevation: 0,
              disabledColor: bgcolor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                  cursorColor: Colors.purpleAccent,
                  controller: _textController,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepPurpleAccent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepPurpleAccent),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepPurpleAccent),
                      ),
                      hintStyle: TextStyle( color: yellow ),
                      hintText: 'Type Your Product List...',
                      labelStyle: new TextStyle(
                          color: yellow
                      )
                  )// Set Your Own Color
                  ),
                ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: GestureDetector(
                onTap: (){

                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Colors.purple
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text('SUBMIT', style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      letterSpacing: 1,
                      color: Colors.white,
                    ),
                    ),
                  ),
                ),
              ),
            ),
              ],
            ),
            ),
      bottomNavigationBar: Navigate(),
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
            backgroundColor: Colors.grey[900],
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