import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shellcode2/More%20pages/bestSellingMore.dart';
import 'package:shellcode2/Provider/data.dart';
import 'package:shellcode2/apiData/Constants.dart';
import 'package:shellcode2/colors.dart';
import 'package:shellcode2/detailServiceList.dart';
import 'package:http/http.dart' as http;

class ProductDetails extends StatefulWidget {
  List temporary = [];
  int k = 0;
  bool offers = false;
  // ProductDetails(List cat,int j){
  // this.temporary = cat;
  // this.k = j;
  //}
  ProductDetails(this.temporary, this.k);
  ProductDetails.offers(this.temporary, this.k, this.offers);
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

List temp = [];
int quantity = 1;

class _ProductDetailsState extends State<ProductDetails> {
  int j = 0;
  void te() {
    j = widget.k;
    temp = List.from(widget.temporary);
  }

  @override
  void initState() {
    print(temp);
    super.initState();
  }

  @override
  void dispose() {
    quantity = 1;
    super.dispose();
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
              gradient: LinearGradient(colors: [left, middle, Colors.purple])),
        ),
        actions: [
          IconButton(
              onPressed: null,
              icon: Icon(
                Icons.shopping_cart,
                color: yellow,
              ))
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, size: 20, color: yellow),
        ),
        title: Text(
          'Product Details',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding:
              EdgeInsets.only(left: 28.0, right: 28.0, top: 18.0, bottom: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: j == 0
                          ? null
                          : new Container(
                              height: 40,
                              width: 80,
                              padding: EdgeInsets.all(4.0),
                              decoration: BoxDecoration(
                                  border: Border(
                                    top: BorderSide(width: 1.0, color: yellow),
                                    left: BorderSide(width: 1.0, color: yellow),
                                    right:
                                        BorderSide(width: 1.0, color: yellow),
                                    bottom:
                                        BorderSide(width: 1.0, color: yellow),
                                  ),
                                  borderRadius: BorderRadius.circular(5.0),
                                  gradient: LinearGradient(
                                      colors: [left, middle, Colors.purple])),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  '₹ ${temp[7]} OFF',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                          padding: EdgeInsets.all(10.0),
                          height: 200,
                          width: 200,
                          child: Image.asset(
                            temp[0],
                            fit: BoxFit.cover,
                          )),
                    ),
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
              Text(
                temp[1],
                style: TextStyle(
                    color: Colors.deepPurple[800],
                    fontWeight: FontWeight.w600,
                    fontSize: 18),
              ),
              SizedBox(
                height: 10,
              ),
              new Align(
                alignment: Alignment.centerLeft,
                child: j == 0
                    ? null
                    : new Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Product MRP: ₹ ',
                            style: TextStyle(
                                color: yellow,
                                fontWeight: FontWeight.w500,
                                fontSize: 14),
                          ),
                          Text(
                            '${temp[5]}',
                            style: TextStyle(
                              color: yellow,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Selling MRP:',
                    style: TextStyle(
                        color: Colors.deepPurple[800],
                        fontWeight: FontWeight.w500,
                        fontSize: 14),
                  ),
                  Text(
                    ' ₹ ',
                    style: TextStyle(
                        color: Colors.blue[800],
                        fontWeight: FontWeight.w500,
                        fontSize: 14),
                  ),
                  Text(
                    '${temp[3]}',
                    style: TextStyle(
                        color: Colors.deepPurple[800],
                        fontWeight: FontWeight.w500,
                        fontSize: 14),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '[Inclusive Of all taxes]',
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 14),
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: CustomStepper(
                  lowerLimit: 1,
                  upperLimit: 10,
                  value: 1,
                  stepValue: 1,
                  iconSize: 20,
                ),
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
                    gradient:
                        LinearGradient(colors: [left, middle, Colors.purple])),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${temp[4]}',
                    style: TextStyle(
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
              Text(
                'Unit',
                style: TextStyle(
                    color: yellow, fontWeight: FontWeight.w400, fontSize: 16),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                // borderRadius: BorderRadius.circular(20),
                onTap: () {
                  Navigator.of(context).push(HeroDialogRoute(
                      builder: (context) {
                        return _AddTodoPopupCard(widget.offers);
                      },
                      settings: ModalRoute.of(context).settings));
                },
                child: Hero(
                  tag: _heroAddTodo,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(width: 1.0, color: Colors.purple),
                        left: BorderSide(width: 1.0, color: Colors.purple),
                        right: BorderSide(width: 1.0, color: Colors.purple),
                        bottom: BorderSide(width: 1.0, color: Colors.purple),
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        widget.offers
                            ? Text(
                                '${temp[6][0].weight} ${temp[6][0].unit}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: yellow,
                                  fontWeight: FontWeight.w700,
                                ),
                              )
                            : Text(
                                '${temp[6][0][1]}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: yellow,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                        Icon(
                          Icons.keyboard_arrow_down,
                          color: yellow,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () async {
                  bool added = await addProductToCart();
                  if (added) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Product Successfully added to cart")));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Something Went Wrong")));
                  }
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
                          colors: [left, middle, Colors.purple])),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'ADD TO CART',
                      style: TextStyle(
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
      ),
    );
  }

  Future<bool> addProductToCart() async {
    http.Response response;
    String userId =
        Provider.of<UserAccountDetails>(context, listen: false).user.id;
    String productId = widget.offers ? temp[6][0].p_Id : temp[6][0][0];
    print(productId);
    String Quantity = quantity.toString();
    print(Quantity);
    String unitPrice = widget.offers
        ? temp[6][0].discountedPrice
        : temp[6][0][3] == ""
            ? temp[6][0][2]
            : temp[6][0][3];
    print(unitPrice);
    String weight = widget.offers
        ? "${temp[6][0].weight} ${temp[6][0].unit}"
        : temp[6][0][1];
    print(weight);
    String unit = widget.offers ? temp[6][0].unit : temp[6][0][4];
    print(unit);
    String originalPrice =
        widget.offers ? temp[6][0].originalPrice : temp[6][0][2];
    print(originalPrice);
    String url =
        "$header/app_api/addToCart.php?user_id=$userId&product_id=$productId&quantity=$Quantity&unit_price=$unitPrice&weight=$weight&unit=$unit&unit_original_price=$originalPrice";
    Uri uri = Uri.parse(url);
    response = await http.get(uri);
    var jsonData = jsonDecode(response.body);
    bool added = false;
    if (jsonData["code"] == "200") {
      added = true;
    } else {
      added = false;
    }
    return added;
  }
}

