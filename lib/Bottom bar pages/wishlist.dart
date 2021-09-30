import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shellcode2/Bottom%20bar%20pages/categories.dart';
import 'package:shellcode2/Provider/data.dart';
import 'package:shellcode2/apiData/Constants.dart';
import 'package:shellcode2/apiData/getAllMainCategoryApi.dart';
import 'package:shellcode2/apiData/getUserFav.dart';
import 'package:shellcode2/cart.dart';
import 'package:shellcode2/colors.dart';
import 'package:shellcode2/detailServiceList.dart';
import 'package:shellcode2/home.dart';
import 'package:shellcode2/apiData/getUserFav.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;

const String _heroAddTodo = 'add-todo-hero';

class Wishlist extends StatefulWidget {
  const Wishlist({Key key}) : super(key: key);

  @override
  _WishlistState createState() => _WishlistState();
}

List<UserFavProductCategories> details = [];
List<UserFavProductCategories> detailByCategory = [];

class _WishlistState extends State<Wishlist> {
  List<String> categories = [
    'All',
    'Fresh Vegetables & fruit',
    'Grocery & Staples',
    'Dairy',
    'Bakery & Confectionery',
    'Pooja'
  ];

  void initState() {
    super.initState();
    fetchGetUserFav(Provider.of<APIData>(context, listen: false).userId);
    details = userFavProductList;
    print(details.length);
    // detailByCategory = details;
  }

  Future<bool> addProductToCart(String productid, String unitprice,
      String Weight, String Unit, String OriginalPrice) async {
    http.Response response;
    String userId = Provider.of<APIData>(context, listen: false).user.id;
    String productId = productid;
    print(productId);
    String Quantity = "1";
    String unitPrice = unitprice;
    print(unitPrice);
    String weight = Weight;
    print(weight);
    String unit = Unit;
    print(unit);
    String originalPrice = OriginalPrice;
    print(originalPrice);
    String orderNumber = '';
    String url =
        "$header/app_api/addtocart_order.php?user_id=$userId&product_id=$productId&quantity=$Quantity&unit_price=$unitPrice&weight=$weight&unit=$unit&unit_original_price=$originalPrice&order_number=$orderNumber";
    print(url);
    Uri uri = Uri.parse(url);
    response = await http.get(uri);
    print(response);
    var jsonData = jsonDecode(response.body);
    bool added = false;
    if (jsonData["code"] == "200") {
      added = true;
    } else {
      added = false;
    }
    return added;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightbg,
      appBar: AppBar(
        toolbarHeight: 45,
        centerTitle: true,
        titleSpacing: 0.0,
        elevation: 0,
        automaticallyImplyLeading: false,
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
        //brightness: Brightness.light,
        flexibleSpace: Container(
          color: left,
        ),
        title: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            'Wishlist',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              height: 50,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) =>
                      choiceChipWidget(categories)),
            ),
            Consumer<APIData>(
              builder: (context, data, child) {
                return Expanded(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    child: new ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: data.detailsByCategory.length,
                        physics: ClampingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.all(10),
                            width: 150,
                            color: bgcolor,
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    data.detailsByCategory[index].discount != 0
                                        ? Container(
                                            height: 28,
                                            decoration: BoxDecoration(
                                                border: Border(
                                                  top: BorderSide(
                                                      width: 1.0,
                                                      color: yellow),
                                                  left: BorderSide(
                                                      width: 1.0,
                                                      color: yellow),
                                                  right: BorderSide(
                                                      width: 1.0,
                                                      color: yellow),
                                                  bottom: BorderSide(
                                                      width: 1.0,
                                                      color: yellow),
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                                gradient: LinearGradient(
                                                    colors: [
                                                      left,
                                                      middle,
                                                      Colors.purple
                                                    ])),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    '₹  ${data.detailsByCategory[index].discount} OFF',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14,
                                                      color: Colors.white,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        : Container(
                                            height: 0,
                                            width: 0,
                                          ),
                                    IconButton(
                                        onPressed: null,
                                        icon: Icon(
                                          CupertinoIcons.clear_circled_solid,
                                          color: Colors.white.withOpacity(0.5),
                                        ))
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              "http://uprank.live/farmerskart/images/product/${data.detailsByCategory[index].imageURL}",
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover,
                                                  colorFilter: ColorFilter.mode(
                                                      Colors.transparent,
                                                      BlendMode.colorBurn)),
                                            ),
                                          ),
                                          placeholder: (context, url) =>
                                              CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 250,
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data.detailsByCategory[index].title,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                              color: Colors.purple,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          GestureDetector(
                                            // borderRadius: BorderRadius.circular(20),
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  HeroDialogRoute(
                                                      builder: (context) {
                                                        return _AddTodoPopupCard(
                                                            index);
                                                      },
                                                      settings:
                                                          ModalRoute.of(context)
                                                              .settings));
                                            },
                                            child: Hero(
                                              tag: _heroAddTodo,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  border: Border(
                                                    top: BorderSide(
                                                        width: 1.0,
                                                        color: Colors
                                                            .deepPurpleAccent),
                                                    left: BorderSide(
                                                        width: 1.0,
                                                        color: Colors
                                                            .deepPurpleAccent),
                                                    right: BorderSide(
                                                        width: 1.0,
                                                        color: Colors
                                                            .deepPurpleAccent),
                                                    bottom: BorderSide(
                                                        width: 1.0,
                                                        color: Colors
                                                            .deepPurpleAccent),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      ' ${data.detailsByCategory[index].weight[0][0]}',
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: yellow,
                                                        fontWeight:
                                                            FontWeight.w700,
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
                                            height: 10,
                                          ),
                                          Text(
                                            "₹  ${data.detailsByCategory[index].rate}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                              color: Colors.purple,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: ElevatedButton(
                                              onPressed: () async {
                                                String discountPrice = "";
                                                if (data
                                                        .detailsByCategory[
                                                            index]
                                                        .discountPrice !=
                                                    "") {
                                                  discountPrice = data
                                                      .detailsByCategory[index]
                                                      .discountPrice;
                                                } else {
                                                  discountPrice = data
                                                      .detailsByCategory[index]
                                                      .originalPrice;
                                                }
                                                bool added =
                                                    await addProductToCart(
                                                        data
                                                            .detailsByCategory[
                                                                index]
                                                            .productId,
                                                        discountPrice,
                                                        data
                                                            .detailsByCategory[
                                                                index]
                                                            .weight[0][0],
                                                        data
                                                            .detailsByCategory[
                                                                index]
                                                            .unit,
                                                        data
                                                            .detailsByCategory[
                                                                index]
                                                            .originalPrice);
                                                if (added) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                          content: Text(
                                                              "Product moved to cart")));
                                                } else {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                          content: Text(
                                                              "Something Went Wrong")));
                                                }
                                              },
                                              child: Text(
                                                'Move to Cart',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          Colors.purple[600]),
                                                  padding:
                                                      MaterialStateProperty.all(
                                                          EdgeInsets.symmetric(
                                                              vertical: 12,
                                                              horizontal: 20)),
                                                  textStyle:
                                                      MaterialStateProperty.all(
                                                          TextStyle(
                                                              fontSize: 14))),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          );
                        }),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Navigate(),
    );
  }
}

