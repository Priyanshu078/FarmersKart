import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shellcode2/colors.dart';
import 'package:shellcode2/detailServiceList.dart';
import 'package:shellcode2/home.dart';
import 'package:shellcode2/Bottom%20bar%20pages/wishlist.dart';
class Category extends StatelessWidget {
  const Category({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
        title: Text('Category',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 18,
            color: Colors.white,
          ),),

      ),
      body: Container(
        color: bgcolor,
        child: Padding(
            padding: EdgeInsets.only(top: 18,bottom: 18),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  for(int i=0; i<category.length; i++) ...{
                    Container(
                      padding: EdgeInsets.only(left: 15.0,top: 10.0),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(30),
                          onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(i)));
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.all(10),
                                height: 80,
                                width: 80,
                                child: Image.asset(category[i].imageUrl, fit: BoxFit.cover,),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0,bottom: 8.0,left: 18.0),
                                child: Text(category[i].title,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    color: Colors.purple,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                    ),
                  },
                ]
            )
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
  String imageUrl;
  String title;
  //String classTitle;
  Categories({
    required this.imageUrl,
    required this.title,
  });
}

List<Categories> category =[
  Categories(imageUrl: 'assets/bg.jpg', title: 'Fresh Vegetables & fruit' ),
  Categories(imageUrl: 'assets/bg.jpg', title: 'Grocery & Staples'),
  Categories(imageUrl: 'assets/bg.jpg', title: 'Dairy'),
  Categories(imageUrl: 'assets/bg.jpg', title: 'Bakery & Confectionery'),

];