class CustomStepper extends StatefulWidget {
  CustomStepper({
    @required this.lowerLimit,
    @required this.upperLimit,
    @required this.stepValue,
    @required this.iconSize,
    @required this.value,
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
          border: Border.all(color: Colors.purple),
          borderRadius: BorderRadius.circular(5)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 1,
            child: GestureDetector(
              child: Icon(
                Icons.remove,
                color: Colors.deepPurple,
                size: widget.iconSize,
              ),
              onTap: () {
                setState(
                  () {
                    widget.value = quantity == widget.lowerLimit
                        ? widget.lowerLimit
                        : quantity -= widget.stepValue;
                  },
                );
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                  gradient:
                      LinearGradient(colors: [left, middle, Colors.purple])),
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
              child: Icon(
                Icons.add,
                color: Colors.greenAccent,
                size: widget.iconSize,
              ),
              onTap: () {
                setState(
                  () {
                    widget.value = quantity == widget.upperLimit
                        ? widget.upperLimit
                        : quantity += widget.stepValue;
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
    @required WidgetBuilder builder,
    @required RouteSettings settings,
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

class _AddTodoPopupCard extends StatefulWidget {
  bool offers;
  _AddTodoPopupCard(this.offers);
  @override
  __AddTodoPopupCardState createState() => __AddTodoPopupCardState();
}

class __AddTodoPopupCardState extends State<_AddTodoPopupCard> {
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
                          color: Colors.purple,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'Farmerskart - ${temp[1]}',
                      style: TextStyle(
                          height: 2,
                          color: Colors.purple,
                          fontSize: 18,
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.w700),
                    ),
                    const Divider(
                      color: Colors.orange,
                      thickness: 0.8,
                    ),
                    for (int k = 0; k < temp[6].length; k++) ...{
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
                                colors: [left, middle, Colors.purple])),
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 25.0, right: 85.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              widget.offers
                                  ? Text(
                                      "${temp[6][k].weight} ${temp[6][k].unit}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                    )
                                  : Text(
                                      '${temp[6][k][1]} -',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                              Spacer(
                                flex: 2,
                              ),
                              widget.offers
                                  ? Text(
                                      "${temp[6][k].originalPrice}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                          color: Colors.white,
                                          decoration:
                                              TextDecoration.lineThrough),
                                    )
                                  : Text(
                                      '₹${temp[6][k][2]}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: Colors.white,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                              Spacer(
                                flex: 2,
                              ),
                              widget.offers
                                  ? Text(
                                      "${temp[6][k].discountedPrice}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                    )
                                  : Text(
                                      '₹${temp[6][k][3]}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                    ),
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
