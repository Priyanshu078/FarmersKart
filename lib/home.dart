import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shellcode2/More%20pages/ImmunityMore.dart';
import 'package:shellcode2/More%20pages/bestSellingMore.dart';
import 'package:shellcode2/Bottom%20bar%20pages/categories.dart';
import 'package:shellcode2/Navigation%20Drawer%20pages/handyOrder.dart';
import 'package:shellcode2/Notifications.dart';
import 'package:shellcode2/apiData/CartProducts.dart';
import 'package:shellcode2/apiData/Constants.dart';
import 'package:shellcode2/apiData/OffersApiData.dart';
import 'package:shellcode2/apiData/allProducts.dart';
import 'package:shellcode2/apiData/festiveSpecial.dart';
import 'package:shellcode2/apiData/immunityBooster.dart';
import 'package:shellcode2/cart.dart';
import 'package:shellcode2/colors.dart';
import 'package:shellcode2/detailServiceList.dart';
import 'package:shellcode2/drawerscreen.dart';
import 'package:shellcode2/More%20pages/festiveSpecialMore.dart';
import 'package:shellcode2/More%20pages/newArrivalsmore.dart';
import 'package:shellcode2/More%20pages/offerMore.dart';
import 'package:shellcode2/productdetails.dart';
import 'package:shellcode2/Bottom%20bar%20pages/wishlist.dart';
import 'package:shellcode2/apiData/BestSellingProducts.dart';
import 'package:provider/provider.dart';
import 'package:shellcode2/Provider/data.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'apiData/BannerImagesAPI.dart';
import 'package:sqflite/sqflite.dart';