class Navigate extends StatefulWidget {
  const Navigate({Key key}) : super(key: key);

  @override
  _NavigateState createState() => _NavigateState();
}

class _NavigateState extends State<Navigate> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: lightbg,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.grey[300],
            //type: BottomNavigationBarType.fixed,
            selectedFontSize: 12,
            unselectedFontSize: 12,
            selectedItemColor: Colors.purple,
            unselectedItemColor: Colors.grey[500],
            showUnselectedLabels: true,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Home()));
                    },
                    child: Icon(Icons.home)),
                title: Text('Home'),
              ),
              BottomNavigationBarItem(
                icon: GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Category()));
                    },
                    child: Icon(Icons.list)),
                title: Text('Categories'),
              ),
              BottomNavigationBarItem(
                  icon: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Wishlist()));
                      },
                      child: Icon(CupertinoIcons.heart)),
                  title: Text('Wishlist')),
            ],
          ),
        ));
  }
}

class choiceChipWidget extends StatefulWidget {
  final List<String> reportList;

  choiceChipWidget(this.reportList);

  @override
  _choiceChipWidgetState createState() => new _choiceChipWidgetState();
}

class _choiceChipWidgetState extends State<choiceChipWidget> {
  String selectedChoice = "";

  _buildChoiceList() {
    print(widget.reportList);
    List<Widget> choices = [];

    widget.reportList.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(3.0),
        color: bgcolor,
        child: ChoiceChip(
          label: Text(item),
          labelStyle: TextStyle(
              color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.w400),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          backgroundColor: Colors.yellow[700].withOpacity(0.8),
          selectedColor: Colors.yellow[900],
          selected: selectedChoice == item,
          onSelected: (selected) {
            setState(() {
              selectedChoice = item;
              print(item);
              detailByCategory = [];
              print("Details.length ${details.length}");
              for (int i = 0; i < details.length; i++) {
                if (details[i].categoryName == item) {
                  detailByCategory.add(details[i]);
                } else if (selectedChoice == 'All') {
                  detailByCategory.add(details[i]);
                  print(details[i]);
                }
              }
              print(detailByCategory[0]);
              Provider.of<APIData>(context, listen: false)
                  .initialUserFavProductCategories(detailByCategory);
            });
          },
        ),
      ));
    });
    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}

int n = 0;

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

class _AddTodoPopupCard extends StatelessWidget {
  _AddTodoPopupCard(int s) {
    n = s;
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<APIData>(
      builder: (context, data, chid) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Hero(
              tag: _heroAddTodo,
              child: Material(
                color: lightbg,
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22)),
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
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Farmerskart - ${data.detailsByCategory[n].title}',
                            style: TextStyle(
                                height: 2,
                                color: Colors.purple,
                                fontSize: 18,
                                letterSpacing: 0.5,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        const Divider(
                          color: Colors.orange,
                          thickness: 0.8,
                        ),
                        for (int k = 0;
                            k < data.detailsByCategory[n].weight.length;
                            k++) ...{
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
                              padding: const EdgeInsets.only(
                                  left: 25.0, right: 85.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '${data.detailsByCategory[n].weight[k][0]} -',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Spacer(
                                    flex: 2,
                                  ),
                                  Text(
                                    '₹${data.detailsByCategory[n].weight[k][1]}',
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
                                  Text(
                                    '₹${data.detailsByCategory[n].weight[k][2]}',
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
      },
    );
  }
}
