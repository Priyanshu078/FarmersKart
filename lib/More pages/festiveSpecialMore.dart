import 'package:shellcode2/productdetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shellcode2/colors.dart';

class FestiveSpecial extends StatefulWidget {
  const FestiveSpecial({Key? key}) : super(key: key);

  @override
  _FestiveSpecialState createState() => _FestiveSpecialState();
}

class _FestiveSpecialState extends State<FestiveSpecial> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
        actions: [
          IconButton(
              onPressed: null,
              icon: Icon(
                Icons.shopping_cart,
                color: yellow,
              )
          )
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios,
              size: 20,
              color: yellow),
        ),
        title: Text('Festive Special',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 18,
            color: Colors.white,
          ),),

      ),
      body: SingleChildScrollView(
        child: Container(
          color: lightbg,
          padding: EdgeInsets.all(8.0),
          child: Padding(
              padding: EdgeInsets.only(top: 18,bottom: 18),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    for(int i=0; i<category.length; i++) ...{
                      GestureDetector(
                        onTap: (){

                        },
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: bgcolor,
                            ),
                            padding: EdgeInsets.only(left: 15.0,top: 10.0),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(30),
                              onTap: (){
                                List temp1 = [category[i].imageUrl,category[i].title,category[i].weight,category[i].newrate,category[i].description,category[i].oldrate,category[i].data];
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetails(temp1,0)));
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    height: 80,
                                    width: 80,
                                    child: Image.asset(category[i].imageUrl, fit: BoxFit.cover,),
                                  ),
                                  Container(
                                    width: 250,
                                    padding: const EdgeInsets.only(top: 8.0,bottom: 8.0,left: 18.0,right: 18.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children:[
                                        Text('${category[i].title} ${category[i].weight}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text('₹ ${category[i].newrate}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        GestureDetector(
                                          onTap: (){
                                            _BottomSheet(context,i);
                                          },
                                          child: Container(
                                              height: 25,
                                              width: 200,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5.0),
                                                color: Colors.purple,
                                              ),
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  "ADD",
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.white
                                                  ),
                                                ),
                                              )
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      )
                    },
                  ]
              )
          ),
        ),
      ),
    );
  }
}


class Categories{
  String imageUrl;
  String weight;
  String title;
  double newrate;
  double oldrate;
  String description;
  List<List> data;
  Categories({
    required this.imageUrl,
    required this.title,
    required this.newrate,
    required this.oldrate,
    required this.weight,
    required this.description,
    required this.data,
  });
}

List<Categories> category =[
  Categories(imageUrl: 'assets/bg.jpg',description:' ', title: 'Cucumber',oldrate: 5,newrate: 10,weight: '100 GM',data: [['180 GM',200,197],['120 GM',100,157],['100 GM',50,100]]),
  Categories(imageUrl: 'assets/bg.jpg',description:' ', title: 'Apple',oldrate: 5,newrate: 10,weight: '100 GM',data: [['180 GM',200,197]]  ),
  Categories(imageUrl: 'assets/bg.jpg',description:' ', title: 'Cheese',oldrate: 5,newrate: 10 ,weight: '100 GM',data: [['180 GM',200,197],['120 GM',100,157]] ),
  Categories(imageUrl: 'assets/bg.jpg',description:' ', title: 'Orange',oldrate: 5,newrate: 10,weight: '100 GM',data: [['180 GM',200,197],['120 GM',100,157],['100 GM',50,100]]  ),

];

void _BottomSheet(context, int j) {
  showModalBottomSheet(
    context: context,
    backgroundColor: lightbg,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(28.0)),
    ),
    builder: (BuildContext bc) {
      return Container(
        padding: EdgeInsets.all(8.0),
        height: MediaQuery.of(context).size.height * .30,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.all(10),
              height: 80,
              width: 80,
              child: Image.asset(category[j].imageUrl, fit: BoxFit.cover,),
            ),
            Container(
              width: 250,
              padding: const EdgeInsets.only(top: 8.0,bottom: 8.0,left: 18.0,right: 18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  Text(category[j].title,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Colors.purple,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 25,
                    width: 200,
                    decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(width: 1.0, color: yellow),
                          left: BorderSide(width: 1.0, color: yellow),
                          right: BorderSide(width: 1.0, color: yellow),
                          bottom: BorderSide(width: 1.0, color: yellow),
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                        gradient: LinearGradient(
                            colors: [left,middle,Colors.purple]
                        )
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('${category[j].description}', style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: Colors.white,
                      ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text('Selling MRP: ₹ ${category[j].newrate}',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text('[Inclusive Of all taxes]',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Colors.blueGrey,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  CustomStepper(lowerLimit: 1,upperLimit: 10,value: 1,stepValue: 1,iconSize: 10,),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    height: 38,
                    width: 200,
                    decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(width: 1.0, color: yellow),
                          left: BorderSide(width: 1.0, color: yellow),
                          right: BorderSide(width: 1.0, color: yellow),
                          bottom: BorderSide(width: 1.0, color: yellow),
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                        gradient: LinearGradient(
                            colors: [left,middle,Colors.purple]
                        )
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text('ADD TO CART', style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Colors.white,
                      ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}


class CustomStepper extends StatefulWidget {
  CustomStepper({
    required this.lowerLimit,
    required this.upperLimit,
    required this.stepValue,
    required this.iconSize,
    required this.value,
  });

  final int lowerLimit;
  final int upperLimit;
  final int stepValue;
  final double iconSize;
  int value;

  @override
  _CustomStepperState createState() => _CustomStepperState();
}
class _CustomStepperState extends State<CustomStepper> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: 80,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.purple,width: 1.5),
          borderRadius: BorderRadius.circular(5)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 1,
            child: GestureDetector(
              child: Icon(Icons.remove,
                color: Colors.deepPurple,
                size: widget.iconSize,
              ),
              onTap: () {
                setState(() {
                  widget.value =
                  widget.value == widget.lowerLimit ? widget.lowerLimit : widget
                      .value -= widget.stepValue;
                },);},
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [left,middle,Colors.purple]
                  )
              ),
              width: widget.iconSize,
              child: Center(
                child: FittedBox(
                  child: Text(
                    '${widget.value}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: GestureDetector(
              child: Icon(Icons.add,
                color: Colors.deepPurple,
                size: widget.iconSize,
              ),
              onTap: () {
                setState(() {
                  widget.value =
                  widget.value == widget.upperLimit ? widget.upperLimit : widget.value += widget.stepValue;
                },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}