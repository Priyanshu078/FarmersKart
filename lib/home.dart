import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shellcode2/More%20pages/ImmunityMore.dart';
import 'package:shellcode2/More%20pages/bestSellingMore.dart';
import 'package:shellcode2/Bottom%20bar%20pages/categories.dart';
import 'package:shellcode2/Navigation%20Drawer%20pages/handyOrder.dart';
import 'package:shellcode2/apiData/OffersApiData.dart';
import 'package:shellcode2/cart.dart';
import 'package:shellcode2/colors.dart';
import 'package:shellcode2/detailServiceList.dart';
import 'package:shellcode2/drawerscreen.dart';
import 'package:shellcode2/More%20pages/festiveSpecialMore.dart';
import 'package:shellcode2/More%20pages/newArrivalsmore.dart';
import 'package:shellcode2/More%20pages/offerMore.dart';
import 'package:shellcode2/productdetails.dart';
import 'package:shellcode2/Bottom%20bar%20pages/wishlist.dart';
import 'package:shellcode2/search.dart';
import 'package:shellcode2/apiData/BestSellingProducts.dart';
import 'package:provider/provider.dart';
import 'package:shellcode2/Provider/data.dart';

List<BestProductCategories> bestProductCategory = bestProductCategoryList;
List offerData = offersData;

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Data data = new Data();
  int _current = 0;
  List imgList = [
    'https://images.unsplash.com/photo-1502117859338-fd9daa518a9a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1554321586-92083ba0a115?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1536679545597-c2e5e1946495?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1543922596-b3bbaba80649?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1502943693086-33b5b1cfdf2f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=668&q=80'
  ];
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
    requestPermission(_permission);
  }

  String getUserType() {
    String userType =
        Provider.of<UserAccountDetails>(context, listen: false).user.userType;
    return userType;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: Text('Farmers kart'),
        elevation: 0,
        iconTheme: IconThemeData(color: yellow),
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
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Search(),
                                ));
                              },
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
                            '${Provider.of<UserAccountDetails>(context, listen: false).user.pincode}',
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
                                          child: Image.asset(
                                            bestProductCategory[index].imageUrl,
                                            fit: BoxFit.cover,
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
                                itemCount: listCards2.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      List temp2 = [
                                        listCards2[index].imageUrl,
                                        listCards2[index].title,
                                        listCards2[index].weight,
                                        listCards2[index].newrate,
                                        listCards2[index].description,
                                        listCards2[index].oldrate,
                                        listCards2[index].data,
                                        listCards2[index].off
                                      ];
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
                                            child: Image.asset(
                                              listCards2[index].imageUrl,
                                              fit: BoxFit.cover,
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
                                                    '₹ ${listCards2[index].off} OFF',
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
                                            listCards2[index].title,
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
                                            "₹  ${listCards2[index].newrate}",
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
                                        'assets/bg.jpg',
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
                                                      temp2, 1, true)));
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
                                            child: Image.asset(
                                              'assets/bg.jpg',
                                              fit: BoxFit.cover,
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
                            itemCount: listCards3.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  List temp1 = [
                                    listCards3[index].imageUrl,
                                    listCards3[index].title,
                                    listCards3[index].weight,
                                    listCards3[index].newrate,
                                    listCards3[index].description,
                                    listCards3[index].oldrate,
                                    listCards3[index].data
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
                                        child: Image.asset(
                                          listCards3[index].imageUrl,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        listCards3[index].title,
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
                                        "₹  ${listCards3[index].newrate}",
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
                                                builder: (context) =>
                                                    DetailPage(0)));
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
                                              child: Image.asset(
                                                'assets/bg.jpg',
                                                fit: BoxFit.cover,
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
                                                builder: (context) =>
                                                    DetailPage(1)));
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
                                              child: Image.asset(
                                                'assets/bg.jpg',
                                                fit: BoxFit.cover,
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
                                                builder: (context) =>
                                                    DetailPage(2)));
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
                                              child: Image.asset(
                                                'assets/bg.jpg',
                                                fit: BoxFit.cover,
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
                                                builder: (context) =>
                                                    DetailPage(3)));
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
                                              child: Image.asset(
                                                'assets/bg.jpg',
                                                fit: BoxFit.cover,
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
                            itemCount: listCards4.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  List temp3 = [
                                    listCards4[index].imageUrl,
                                    listCards4[index].title,
                                    listCards4[index].weight,
                                    listCards4[index].newrate,
                                    listCards4[index].description,
                                    listCards4[index].oldrate,
                                    listCards4[index].data
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
                                        child: Image.asset(
                                          listCards4[index].imageUrl,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        listCards4[index].title,
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
                                        "₹  ${listCards4[index].newrate}",
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
                            itemCount: listCards5.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  List temp3 = [
                                    listCards4[index].imageUrl,
                                    listCards4[index].title,
                                    listCards4[index].weight,
                                    listCards4[index].newrate,
                                    listCards4[index].description,
                                    listCards4[index].oldrate,
                                    listCards4[index].data
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
                                        child: Image.asset(
                                          listCards5[index].imageUrl,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        listCards5[index].title,
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
                                        "₹  ${listCards5[index].newrate}",
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

class OfferCategories {
  String imageUrl;
  String weight;
  String title;
  double newrate;
  double oldrate;
  String description;
  double off;
  List<List> data;
  OfferCategories({
    @required this.imageUrl,
    @required this.title,
    @required this.newrate,
    @required this.oldrate,
    @required this.weight,
    @required this.description,
    @required this.data,
    @required this.off,
  });
}

List<OfferCategories> listCards2 = [
  OfferCategories(
      imageUrl: 'assets/bg.jpg',
      description: ' ',
      title: 'Cucumber',
      oldrate: 5,
      newrate: 10,
      weight: '100 GM',
      data: [
        ['180 GM', 200, 197],
        ['120 GM', 100, 157],
        ['100 GM', 50, 100]
      ],
      off: 10),
  OfferCategories(
      imageUrl: 'assets/bg.jpg',
      description: ' ',
      title: 'Apple',
      oldrate: 5,
      newrate: 10,
      weight: '100 GM',
      data: [
        ['180 GM', 200, 197]
      ],
      off: 10),
  OfferCategories(
      imageUrl: 'assets/bg.jpg',
      description: ' ',
      title: 'Cheese',
      oldrate: 5,
      newrate: 10,
      weight: '100 GM',
      data: [
        ['180 GM', 200, 197],
        ['120 GM', 100, 157]
      ],
      off: 10),
  OfferCategories(
      imageUrl: 'assets/bg.jpg',
      description: ' ',
      title: 'Orange',
      oldrate: 5,
      newrate: 10,
      weight: '100 GM',
      data: [
        ['180 GM', 200, 197],
        ['120 GM', 100, 157],
        ['100 GM', 50, 100]
      ],
      off: 10),
];

class NewArrivalCategories {
  String imageUrl;
  String weight;
  String title;
  double newrate;
  double oldrate;
  String description;
  List<List> data;
  NewArrivalCategories({
    @required this.imageUrl,
    @required this.title,
    @required this.newrate,
    @required this.oldrate,
    @required this.weight,
    @required this.description,
    @required this.data,
  });
}

List<NewArrivalCategories> listCards3 = [
  NewArrivalCategories(
      imageUrl: 'assets/bg.jpg',
      description: ' ',
      title: 'Cucumber',
      oldrate: 5,
      newrate: 10,
      weight: '100 GM',
      data: [
        ['180 GM', 200, 197],
        ['120 GM', 100, 157],
        ['100 GM', 50, 100]
      ]),
  NewArrivalCategories(
      imageUrl: 'assets/bg.jpg',
      description: ' ',
      title: 'Apple',
      oldrate: 5,
      newrate: 10,
      weight: '100 GM',
      data: [
        ['180 GM', 200, 197]
      ]),
  NewArrivalCategories(
      imageUrl: 'assets/bg.jpg',
      description: ' ',
      title: 'Cheese',
      oldrate: 5,
      newrate: 10,
      weight: '100 GM',
      data: [
        ['180 GM', 200, 197],
        ['120 GM', 100, 157]
      ]),
  NewArrivalCategories(
      imageUrl: 'assets/bg.jpg',
      description: ' ',
      title: 'Orange',
      oldrate: 5,
      newrate: 10,
      weight: '100 GM',
      data: [
        ['180 GM', 200, 197],
        ['120 GM', 100, 157],
        ['100 GM', 50, 100]
      ]),
];

class FestiveCategories {
  String imageUrl;
  String weight;
  String title;
  double newrate;
  double oldrate;
  String description;
  List<List> data;
  FestiveCategories({
    @required this.imageUrl,
    @required this.title,
    @required this.newrate,
    @required this.oldrate,
    @required this.weight,
    @required this.description,
    @required this.data,
  });
}

List<FestiveCategories> listCards4 = [
  FestiveCategories(
      imageUrl: 'assets/bg.jpg',
      description: ' ',
      title: 'Cucumber',
      oldrate: 5,
      newrate: 10,
      weight: '100 GM',
      data: [
        ['180 GM', 200, 197],
        ['120 GM', 100, 157],
        ['100 GM', 50, 100]
      ]),
  FestiveCategories(
      imageUrl: 'assets/bg.jpg',
      description: ' ',
      title: 'Apple',
      oldrate: 5,
      newrate: 10,
      weight: '100 GM',
      data: [
        ['180 GM', 200, 197]
      ]),
  FestiveCategories(
      imageUrl: 'assets/bg.jpg',
      description: ' ',
      title: 'Cheese',
      oldrate: 5,
      newrate: 10,
      weight: '100 GM',
      data: [
        ['180 GM', 200, 197],
        ['120 GM', 100, 157]
      ]),
  FestiveCategories(
      imageUrl: 'assets/bg.jpg',
      description: ' ',
      title: 'Orange',
      oldrate: 5,
      newrate: 10,
      weight: '100 GM',
      data: [
        ['180 GM', 200, 197],
        ['120 GM', 100, 157],
        ['100 GM', 50, 100]
      ]),
];

class ImmunityCategories {
  String imageUrl;
  String weight;
  String title;
  double newrate;
  double oldrate;
  String description;
  List<List> data;
  ImmunityCategories({
    @required this.imageUrl,
    @required this.title,
    @required this.newrate,
    @required this.oldrate,
    @required this.weight,
    @required this.description,
    @required this.data,
  });
}

List<ImmunityCategories> listCards5 = [
  ImmunityCategories(
      imageUrl: 'assets/bg.jpg',
      description: ' ',
      title: 'Cucumber',
      oldrate: 5,
      newrate: 10,
      weight: '100 GM',
      data: [
        ['180 GM', 200, 197],
        ['120 GM', 100, 157],
        ['100 GM', 50, 100]
      ]),
  ImmunityCategories(
      imageUrl: 'assets/bg.jpg',
      description: ' ',
      title: 'Apple',
      oldrate: 5,
      newrate: 10,
      weight: '100 GM',
      data: [
        ['180 GM', 200, 197]
      ]),
  ImmunityCategories(
      imageUrl: 'assets/bg.jpg',
      description: ' ',
      title: 'Cheese',
      oldrate: 5,
      newrate: 10,
      weight: '100 GM',
      data: [
        ['180 GM', 200, 197],
        ['120 GM', 100, 157]
      ]),
  ImmunityCategories(
      imageUrl: 'assets/bg.jpg',
      description: ' ',
      title: 'Orange',
      oldrate: 5,
      newrate: 10,
      weight: '100 GM',
      data: [
        ['180 GM', 200, 197],
        ['120 GM', 100, 157],
        ['100 GM', 50, 100]
      ]),
];
