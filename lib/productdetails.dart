import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shellcode2/More%20pages/bestSellingMore.dart';
import 'package:shellcode2/colors.dart';
import 'package:shellcode2/detailServiceList.dart';

class ProductDetails extends StatefulWidget {
  List temporary=[];
  int k=0;
 // ProductDetails(List cat,int j){
   // this.temporary = cat;
   // this.k = j;
  //}
  ProductDetails(this.temporary,this.k);
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}
List temp=[];
class _ProductDetailsState extends State<ProductDetails> {

  int j=0;
  void te(){
   j = widget.k;
   temp=List.from(widget.temporary);
  }
  @override
  Widget build(BuildContext context) {
    te();
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
        title: Text('Product Details',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 18,
            color: Colors.white,
          ),),

      ),
      body: Container(
        padding: EdgeInsets.only(left: 28.0,right: 28.0,top: 18.0,bottom: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  Align(
                    alignment: Alignment.topLeft,
                    child: j == 0 ? null : new Container(
                      height: 60,
                      width: 50,
                      padding: EdgeInsets.all(4.0),
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
                        alignment: Alignment.centerRight,
                        child: Text('₹ ${temp[7]} OFF', style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: Colors.white,
                        ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                  padding: EdgeInsets.all(10.0),
                  height: 200,
                    width: 200,
                    child: Image.asset(temp[0],fit: BoxFit.cover,)),
              ],
              ),
            ),
            const Divider(
              color: Colors.grey,
              thickness: 0.5,
            ),
            SizedBox(
              height: 10,
            ),
            Text(temp[1],
            style: TextStyle(
              color: Colors.deepPurpleAccent[100],
              fontWeight: FontWeight.w600,
              fontSize: 18
            ),),
            SizedBox(
              height: 10,
            ),
            new Align(
              alignment: Alignment.centerLeft,
              child: j == 0 ? null : new Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Product MRP: ₹ ',
                    style: TextStyle(
                        color: yellow,
                        fontWeight: FontWeight.w500,
                        fontSize: 14
                    ),),
                  Text('${temp[3]}',
                    style: TextStyle(

                      color: yellow,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      decoration: TextDecoration. lineThrough,
                    ),),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Selling MRP:',
                  style: TextStyle(
                      color: Colors.deepPurpleAccent[100],
                      fontWeight: FontWeight.w500,
                      fontSize: 14
                  ),),
                Text(' ₹ ',
                  style: TextStyle(
                      color: Colors.blue[800],
                      fontWeight: FontWeight.w500,
                      fontSize: 14
                  ),),
                Text('${temp[3]}',
                  style: TextStyle(
                      color: Colors.deepPurpleAccent[100],
                      fontWeight: FontWeight.w500,
                      fontSize: 14
                  ),),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text('[Inclusive Of all taxes]',
              style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                  fontSize: 14
              ),),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerRight,
              child:  CustomStepper(lowerLimit: 1,upperLimit: 10,value: 1,stepValue: 1,iconSize: 10,),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 25,
              width: MediaQuery.of(context).size.width,
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
                child: Text('${temp[4]}', style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: Colors.white,
                ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            const Divider(
              color: Colors.grey,
              thickness: 0.5,
            ),
            SizedBox(
              height: 10,
            ),
            Text('Unit',
              style: TextStyle(
                  color: yellow,
                  fontWeight: FontWeight.w400,
                  fontSize: 16
              ),),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              // borderRadius: BorderRadius.circular(20),
              onTap: (){
                Navigator.of(context).push(HeroDialogRoute(builder: (context) {
                  return _AddTodoPopupCard();
                }, settings:  ModalRoute.of(context)!.settings));
              },
              child: Hero(
                tag: _heroAddTodo,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(width: 1.0, color: Colors.purpleAccent),
                      left: BorderSide(width: 1.0, color: Colors.purpleAccent),
                      right: BorderSide(width: 1.0, color: Colors.purpleAccent),
                      bottom: BorderSide(width: 1.0, color: Colors.purpleAccent),
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(' ₹ ${temp[2]}', style: TextStyle(
                        fontSize: 14,
                        color: yellow,
                        fontWeight: FontWeight.w700,
                      ),
                      ),
                      Icon(Icons.keyboard_arrow_down,color: yellow,)
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: (){

              },
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
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
                    fontSize: 12,
                    color: Colors.white,
                  ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
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
      height: 40,
      width: 150,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.purpleAccent),
          borderRadius: BorderRadius.circular(5)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 1,
            child: GestureDetector(
              child: Icon(Icons.remove,
                color: Colors.deepPurpleAccent[100],
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
                color: Colors.greenAccent,
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

const String _heroAddTodo = 'add-todo-hero';
class HeroDialogRoute<T> extends PageRoute<T> {
  /// {@macro hero_dialog_route}
  HeroDialogRoute({
    required WidgetBuilder builder,
    required RouteSettings settings,
    bool fullscreenDialog = false,
  })  : _builder = builder,
        super(settings: settings, fullscreenDialog: fullscreenDialog);

  final WidgetBuilder _builder;

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  bool get maintainState => true;

  @override
  Color get barrierColor => Colors.black54;

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return child;
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return _builder(context);
  }

  @override
  String get barrierLabel => 'Popup dialog open';
}
class _AddTodoPopupCard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Hero(
          tag: _heroAddTodo,
          child: Material(
            color: lightbg,
            elevation: 2,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Available quantities for',
                      style: TextStyle(
                          color: Colors.purpleAccent,
                          fontSize: 14,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                    Text(
                      'Farmerskart - ${temp[1]}',
                      style: TextStyle(
                          height: 2,
                          color: Colors.purpleAccent,
                          fontSize: 18,
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.w700
                      ),
                    ),
                    const Divider(
                      color: Colors.orange,
                      thickness: 0.8,
                    ),
                    for(int k=0; k<temp[6].length; k++) ...{
                      Container(
                        height: 35,
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
                        child: Padding(
                          padding: const EdgeInsets.only(left: 25.0,right: 85.0),
                          child:
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('${temp[6][k][0]} -', style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Colors.white,
                              ),
                              ),
                              Spacer(flex: 2,),
                              Text('₹${temp[6][k][1]}', style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Colors.white,
                                decoration: TextDecoration. lineThrough,
                              ),
                              ),
                              Spacer(flex: 2,),
                              Text('₹${temp[6][k][2]}', style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Colors.white,
                              ),),

                            ],
                          ),
                        ),
                      ),
                      const Divider(
                        color: Colors.white,
                        thickness: 0.2,
                      ),
                    },
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
