import 'dart:convert';

import 'package:provider/provider.dart';
import 'package:shellcode2/Provider/data.dart';
import 'package:shellcode2/apiData/Constants.dart';
import 'package:shellcode2/productdetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shellcode2/colors.dart';
import 'package:shellcode2/apiData/BestSellingProducts.dart';
import 'package:http/http.dart' as http;

List<BestProductCategories> bestProductCategory = bestProductCategoryList;
int quantity = 1;

class BestSelling extends StatefulWidget {
  const BestSelling({Key key}) : super(key: key);

  @override
  _BestSellingState createState() => _BestSellingState();
}

class _BestSellingState extends State<BestSelling> {
  @override
  void dispose() {
    quantity = 1;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(bestProductCategory[0].data[0][0]);
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
          'Best Selling',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: lightbg,
          padding: EdgeInsets.all(8.0),
          child: Padding(
              padding: EdgeInsets.only(top: 18, bottom: 18),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (int i = 0; i < bestProductCategory.length; i++) ...{
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: bgcolor,
                            ),
                            padding: EdgeInsets.only(left: 15.0, top: 10.0),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(30),
                              onTap: () {
                                List temp1 = [
                                  bestProductCategory[i].imageUrl,
                                  bestProductCategory[i].title,
                                  bestProductCategory[i].weight,
                                  bestProductCategory[i].newrate,
                                  bestProductCategory[i].description,
                                  bestProductCategory[i].oldrate,
                                  bestProductCategory[i].data
                                ];
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ProductDetails(temp1, 0)));
                              },
                              child: SafeArea(
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.all(5),
                                        height: 80,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                5,
                                        child: Image.asset(
                                          bestProductCategory[i].imageUrl,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                3 /
                                                5,
                                        padding: const EdgeInsets.only(
                                            top: 8.0,
                                            bottom: 8.0,
                                            left: 8.0,
                                            right: 8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              '${bestProductCategory[i].title} ${bestProductCategory[i].weight}',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                                color: Colors.black,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              '₹ ${bestProductCategory[i].newrate}',
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
                                              onTap: () {
                                                _BottomSheet(context, i);
                                              },
                                              child: Container(
                                                  height: 25,
                                                  width: 200,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                    color: Colors.purple,
                                                  ),
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      "ADD",
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          color: Colors.white),
                                                    ),
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )),
                      ),
                      SizedBox(
                        height: 10,
                      )
                    },
                  ])),
        ),
      ),
    );
  }
}
//
// class Categories {
//   String imageUrl;
//   String weight;
//   String title;
//   double newrate;
//   double oldrate;
//   String description;
//   List<List> data;
//   Categories({
//     @required this.imageUrl,
//     @required this.title,
//     @required this.newrate,
//     @required this.oldrate,
//     @required this.weight,
//     @required this.description,
//     @required this.data,
//   });
// }

// List<Categories> category = [
//   Categories(
//       imageUrl: 'assets/bg.jpg',
//       description: ' ',
//       title: 'Cucumber',
//       oldrate: 5,
//       newrate: 10,
//       weight: '100 GM',
//       data: [
//         ['180 GM', 200, 197],
//         ['120 GM', 100, 157],
//         ['100 GM', 50, 100]
//       ]),
//   Categories(
//       imageUrl: 'assets/bg.jpg',
//       description: ' ',
//       title: 'Apple',
//       oldrate: 5,
//       newrate: 10,
//       weight: '100 GM',
//       data: [
//         ['180 GM', 200, 197]
//       ]),
//   Categories(
//       imageUrl: 'assets/bg.jpg',
//       description: ' ',
//       title: 'Cheese',
//       oldrate: 5,
//       newrate: 10,
//       weight: '100 GM',
//       data: [
//         ['180 GM', 200, 197],
//         ['120 GM', 100, 157]
//       ]),
//   Categories(
//       imageUrl: 'assets/bg.jpg',
//       description: ' ',
//       title: 'Orange',
//       oldrate: 5,
//       newrate: 10,
//       weight: '100 GM',
//       data: [
//         ['180 GM', 200, 197],
//         ['120 GM', 100, 157],
//         ['100 GM', 50, 100]
//       ]),
// ];

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
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * .40,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.all(10),
              height: MediaQuery.of(context).size.height * 0.20,
              width: MediaQuery.of(context).size.width / 4,
              child: Image.asset(
                bestProductCategory[j].imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 3 / 5,
              padding: const EdgeInsets.only(
                  top: 8.0, bottom: 8.0, left: 10.0, right: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    bestProductCategory[j].title,
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
                            colors: [left, middle, Colors.purple])),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '${bestProductCategory[j].description}',
                        style: TextStyle(
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
                  Text(
                    'Selling MRP: ₹ ${bestProductCategory[j].newrate}',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '[Inclusive Of all taxes]',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Colors.blueGrey,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  CustomStepper(
                    lowerLimit: 1,
                    upperLimit: 10,
                    value: quantity,
                    stepValue: 1,
                    iconSize: 10,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  GestureDetector(
                    onTap: () async {
                      print("Tapped");
                      bool added =
                          await addProductToCartbestSelling(context, j);
                      if (added) {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  content: Text(
                                      "Product successfully added to cart"),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      BestSelling()));
                                        },
                                        child: Text("OK")),
                                  ],
                                ),
                            barrierDismissible: false);
                      } else {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  content: Text("Something Went Wrong"),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      BestSelling()));
                                        },
                                        child: Text("OK")),
                                  ],
                                ),
                            barrierDismissible: false);
                      }
                    },
                    child: Container(
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
                              colors: [left, middle, Colors.purple])),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'ADD TO CART',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Colors.white,
                          ),
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

Future<bool> addProductToCartbestSelling(BuildContext context, int j) async {
  http.Response response;
  String userId =
      Provider.of<UserAccountDetails>(context, listen: false).user.id;
  String productId = bestProductCategory[j].data[0][0];
  String Quantity = quantity.toString();
  String unitPrice = bestProductCategory[j].newrate.toString() == ""
      ? bestProductCategory[j].oldrate.toString()
      : bestProductCategory[j].newrate.toString();
  String weight =
      "${bestProductCategory[j].weight} ${bestProductCategory[j].data[0][4]}";
  String unit = bestProductCategory[j].data[0][4];
  String originalPrice = bestProductCategory[j].oldrate.toString();
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
      height: 35,
      width: 80,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.purple, width: 1.5),
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
                color: Colors.purple,
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