List<BestProductCategories> bestProductCategory = bestProductCategoryList;
List offerData = offersData;

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List allProducts = [];
  Data data = new Data();
  int _current = 0;
  List imgList = [];
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  final Permission _permission = Permission.location;

  PermissionStatus _permissionStatus = PermissionStatus.denied;
  Future<void> requestPermission(Permission permission) async {
    final status = await permission.request();

    setState(() {
      print(status);
      _permissionStatus = status;
      print(_permissionStatus);
    });
  }

  void initState() {
    super.initState();
    getAllProducts();
    getCartProducts(context);
    saveData();
    requestPermission(_permission);
    imgList = bannerImages;
    if (Provider.of<APIData>(context, listen: false).centerId == null) {
      Provider.of<APIData>(context, listen: false).initializeCenterId(
          Provider.of<APIData>(context, listen: false).user.centerId);
    }
    if (Provider.of<APIData>(context, listen: false).userId == null) {
      Provider.of<APIData>(context, listen: false).initializeUserId(
          Provider.of<APIData>(context, listen: false).user.id);
    }
  }

  String getUserType() {
    String userType =
        Provider.of<APIData>(context, listen: false).user.userType;
    return userType;
  }

  void saveData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List notifications = await getNotifications(context);
    int newCount = notifications.length;
    String key = "oldNotificationCount";
    print("notifications");
    print("notifications " + newCount.toString());
    bool CheckValue = preferences.containsKey(key);
    print(CheckValue);
    String oldCountData = await getNotificationCount(key) ?? '0';
    int oldCount = int.parse(oldCountData);
    print(oldCount);
    int newNotifications = newCount - oldCount;
    Provider.of<APIData>(context, listen: false)
        .initializeNewNotificationCount(newNotifications);
    setNotificationCount(key, newCount.toString());
    String oldCountDatanew = await getNotificationCount(key) ?? "0";
    print(oldCountDatanew);
  }

  Future setNotificationCount(String key, String data) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(key, data);
  }

  Future getNotificationCount(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(key);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        leadingWidth: MediaQuery.of(context).size.width / 5,
        title: Text('Farmers kart'),
        elevation: 0,
        iconTheme: IconThemeData(color: yellow),
        actions: [
          Stack(alignment: Alignment.topRight, children: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Cart()));
                },
                icon: Icon(
                  Icons.shopping_cart,
                  color: yellow,
                )),
            Consumer<APIData>(builder: (context, data, child) {
              return Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.purple[900]),
                height: 20,
                width: 20,
                child: Text("${data.cartProductCount}",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15)),
              );
            })
          ]),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Stack(alignment: Alignment.topRight, children: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Notifications()));
                  },
                  icon: Icon(
                    Icons.notifications,
                    color: yellow,
                  )),
              Consumer<APIData>(builder: (context, data, child) {
                return Flexible(
                  child: Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.purple[900]),
                    child: Text(
                      "${data.newNotification}",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                );
              })
            ]),
          ),
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [left, middle, Colors.purple])),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: bgcolor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 50,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [left, left, middle, right, Colors.purple])),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 18.0, right: 18.0, top: 8.0, bottom: 8.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(5),
                    color: bgcolor,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(30),
                      onTap: () {
                        // Navigator.of(context).push(MaterialPageRoute(
                        //   builder: (context) => Search(),
                        // ));
                        showSearch(
                            context: context,
                            delegate: SearchProducts(allProducts));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.search,
                                    color: yellow,
                                  ),
                                  Text('   '),
                                  Text(
                                    'Search',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.keyboard_voice_outlined,
                                  color: yellow,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.red,
                          ),
                          Text(
                            'Deliver to ',
                            style: TextStyle(color: Colors.green[800]),
                          ),
                          Text(
                            '${Provider.of<APIData>(context, listen: false).user.pincode}',
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 38,
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
                        child: InkWell(
                          borderRadius: BorderRadius.circular(30),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => HandyOrder(),
                            ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.list_alt,
                                  color: yellow,
                                  size: 18,
                                ),
                                Text('   '),
                                Text(
                                  'Go To Handy Order',
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
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Best Selling Product',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BestSelling()));
                              },
                              child: Text(
                                'more>',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.purple,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 115,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: bestProductCategory.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  print(bestProductCategory[index].imageUrl);
                                  List temp1 = [
                                    bestProductCategory[index].imageUrl,
                                    bestProductCategory[index].title,
                                    bestProductCategory[index].weight,
                                    bestProductCategory[index].newrate,
                                    bestProductCategory[index].description,
                                    bestProductCategory[index].oldrate,
                                    bestProductCategory[index].data
                                  ];
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ProductDetails(temp1, 0)));
                                },
                                child: Row(
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.all(10),
                                          height: 60,
                                          width: 60,
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                "http://uprank.live/farmerskart/images/product/${bestProductCategory[index].imageUrl}",
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    Container(
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.cover,
                                                    colorFilter:
                                                        ColorFilter.mode(
                                                            Colors.transparent,
                                                            BlendMode
                                                                .colorBurn)),
                                              ),
                                            ),
                                            placeholder: (context, url) =>
                                                CircularProgressIndicator(),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                          ),
                                        ),
                                        Text(
                                          bestProductCategory[index].title,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 10,
                                            color: Colors.purple,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      width: 20,
                                    )
                                  ],
                                ),
                              );
                            }),
                      ),
                      CarouselSlider(
                          items: imgList.map((imgUrl) {
                            print(imgList);
                            return Builder(
                              builder: (BuildContext context) {
                                return Container(
                                  width: double.maxFinite,
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 10.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.network(
                                      imgUrl,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              },
                            );
                          }).toList(),
                          options: CarouselOptions(
                            onPageChanged: (i, _) {
                              setState(() {
                                _current = i;
                              });
                            },
                            height: 150.0,
                            initialPage: 0,
                            autoPlay: true,
                            reverse: false,
                            enableInfiniteScroll: true,
                            autoPlayInterval: Duration(seconds: 5),
                            autoPlayAnimationDuration:
                                Duration(milliseconds: 2000),
                            pauseAutoPlayOnTouch: true,
                            scrollDirection: Axis.horizontal,
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: map<Widget>(imgList, (index, url) {
                          return Container(
                            width: 10.0,
                            height: 10.0,
                            margin: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 2.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _current == index
                                  ? Colors.purple
                                  : Colors.grey[200],
                            ),
                          );
                        }),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Offers',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => OfferMore()));
                              },
                              child: Text(
                                'more>',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.purple,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 240,
                        child: (getUserType() == 'Hotel' ||
                                getUserType() == 'Shop')
                            ? ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: offerData.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      List temp2 = [
                                        offerData[index].img,
                                        offerData[index].title,
                                        offerData[index].weight,
                                        offerData[index].newrate,
                                        offerData[index].description,
                                        offerData[index].oldrate,
                                        offerData[index].data,
                                        offerData[index].off
                                      ];
                                      print(offerData[index].img);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ProductDetails(temp2, 1)));
                                    },
                                    child: Container(
                                      margin: EdgeInsets.all(10),
                                      width: 150,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.all(10),
                                            height: 80,
                                            width: 80,
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  "http://uprank.live/farmerskart/images/product/${offerData[index].img}",
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                      Container(
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.cover,
                                                      colorFilter:
                                                          ColorFilter.mode(
                                                              Colors
                                                                  .transparent,
                                                              BlendMode
                                                                  .colorBurn)),
                                                ),
                                              ),
                                              placeholder: (context, url) =>
                                                  CircularProgressIndicator(),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Container(
                                                height: 20,
                                                width: 50,
                                                decoration: BoxDecoration(
                                                    border: Border(
                                                      top: BorderSide(
                                                          width: 0.5,
                                                          color: yellow),
                                                      left: BorderSide(
                                                          width: 0.5,
                                                          color: yellow),
                                                      right: BorderSide(
                                                          width: 0.5,
                                                          color: yellow),
                                                      bottom: BorderSide(
                                                          width: 0.5,
                                                          color: yellow),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                    gradient: LinearGradient(
                                                        colors: [
                                                          left,
                                                          middle,
                                                          Colors.purple
                                                        ])),
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    '₹ ${offerData[index].off} OFF',
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        color: Colors.white),
                                                  ),
                                                )),
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                            offerData[index].title,
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
                                            "₹  ${offerData[index].newrate}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                              height: 25,
                                              width: 130,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
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
                                        ],
                                      ),
                                    ),
                                  );
                                })
                            : ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: offerData.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      List temp2 = [
                                        offerData[index].img,
                                        offerData[index].name,
                                        offerData[index].productPrice[0].weight,
                                        offerData[index]
                                            .productPrice[0]
                                            .discountedPrice,
                                        offerData[index].description,
                                        offerData[index]
                                            .productPrice[0]
                                            .originalPrice,
                                        offerData[index].productPrice,
                                        offerData[index]
                                            .productPrice[0]
                                            .discount
                                      ];
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ProductDetails.offers(
                                                      temp2, 1, true, true)));
                                    },
                                    child: Container(
                                      margin: EdgeInsets.all(10),
                                      width: 150,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.all(10),
                                            height: 80,
                                            width: 80,
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  "http://uprank.live/farmerskart/images/product/${offerData[index].img}",
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                      Container(
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.cover,
                                                      colorFilter:
                                                          ColorFilter.mode(
                                                              Colors
                                                                  .transparent,
                                                              BlendMode
                                                                  .colorBurn)),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Container(
                                                height: 20,
                                                width: 50,
                                                decoration: BoxDecoration(
                                                    border: Border(
                                                      top: BorderSide(
                                                          width: 0.5,
                                                          color: yellow),
                                                      left: BorderSide(
                                                          width: 0.5,
                                                          color: yellow),
                                                      right: BorderSide(
                                                          width: 0.5,
                                                          color: yellow),
                                                      bottom: BorderSide(
                                                          width: 0.5,
                                                          color: yellow),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                    gradient: LinearGradient(
                                                        colors: [
                                                          left,
                                                          middle,
                                                          Colors.purple
                                                        ])),
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    '₹ ${offerData[index].productPrice[0].discount} OFF',
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        color: Colors.white),
                                                  ),
                                                )),
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                            offerData[index].name,
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
                                            "₹  ${offerData[index].productPrice[0].discountedPrice}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                              height: 25,
                                              width: 130,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
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
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'New Arrivals',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => NewArrivals()));
                              },
                              child: Text(
                                'more>',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.purple,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 220,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: festiveSpecialList.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  List temp1 = [
                                    festiveSpecialList[index].imageUrl,
                                    festiveSpecialList[index].title,
                                    festiveSpecialList[index].weight,
                                    festiveSpecialList[index].newrate,
                                    festiveSpecialList[index].description,
                                    festiveSpecialList[index].oldrate,
                                    festiveSpecialList[index].data
                                  ];
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ProductDetails(temp1, 0)));
                                },
                                child: Container(
                                  margin: EdgeInsets.all(10),
                                  width: 150,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.all(10),
                                        height: 80,
                                        width: 80,
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              "http://uprank.live/farmerskart/images/product/${festiveSpecialList[index].imageUrl}",
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
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        festiveSpecialList[index].title,
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
                                        "₹  ${festiveSpecialList[index].newrate}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                          height: 25,
                                          width: 130,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
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
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Categories',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Category()));
                              },
                              child: Text(
                                'more>',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.purple,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => DetailPage(
                                                    '1',
                                                    "Fresh Vegitables,Leafy Vegetables,Extotic Vegetables,Fruits,Peeled or Cut vegitables,Flower")));
                                      },
                                      child: Container(
                                        margin: EdgeInsets.all(10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.all(10),
                                              height: 100,
                                              width: 100,
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    "http://uprank.live/farmerskart/images/category/1625808379.png",
                                                imageBuilder:
                                                    (context, imageProvider) =>
                                                        Container(
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: imageProvider,
                                                        fit: BoxFit.cover,
                                                        colorFilter:
                                                            ColorFilter.mode(
                                                                Colors
                                                                    .transparent,
                                                                BlendMode
                                                                    .colorBurn)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            Container(
                                                height: 50,
                                                padding: EdgeInsets.all(5.0),
                                                decoration: BoxDecoration(
                                                    border: Border(
                                                      top: BorderSide(
                                                          width: 0.5,
                                                          color: yellow),
                                                      left: BorderSide(
                                                          width: 0.5,
                                                          color: yellow),
                                                      right: BorderSide(
                                                          width: 0.5,
                                                          color: yellow),
                                                      bottom: BorderSide(
                                                          width: 0.5,
                                                          color: yellow),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4.0),
                                                    gradient: LinearGradient(
                                                        colors: [
                                                          left,
                                                          middle,
                                                          Colors.purple
                                                        ])),
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    'Fresh Vegetables & fruit',
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.white),
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => DetailPage(
                                                    '2',
                                                    "Sauces & Mayos,Dips & Spreads")));
                                      },
                                      child: Container(
                                        margin: EdgeInsets.all(10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.all(10),
                                              height: 100,
                                              width: 100,
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    "http://uprank.live/farmerskart/images/category/1625808537.png",
                                                imageBuilder:
                                                    (context, imageProvider) =>
                                                        Container(
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: imageProvider,
                                                        fit: BoxFit.cover,
                                                        colorFilter:
                                                            ColorFilter.mode(
                                                                Colors
                                                                    .transparent,
                                                                BlendMode
                                                                    .colorBurn)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            Container(
                                                height: 50,
                                                padding: EdgeInsets.all(5.0),
                                                decoration: BoxDecoration(
                                                    border: Border(
                                                      top: BorderSide(
                                                          width: 0.5,
                                                          color: yellow),
                                                      left: BorderSide(
                                                          width: 0.5,
                                                          color: yellow),
                                                      right: BorderSide(
                                                          width: 0.5,
                                                          color: yellow),
                                                      bottom: BorderSide(
                                                          width: 0.5,
                                                          color: yellow),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4.0),
                                                    gradient: LinearGradient(
                                                        colors: [
                                                          left,
                                                          middle,
                                                          Colors.purple
                                                        ])),
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    'Grocery & Staples',
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.white),
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => DetailPage(
                                                    '4',
                                                    "Cheese,Butter,Paneer,Lassi,cream")));
                                      },
                                      child: Container(
                                        margin: EdgeInsets.all(10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.all(10),
                                              height: 100,
                                              width: 100,
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    "http://uprank.live/farmerskart/images/category/1625808959.png",
                                                imageBuilder:
                                                    (context, imageProvider) =>
                                                        Container(
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: imageProvider,
                                                        fit: BoxFit.cover,
                                                        colorFilter:
                                                            ColorFilter.mode(
                                                                Colors
                                                                    .transparent,
                                                                BlendMode
                                                                    .colorBurn)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            Container(
                                                height: 50,
                                                padding: EdgeInsets.all(5.0),
                                                decoration: BoxDecoration(
                                                    border: Border(
                                                      top: BorderSide(
                                                          width: 0.5,
                                                          color: yellow),
                                                      left: BorderSide(
                                                          width: 0.5,
                                                          color: yellow),
                                                      right: BorderSide(
                                                          width: 0.5,
                                                          color: yellow),
                                                      bottom: BorderSide(
                                                          width: 0.5,
                                                          color: yellow),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4.0),
                                                    gradient: LinearGradient(
                                                        colors: [
                                                          left,
                                                          middle,
                                                          Colors.purple
                                                        ])),
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    'Dairy',
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.white),
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => DetailPage(
                                                    '9',
                                                    "Rusk,Biscuits,Cake,Bread,Khari,Toast,chocolate,Chips")));
                                      },
                                      child: Container(
                                        margin: EdgeInsets.all(10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.all(10),
                                              height: 100,
                                              width: 100,
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    "http://uprank.live/farmerskart/images/category/1625808502.png",
                                                imageBuilder:
                                                    (context, imageProvider) =>
                                                        Container(
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: imageProvider,
                                                        fit: BoxFit.cover,
                                                        colorFilter:
                                                            ColorFilter.mode(
                                                                Colors
                                                                    .transparent,
                                                                BlendMode
                                                                    .colorBurn)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            Container(
                                                height: 50,
                                                padding: EdgeInsets.all(5.0),
                                                decoration: BoxDecoration(
                                                    border: Border(
                                                      top: BorderSide(
                                                          width: 0.5,
                                                          color: yellow),
                                                      left: BorderSide(
                                                          width: 0.5,
                                                          color: yellow),
                                                      right: BorderSide(
                                                          width: 0.5,
                                                          color: yellow),
                                                      bottom: BorderSide(
                                                          width: 0.5,
                                                          color: yellow),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4.0),
                                                    gradient: LinearGradient(
                                                        colors: [
                                                          left,
                                                          middle,
                                                          Colors.purple
                                                        ])),
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    'Bakery & Confectionery',
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.white),
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Festive Special',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            FestiveSpecial()));
                              },
                              child: Text(
                                'more>',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.purple,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 220,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: festiveSpecialList.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  List temp3 = [
                                    festiveSpecialList[index].imageUrl,
                                    festiveSpecialList[index].title,
                                    festiveSpecialList[index].weight,
                                    festiveSpecialList[index].newrate,
                                    festiveSpecialList[index].description,
                                    festiveSpecialList[index].oldrate,
                                    festiveSpecialList[index].data
                                  ];
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ProductDetails(temp3, 0)));
                                },
                                child: Container(
                                  margin: EdgeInsets.all(10),
                                  width: 150,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.all(10),
                                        height: 80,
                                        width: 80,
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              "http://uprank.live/farmerskart/images/product/${festiveSpecialList[index].imageUrl}",
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
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        festiveSpecialList[index].title,
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
                                        "₹  ${festiveSpecialList[index].newrate}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                          height: 25,
                                          width: 130,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
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
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Immunity Booster',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ImmunityBooster()));
                              },
                              child: Text(
                                'more>',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.purple,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 220,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: immunityBoosterList.length,
                            itemBuilder: (context, index) {
                              print(immunityBoosterList);
                              return InkWell(
                                onTap: () {
                                  List temp3 = [
                                    immunityBoosterList[index].imageUrl,
                                    immunityBoosterList[index].title,
                                    immunityBoosterList[index].weight,
                                    immunityBoosterList[index].newrate,
                                    immunityBoosterList[index].description,
                                    immunityBoosterList[index].oldrate,
                                    immunityBoosterList[index].data
                                  ];
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ProductDetails(temp3, 0)));
                                },
                                child: Container(
                                  margin: EdgeInsets.all(10),
                                  width: 150,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.all(10),
                                        height: 80,
                                        width: 80,
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              "http://uprank.live/farmerskart/images/product/${immunityBoosterList[index].imageUrl}",
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
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        immunityBoosterList[index].title,
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
                                        "₹  ${immunityBoosterList[index].newrate}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                          height: 25,
                                          width: 130,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
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
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Navigate(),
    );
  }

  Future<List> getAllProducts() async {
    allProducts = [];
    http.Response response;
    String usertype = "Society";
    String url =
        "https://uprank.live/farmerskart/app_api/getAllProducts.php?user_type=$usertype";
    Uri uri = Uri.parse(url);
    response = await http.get(uri);
    var jsonData = jsonDecode(response.body);
    if (jsonData["code"] == "200") {
      for (var item1 in jsonData["product"]) {
        List productprice = [];
        for (var item2 in item1["product_price"]) {
          Price price = new Price(
              item2["p_id"],
              item2["user_type"],
              item2["original_price"],
              item2["discount"].toString(),
              item2["discounted_price"],
              item2["weight"],
              item2["unit"]);
          productprice.add(price);
        }
        AllProducts allProduct = new AllProducts(
            productprice,
            item1["category_name"],
            item1["id"],
            item1["category"],
            item1["subcategory"],
            item1["name"],
            item1["img"],
            item1["description"],
            item1["del_flag"],
            item1["rating"]);
        allProducts.add(allProduct);
      }
    }
    print(allProducts);
    return allProducts;
  }
}

