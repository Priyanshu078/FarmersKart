import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:shellcode2/Bottom%20bar%20pages/categories.dart';
import 'package:shellcode2/Provider/data.dart';
import 'package:shellcode2/apiData/Constants.dart';
import 'package:shellcode2/apiData/add&removeUserfav.dart';
import 'package:shellcode2/cart.dart';
import 'package:shellcode2/filter.dart';
import 'package:shellcode2/home.dart';
import 'package:shellcode2/Bottom%20bar%20pages/wishlist.dart';
import 'package:shellcode2/productdetails.dart';
import 'package:shellcode2/search.dart';
import '../colors.dart';
import 'package:shellcode2/apiData/subCategory.dart';
import 'package:cached_network_image/cached_network_image.dart';

const String _heroAddTodo = 'add-todo-hero';
List<String> tempin = [];
List<General> temp = [];

String categoryId;
int j = 0;
String title;

class DetailPage extends StatefulWidget {
  final String index;
  final String subCategory;
  DetailPage(this.index, this.subCategory);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  void generalfunc() {}

  void chipfunc() {
    categoryId = widget.index;

    if (widget.index == '1') {
      {
        title = "Fresh Vegetables & fruits";
      }
    } else if (widget.index == '2') {
      title = "Grocery & Staples";
    } else if (widget.index == 4) {
      title = "Dairy";
    } else {
      title = "Bakery & Confectionery";
    }

    String subCategory = widget.subCategory;
    print(subCategory);
    final split = subCategory.split(',');
    final Map<int, String> values = {
      for (int i = 0; i < split.length; i++) i: split[i]
    };
    tempin = ['All'];
    for (int i = 0; i < values.length; i++) {
      print(values[i]);
      tempin.add(values[i]);
    }
  }

  void initState() {
    super.initState();
    chipfunc();
    print('sub');
    print(widget.index);
    print(widget.subCategory);
    fetchSubCategotyProductApiData(categoryId.toString(), 'All');

    temp = [];
    temp = subCategoryProductsList;
    print(subCategoryProductsList.length);
  }

  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    generalfunc();
    chipfunc();

