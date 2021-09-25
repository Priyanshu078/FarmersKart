import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shellcode2/More%20pages/bestSellingMore.dart';
import 'package:shellcode2/Provider/data.dart';
import 'package:shellcode2/apiData/Constants.dart';
import 'package:shellcode2/cart.dart';
import 'package:shellcode2/colors.dart';
import 'package:shellcode2/detailServiceList.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';

class ProductDetails extends StatefulWidget {
  List temporary = [];
  int k = 0;
  bool offers = false;
  bool discountAvailable = false;
  bool category = false;
  // ProductDetails(List cat,int j){
  // this.temporary = cat;
  // this.k = j;
  //}
  ProductDetails(this.temporary, this.k);
  ProductDetails.offers(this.temporary, this.k, this.offers,this.discountAvailable);
  ProductDetails.search(
      this.temporary, this.k, this.offers, this.discountAvailable);
  ProductDetails.category(this.temporary, this.k, this.category);
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

List temp = [];

class _ProductDetailsState extends State<ProductDetails> {
  int j = 0;
  void te() {
    j = widget.k;
    temp = List.from(widget.temporary);
  }

  @override
  void initState() {
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
    print(temp);
    Provider.of<APIData>(context, listen: false).initializeIndex(0);
    Provider.of<APIData>(context, listen: false).initializeQuantity(1);
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
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Cart()));
              },
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
                          : Container(
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
                                child: Consumer<APIData>(
                                  builder: (context, data,child) {
                                    return Text(
                                      '₹ ${temp[6][data.index].discount} OFF',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        color: Colors.white,
                                      ),
                                    );
                                  }
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
                          child: CachedNetworkImage(
                            imageUrl:
                                "http://uprank.live/farmerskart/images/product/${temp[0]}",
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                    colorFilter: ColorFilter.mode(
                                        Colors.transparent,
                                        BlendMode.colorBurn)),
                              ),
                            ),
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
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Product MRP: ₹ ',
                            style: TextStyle(
                                color: yellow,
                                fontWeight: FontWeight.w500,
                                fontSize: 14),
                          ),
                          Consumer<APIData>(
    builder: (context,data,child){
                            return Text(
                              '${temp[6][data.index].originalPrice}',
                              style: TextStyle(
                                color: yellow,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                decoration: TextDecoration.lineThrough,
                              ),
                            );
  }
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
                  widget.offers
                      ? Consumer<APIData>(
                          builder: (context, data, child) {
                            print(data.quantity);
                            return widget.discountAvailable
                                ? Text(
                                    '${double.parse(temp[6][data.index].discountedPrice) * data.quantity}',
                                    style: TextStyle(
                                        color: Colors.deepPurple[800],
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14),
                                  )
                                : Text(
                                    '${double.parse(temp[6][data.index].originalPrice) * data.quantity}',
                                    style: TextStyle(
                                        color: Colors.deepPurple[800],
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14),
                                  );
                          },
                        )
                      : Consumer<APIData>(
                          builder: (context, data, child) {
                            print(data.quantity);
                            return Text(
                              '${double.parse(temp[6][data.index][3] == ""? temp[6][data.index][2]:temp[6][data.index][3]) * data.quantity}',
                              style: TextStyle(
                                  color: Colors.deepPurple[800],
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14),
                            );
                          },
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
                  showDialog(context: context, builder: (context) => weightList(context, widget.offers, widget.category));
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
                            ? Consumer<APIData>(
                          builder:(context,data,child) {
                            return Text(
                              '${temp[6][data.index].weight} ${temp[6][data.index].unit}',
                              style: TextStyle(
                                fontSize: 14,
                                color: yellow,
                                fontWeight: FontWeight.w700,
                              ),
                            );

                          }
                            )
                            : widget.category
                                ? Text(
                                    '${temp[6][0][0]}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: yellow,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  )
                                : Consumer<APIData>(
                builder: (context, data, child) {
                  return Text(
                    '${temp[6][data.index][1]}',
                    style: TextStyle(
                      fontSize: 14,
                      color: yellow,
                      fontWeight: FontWeight.w700,
                    ),
                  );
                }
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
    print(temp);
    http.Response response;
    String userId = Provider.of<APIData>(context, listen: false).user.id;
    String productId = widget.offers ? temp[6][Provider.of<APIData>(context,listen:false).index].p_Id :widget.category ? temp[6][Provider.of<APIData>(context,listen:false).index][3]:temp[6][Provider.of<APIData>(context,listen:false).index][0];
    print(productId);
    String Quantity = quantity.toString();
    String unitPrice = widget.offers
        ? widget.discountAvailable
            ? temp[6][Provider.of<APIData>(context,listen:false).index].discountedPrice
            : temp[6][Provider.of<APIData>(context,listen:false).index].originalPrice
        : widget.category?
        temp[6][Provider.of<APIData>(context,listen:false).index][2] == ""?
            temp[6][Provider.of<APIData>(context,listen:false).index][1]
        :temp[6][Provider.of<APIData>(context,listen:false).index][2]
    :temp[6][Provider.of<APIData>(context,listen:false).index][3] == ""
            ? temp[6][Provider.of<APIData>(context,listen:false).index][2]
            : temp[6][Provider.of<APIData>(context,listen:false).index][3];
    print(unitPrice);
    String weight = widget.offers
        ? "${temp[6][Provider.of<APIData>(context,listen:false).index].weight} ${temp[6][Provider.of<APIData>(context,listen:false).index].unit}"
        : widget.category
    ?temp[6][Provider.of<APIData>(context,listen:false).index][0]
    :temp[6][Provider.of<APIData>(context,listen:false).index][1];
    print(weight);
    String unit = widget.offers ? temp[6][Provider.of<APIData>(context,listen:false).index].unit : widget.category?temp[6][Provider.of<APIData>(context,listen:false).index][4]: temp[6][Provider.of<APIData>(context,listen:false).index][4];
    print(unit);
    String originalPrice =
        widget.offers ? temp[6][Provider.of<APIData>(context,listen:false).index].originalPrice :widget.category?temp[6][Provider.of<APIData>(context,listen:false).index][1] :temp[6][Provider.of<APIData>(context,listen:false).index][2];
    print(originalPrice);
    String url =
        "$header/app_api/addToCart.php?user_id=$userId&product_id=$productId&quantity=$Quantity&unit_price=$unitPrice&weight=$weight&unit=$unit&unit_original_price=$originalPrice";
    print(url);
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

                    Provider.of<APIData>(context, listen: false)
                        .initializeQuantity(quantity);
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
                    Provider.of<APIData>(context, listen: false)
                        .initializeQuantity(quantity);
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

  Widget weightList(BuildContext context, bool offers, bool category) {
    print(temp);
    return AlertDialog(
      content: Hero(
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
                    InkWell(
                      onTap: (){
                        Provider.of<APIData>(context, listen: false).initializeIndex(k);
                        Navigator.pop(context);
                      },
                    child: Container(
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
                            const EdgeInsets.only(left: 15.0, right: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            offers
                                ? Text(
                                    "${temp[6][k].weight} ${temp[6][k].unit}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  )
                                : !category
                                    ? Text(
                                        '${temp[6][k][1]} -',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                          color: Colors.white,
                                        ),
                                      )
                                    : Text(
                                        '${temp[6][k][0]} -',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                          color: Colors.white,
                                        ),
                                      ),
                            Spacer(
                              flex: 2,
                            ),
                            offers
                                ? Text(
                                    "₹${temp[6][k].originalPrice}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: Colors.white,
                                        decoration:
                                            TextDecoration.lineThrough),
                                  )
                                : category
                                    ? Text(
                                        '₹${temp[6][k][1]}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                          color: Colors.white,
                                          decoration:
                                              TextDecoration.lineThrough,
                                        ),
                                      )
                                    :
                            temp[6][k][3] == ""
                                ?Text(
          '₹${temp[6][k][2]}',
          style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          color: Colors.white,
          ),
          )
                            :Text(
                                        '₹${temp[6][k][2]}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                          color: Colors.white,
                                          decoration:
                                              TextDecoration.lineThrough,
                                        ),
                                      ),
                            Spacer(
                              flex: 2,
                            ),
                            offers
                                ? temp[6][k].discountedPrice == ""
                                    ? Container()
                                    : Text(
                                        "${temp[6][k].discountedPrice}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                          color: Colors.white,
                                        ),
                                      )
                                : category
                                    ? Text(
                                        '₹${temp[6][0][2]}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                          color: Colors.white,
                                        ),
                                      )
                                    : temp[6][k][3] == ""
                                ? Container()
                            :Text(
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
    );
  }