Future<List> getNotifications(BuildContext context) async {
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

class Notification {
  String message;
  String timeStamp;
  Notification(this.message, this.timeStamp);
}

void getCartProducts(BuildContext context) async {
  String userId = Provider.of<APIData>(context, listen: false).user.id;
  http.Response response;
  String url = "$header/app_api/getCartProducts.php?user_id=$userId";
  print(url);
  Uri uri = Uri.parse(url);
  response = await http.get(uri);
  var jsonData = jsonDecode(response.body);
  List cartproductsList = jsonData["order"];
  List productCategories = [];
  if (jsonData["code"] == "200") {
    for (int i = 0; i < cartproductsList.length; i++) {
      String category = cartproductsList[i]["category_name"];
      if (!productCategories.contains(category)) {
        productCategories.add(category);
      }
    }
  }
  List bakery = [];
  List vegetables = [];
  List grocery = [];
  List dairy = [];
  List pooja = [];
  for (int i = 0; i < cartproductsList.length; i++) {
    String category = cartproductsList[i]["category_name"];
    switch (category) {
      case "Fresh Vegetables & fruit":
        ProductsCart productsCart = new ProductsCart(
            cartproductsList[i]["category_name"],
            cartproductsList[i]["product_name"],
            cartproductsList[i]["product_img"],
            cartproductsList[i]["id"],
            cartproductsList[i]["user_id"],
            cartproductsList[i]["order_id"],
            cartproductsList[i]["quantity"],
            cartproductsList[i]["product_id"],
            cartproductsList[i]["unit_price"],
            cartproductsList[i]["order_status"],
            cartproductsList[i]["admin_status"],
            cartproductsList[i]["cart"],
            cartproductsList[i]["created_date"],
            cartproductsList[i]["total_amount"],
            cartproductsList[i]["updated_date"],
            cartproductsList[i]["cancelled_reason"],
            cartproductsList[i]["wallet"],
            cartproductsList[i]["weight"],
            cartproductsList[i]["specification"],
            cartproductsList[i]["coupon_value"],
            cartproductsList[i]["unit"],
            cartproductsList[i]["unit_original_price"],
            cartproductsList[i]["address_id"]);
        vegetables.add(productsCart);
        break;
      case "Grocery & Staples":
        ProductsCart productsCart = new ProductsCart(
            cartproductsList[i]["category_name"],
            cartproductsList[i]["product_name"],
            cartproductsList[i]["product_img"],
            cartproductsList[i]["id"],
            cartproductsList[i]["user_id"],
            cartproductsList[i]["order_id"],
            cartproductsList[i]["quantity"],
            cartproductsList[i]["product_id"],
            cartproductsList[i]["unit_price"],
            cartproductsList[i]["order_status"],
            cartproductsList[i]["admin_status"],
            cartproductsList[i]["cart"],
            cartproductsList[i]["created_date"],
            cartproductsList[i]["total_amount"],
            cartproductsList[i]["updated_date"],
            cartproductsList[i]["cancelled_reason"],
            cartproductsList[i]["wallet"],
            cartproductsList[i]["weight"],
            cartproductsList[i]["specification"],
            cartproductsList[i]["coupon_value"],
            cartproductsList[i]["unit"],
            cartproductsList[i]["unit_original_price"],
            cartproductsList[i]["address_id"]);
        grocery.add(productsCart);
        break;
      case "Bakery & Confectionery":
        ProductsCart productsCart = new ProductsCart(
            cartproductsList[i]["category_name"],
            cartproductsList[i]["product_name"],
            cartproductsList[i]["product_img"],
            cartproductsList[i]["id"],
            cartproductsList[i]["user_id"],
            cartproductsList[i]["order_id"],
            cartproductsList[i]["quantity"],
            cartproductsList[i]["product_id"],
            cartproductsList[i]["unit_price"],
            cartproductsList[i]["order_status"],
            cartproductsList[i]["admin_status"],
            cartproductsList[i]["cart"],
            cartproductsList[i]["created_date"],
            cartproductsList[i]["total_amount"],
            cartproductsList[i]["updated_date"],
            cartproductsList[i]["cancelled_reason"],
            cartproductsList[i]["wallet"],
            cartproductsList[i]["weight"],
            cartproductsList[i]["specification"],
            cartproductsList[i]["coupon_value"],
            cartproductsList[i]["unit"],
            cartproductsList[i]["unit_original_price"],
            cartproductsList[i]["address_id"]);
        bakery.add(productsCart);
        break;
      case "Dairy":
        ProductsCart productsCart = new ProductsCart(
            cartproductsList[i]["category_name"],
            cartproductsList[i]["product_name"],
            cartproductsList[i]["product_img"],
            cartproductsList[i]["id"],
            cartproductsList[i]["user_id"],
            cartproductsList[i]["order_id"],
            cartproductsList[i]["quantity"],
            cartproductsList[i]["product_id"],
            cartproductsList[i]["unit_price"],
            cartproductsList[i]["order_status"],
            cartproductsList[i]["admin_status"],
            cartproductsList[i]["cart"],
            cartproductsList[i]["created_date"],
            cartproductsList[i]["total_amount"],
            cartproductsList[i]["updated_date"],
            cartproductsList[i]["cancelled_reason"],
            cartproductsList[i]["wallet"],
            cartproductsList[i]["weight"],
            cartproductsList[i]["specification"],
            cartproductsList[i]["coupon_value"],
            cartproductsList[i]["unit"],
            cartproductsList[i]["unit_original_price"],
            cartproductsList[i]["address_id"]);
        dairy.add(productsCart);
        break;
      case "Pooja ":
        ProductsCart productsCart = new ProductsCart(
            cartproductsList[i]["category_name"],
            cartproductsList[i]["product_name"],
            cartproductsList[i]["product_img"],
            cartproductsList[i]["id"],
            cartproductsList[i]["user_id"],
            cartproductsList[i]["order_id"],
            cartproductsList[i]["quantity"],
            cartproductsList[i]["product_id"],
            cartproductsList[i]["unit_price"],
            cartproductsList[i]["order_status"],
            cartproductsList[i]["admin_status"],
            cartproductsList[i]["cart"],
            cartproductsList[i]["created_date"],
            cartproductsList[i]["total_amount"],
            cartproductsList[i]["updated_date"],
            cartproductsList[i]["cancelled_reason"],
            cartproductsList[i]["wallet"],
            cartproductsList[i]["weight"],
            cartproductsList[i]["specification"],
            cartproductsList[i]["coupon_value"],
            cartproductsList[i]["unit"],
            cartproductsList[i]["unit_original_price"],
            cartproductsList[i]["address_id"]);
        pooja.add(productsCart);
        break;
    }
  }
  List differentCategoryData = [];
  if (vegetables.isNotEmpty) {
    differentCategoryData.add(vegetables);
  }
  if (grocery.isNotEmpty) {
    differentCategoryData.add(grocery);
  }
  if (bakery.isNotEmpty) {
    differentCategoryData.add(bakery);
  }
  if (dairy.isNotEmpty) {
    differentCategoryData.add(dairy);
  }
  if (pooja.isNotEmpty) {
    differentCategoryData.add(pooja);
  }
  int itemCount = 0;
  for (var item in differentCategoryData) {
    itemCount += item.length;
  }
  Provider.of<APIData>(context, listen: false)
      .inititalizeCartProductCount(itemCount);
}

class SearchProducts extends SearchDelegate<String> {
  List products;
  SearchProducts(this.products);
  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    // actions for appbar
    return [
      IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.mic,
            color: Colors.amber[400],
          ))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    // leading icon on the left part of the app bar
    return Icon(
      Icons.search,
      color: Colors.amber[400],
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    // show results based on the selection
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    // show when someone searches for something
    List suggestionList = [];
    if (query.isNotEmpty) {
      for (int i = 0; i < products.length; i++) {
        if (products[i].name.toString().startsWith(query) ||
            products[i].name.toString().startsWith(query.toUpperCase()) ||
            products[i].name.toString().startsWith(query.toLowerCase()) ||
            products[i]
                .name
                .toString()
                .contains(query.substring(1, query.length))) {
          suggestionList.add(products[i]);
        }
      }
    }
    return ListView.separated(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(suggestionList[index].name.toString()),
            onTap: () {
              List temp = [
                suggestionList[index].img,
                suggestionList[index].name,
                suggestionList[index].price[0].weight,
                suggestionList[index].price[0].discountedPrice,
                suggestionList[index].description,
                suggestionList[index].price[0].originalPrice,
                suggestionList[index].price,
                suggestionList[index].price[0].discount
              ];
              if (suggestionList[index].price[0].discountedPrice.toString() ==
                      "" ||
                  suggestionList[index].price[0].discountedPrice.toString() ==
                      " .") {
                print(temp[6][0].unit);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ProductDetails.search(temp, 0, true, false)));
              } else {
                print(temp);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ProductDetails.search(temp, 1, true, true)));
              }
            },
          );
        },
        separatorBuilder: (context, index) {
          return Divider(height: 10, color: Colors.black);
        },
        itemCount: suggestionList.length);
    throw UnimplementedError();
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
                      print('pressed');
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