    //Provider.of<APIData>(context,listen: false).initializeTemp(temp);
    print('size');
    print(temp.length);
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      backgroundColor: lightbg,
      appBar: AppBar(
        toolbarHeight: 45,
        centerTitle: false,
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
        //brightness: Brightness.light,
        flexibleSpace: Container(
          color: left,
        ),
        title: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 81,
            decoration: BoxDecoration(
                gradient:
                    LinearGradient(colors: [left, middle, Colors.purple])),
            child: Column(
              children: [
                Padding(
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
                        child: InkWell(
                          onTap: () {
                            showSearch(
                                context: context,
                                delegate: SearchProducts(temp));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
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
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Consumer<APIData>(builder: (context, data, child) {
                        try {
                          return Text(
                            '${data.temp.length} products',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          );
                        } catch (e) {
                          return Container();
                        }
                      }),
                      Material(
                        borderRadius: BorderRadius.circular(5),
                        color: bgcolor,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(30),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Filter()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              '    Filter    ',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 50,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 1,
                itemBuilder: (context, index) => choiceChipWidget(tempin)),
          ),
          Consumer<APIData>(
            builder: (context, data, child) {
              try {
                return Expanded(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: temp.length,
                        physics: ClampingScrollPhysics(),
                        itemBuilder: (context, index) {
                          bool flag = true;
                          if ((data.discountMoreThan15 == false &&
                                  data.discountUpToRs15 == false &&
                                  data.discountUpToRs5 == false) ||
                              (data.discountUpToRs5 == true &&
                                  int.parse(temp[index].discount) > 5) ||
                              (data.discountUpToRs15 == true &&
                                  int.parse(temp[index].discount) > 15) ||
                              (data.discountMoreThan15 == true &&
                                  int.parse(temp[index].discount) < 15))
                            flag = true;
                          else
                            flag = false;

                          if (flag) {
                            if ((data.priceMoreThan300 == false &&
                                    data.priceLessThan300 == false &&
                                    data.priceLessThan100 == false &&
                                    data.priceLessThan20 == false) ||
                                (data.priceLessThan100 == true &&
                                    temp[index].newrate < 100) ||
                                (data.priceLessThan300 == true &&
                                    temp[index].newrate < 300) ||
                                (data.priceLessThan20 == true &&
                                    temp[index].newrate < 20) ||
                                (data.priceMoreThan300 == true &&
                                    temp[index].newrate > 300)) {
                              flag = true;
                            } else
                              flag = false;
                          }

                          if (flag == false) {
                            return Container(
                              height: 0,
                              width: 0,
                            );
                          }

                          return InkWell(
                            onTap: () {
                              List temp2 = [
                                temp[index].imageUrl,
                                temp[index].title,
                                temp[index].weight,
                                temp[index].newrate,
                                temp[index].description,
                                temp[index].oldrate,
                                temp[index].data
                              ];
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ProductDetails.category(
                                              temp2, 0, true)));
                            },
                            child: Container(
                              margin: EdgeInsets.all(10),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        spreadRadius: 1,
                                        blurRadius: 1,
                                        offset: Offset(0, 1),
                                        color: Colors.black38)
                                  ]),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 20, 10, 20),
                                    child: Container(
                                      height: 70,
                                      width: 70,
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            "http://uprank.live/farmerskart/images/product/${data.temp[index].imageUrl}",
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
                                    width: MediaQuery.of(context).size.width *
                                        (1 / 2 + 1 / 8),
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Align(
                                            alignment: Alignment.centerRight,
                                            child: IconButton(
                                                onPressed: () async {
                                                  setState(() {
                                                    if (temp[index].fav == 0)
                                                      temp[index].fav = 1;
                                                    else
                                                      temp[index].fav = 0;
                                                  });

                                                  String msg;
                                                  if (temp[index].fav == 0)
                                                    msg = await removeUserFav(
                                                        Provider.of<APIData>(
                                                                context,
                                                                listen: false)
                                                            .userId,
                                                        temp[index].productId);
                                                  else
                                                    msg = await addUserFav(
                                                        Provider.of<APIData>(
                                                                context,
                                                                listen: false)
                                                            .userId,
                                                        temp[index].productId);

                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                          content: Text(msg)));
                                                },
                                                icon: Icon(
                                                  (temp[index].fav != 1)
                                                      ? Icons
                                                          .favorite_border_rounded
                                                      : Icons.favorite,
                                                  color: yellow,
                                                ))),
                                        Text(
                                          temp[index].title,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                            color: Colors.deepPurple,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
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
                                                      width: 2.0,
                                                      color: Colors.purple),
                                                  left: BorderSide(
                                                      width: 2.0,
                                                      color: Colors.purple),
                                                  right: BorderSide(
                                                      width: 2.0,
                                                      color: Colors.purple),
                                                  bottom: BorderSide(
                                                      width: 2.0,
                                                      color: Colors.purple),
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      " ${temp[index].data[0][0]}",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: yellow,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
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
                                          height: 3,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "₹  ${temp[index].newrate}",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                                color: Colors.purple,
                                              ),
                                            ),
                                            RatingBar.builder(
                                              unratedColor: Colors.grey[300],
                                              itemCount: 5,
                                              initialRating: 0,
                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              itemSize: 18,
                                              itemBuilder: (context, _) => Icon(
                                                Icons.star,
                                                size: 1.0,
                                                color: yellow,
                                              ),
                                              onRatingUpdate: (rating) {
                                                print(rating);
                                              },
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: RaisedButton(
                                            elevation: 0.0,
                                            color: bgcolor,
                                            onPressed: () {
                                              setState(() {
                                                selectedIndex = index;
                                              });
                                            },
                                            child: selectedIndex == index
                                                ? Container(
                                                    child: CustomStepper(
                                                      lowerLimit: 1,
                                                      upperLimit: 10,
                                                      value: 1,
                                                      stepValue: 1,
                                                      iconSize: 10,
                                                    ),
                                                  )
                                                : Container(
                                                    height: 25,
                                                    width: 80,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                      color: Colors.purple[700],
                                                    ),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        "ADD",
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    )),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                );
              } catch (e) {
                return Container();
              }
            },
          ),
        ],
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
            backgroundColor: Colors.grey[200],
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
  String selectedChoice = "All";
  _buildChoiceList() {
    List<Widget> choices = [];

    widget.reportList.forEach((item) {
      choices.add(Container(
        width: 80,
        padding: const EdgeInsets.all(3.0),
        child: ChoiceChip(
          label: Text(item),
          labelStyle: TextStyle(
              color: selectedChoice == item ? Colors.white : Colors.black,
              fontSize: 14.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          backgroundColor: bgcolor,
          selectedColor: Colors.yellow[800],
          selected: selectedChoice == item,
          onSelected: (selected) async {
            await fetchSubCategotyProductApiData(categoryId.toString(), item);
            setState(() {
              selectedChoice = item;
              print(item);

              temp = [];
              temp = subCategoryProductsList;

              Provider.of<APIData>(context, listen: false).initializeTemp(temp);
              print('size');
              print(temp.length);
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
                      'Farmerskart - ${temp[n].title}',
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
                    for (int k = 0; k < temp[n].data.length; k++) ...{
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
                              Text(
                                '${temp[n].data[k][0]} -',
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
                                '₹${temp[n].data[k][1]}',
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
                                '₹${temp[n].data[k][2]}',
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
        if (products[i].title.toString().startsWith(query) ||
            products[i].title.toString().startsWith(query.toUpperCase()) ||
            products[i].title.toString().startsWith(query.toLowerCase()) ||
            products[i]
                .title
                .toString()
                .contains(query.substring(1, query.length))) {
          suggestionList.add(products[i]);
        }
      }
    }
    return ListView.separated(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(suggestionList[index].title.toString()),
            onTap: () {
              List temp1 = [
                suggestionList[index].imageUrl,
                suggestionList[index].title,
                suggestionList[index].weight,
                suggestionList[index].newrate,
                suggestionList[index].description,
                suggestionList[index].oldrate,
                suggestionList[index].data
              ];
              if (suggestionList[index].newrate.toString() == "" ||
                  suggestionList[index].newrate.toString() == " .") {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ProductDetails.category(temp1, 0, true)));
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ProductDetails.category(temp1, 0, true)));
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
      height: 30,
      width: 100,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.purple),
        borderRadius: BorderRadius.circular(5),
      ),
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
                    widget.value = widget.value == widget.lowerLimit
                        ? widget.lowerLimit
                        : widget.value -= widget.stepValue;
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
                    widget.value = widget.value == widget.upperLimit
                        ? widget.upperLimit
                        : widget.value += widget.stepValue;
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
