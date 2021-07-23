import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shellcode2/Bottom%20bar%20pages/categories.dart';
import 'package:shellcode2/home.dart';
import 'package:shellcode2/Bottom%20bar%20pages/wishlist.dart';
import '../colors.dart';

const String _heroAddTodo = 'add-todo-hero';
List<String> tempin = [];
List<General> temp = [];
int i=0;
int j=0;

class DetailPage extends StatefulWidget {
  final int index;
  DetailPage(this.index);
  @override
  _DetailPageState createState() => _DetailPageState();
}
class _DetailPageState extends State<DetailPage> {

  void generalfunc (){
    i = widget.index;
    if (widget.index==0)
      {
        temp = freshVegetables;
      }
    else if (widget.index==1)
      {
        temp = List.from(grocery);
      }
    else if (widget.index==2)
    {
      temp = List.from(dairy);
    }
    else
    {
      temp = List.from(bakery);
    }
  }


  void chipfunc (){
    if (widget.index==0)
    {
      tempin = List.from(chipList0);
    }
    else if (widget.index==1)
    {
      tempin = List.from(chipList1);
    }
    else if (widget.index==2)
    {
      tempin = List.from(chipList2);
    }
    else
    {
      tempin = List.from(chipList3);
    }
  }
  List<String> chipList0 = [
    "All",
    "Cheese",
    "Butter",
    "Paneer",
    "Lassi",
    "Cream"
  ];
  List<String> chipList1 = [
    "All",
    "Cheese",
    "Butter",
    "Paneer",
    "Lassi",
    "Cream"
  ];List<String> chipList2 = [
    "All",
    "Cheese",
    "Butter",
    "Paneer",
    "Lassi",
    "Cream"
  ];List<String> chipList3 = [
    "All",
    "Cheese",
    "Butter",
    "Paneer",
    "Lassi",
    "Cream"
  ];

  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
      generalfunc();
      chipfunc();
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
              onPressed: null,
              icon: Icon(
                Icons.shopping_cart,
                color: yellow,
              )
          )
        ],
        //brightness: Brightness.light,
        flexibleSpace: Container(
          color: left,
        ),
        title: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(detailservices[i].title,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 18,
              color: Colors.white,
            ),),
        ),
      ),
      body: Column(
        children:[
          Container(
            height: 81,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [left,middle,Colors.purple]
                )
            ),
            child: Column(
              children:[
                Padding(
                padding: const EdgeInsets.only(left: 18.0, right: 18.0, top: 8.0 , bottom: 8.0),
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
                          Row(
                            children: [
                              Icon(Icons.search, color: yellow,),
                              Text('   '),
                              Text('Search', style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                                color: Colors.grey[600],
                              ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.keyboard_voice_outlined, color: yellow,)
                            ],
                          )

                        ],
                      ),
                    ),
                  ),
                ),
              ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('11 products', style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),),
                      Material(
                        borderRadius: BorderRadius.circular(5),
                        color: bgcolor,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(30),
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child:
                                    Text('    Filter    ', style: TextStyle(
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
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: new ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: temp.length,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (context, index){

                    return InkWell(
                      onTap: () {},
                      child: Container(
                        margin: EdgeInsets.all(10),
                        width: 150,
                        color: bgcolor,
                        child:
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Container(
                                height: 50,
                                width: 50,
                                child: Image.asset(temp[index].imageUrl!, fit: BoxFit.cover,),
                              ),
                            ),
                            Container(
                              width: 250,
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Align(
                                      alignment: Alignment.centerRight,
                                      child: IconButton(
                                          onPressed: null,
                                          icon: Icon(Icons.favorite_border_rounded,color: yellow,))),
                                  Text(temp[index].title,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: Colors.deepPurpleAccent[100],
                                    ),),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  GestureDetector(
                                   // borderRadius: BorderRadius.circular(20),
                                    onTap: (){
                                      Navigator.of(context).push(HeroDialogRoute(builder: (context) {
                                        return _AddTodoPopupCard(index);
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
                                            Text(' ₹ ${temp[index].weight}', style: TextStyle(
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
                                    height: 3,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("₹  ${temp[index].rate}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                          color: Colors.white,
                                        ),),
                                      RatingBar.builder(
                                        unratedColor: lightbg,
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
                                      color: bgcolor,
                                      onPressed: (){
                                        setState(() {
                                          selectedIndex = index;
                                        });
                                      },
                                      child: selectedIndex == index ? Container(
                                        child: CustomStepper(lowerLimit: 1,upperLimit: 10,value: 1,stepValue: 1,iconSize: 10,),) : Container(
                                          height: 25,
                                          width: 80,
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
          ),
      ],
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
        color: lightbg,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.grey[900],
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

class choiceChipWidget extends StatefulWidget {
  final List<String> reportList;

  choiceChipWidget(this.reportList);

  @override
  _choiceChipWidgetState createState() => new _choiceChipWidgetState();
}
class _choiceChipWidgetState extends State<choiceChipWidget> {
  String selectedChoice = "";
  _buildChoiceList() {
    List<Widget> choices = [];
    widget.reportList.forEach((item) {
      choices.add(Container(
        width: 80,
        padding: const EdgeInsets.all(3.0),
        child: ChoiceChip(
          label: Text(item),
          labelStyle: TextStyle(
              color: Colors.white, fontSize: 14.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          backgroundColor: bgcolor,
          selectedColor: Colors.yellow[800],
          selected: selectedChoice == item,
          onSelected: (selected) {
            setState(() {
              selectedChoice = item;
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

class Detailservices{
  String title;
  int cartCount;
  //String classTitle;
  Detailservices({
    required this.title,
    required this.cartCount,
    //@required this.classTitle,
  });
}
List<Detailservices> detailservices =[
  Detailservices(title: 'Fresh Vegetables & fruits',cartCount: 500 ),
  Detailservices(title: 'Grocery & Staples', cartCount: 41 ),
  Detailservices(title: 'Dairy',cartCount: 124 ),
  Detailservices(title: 'Bakery & Confectionery', cartCount: 500 ),
];

class General{
  String title;
  String imageUrl;
  int weight;
  int rate;
  List<List> data;
  General({
    required this.title,
    required this.weight,
    required this.rate,
    required this.imageUrl,
    required this.data,
    }
      );
}
List<General> freshVegetables =[
  General(imageUrl: 'assets/bg.jpg',title: 'freshVegetables',weight: 700, rate: 600,data: [['180 GM',200,197],['120 GM',100,157],['100 GM',50,100]]),
  General(imageUrl: 'assets/bg.jpg',title: 'freshVegetables',weight: 700, rate: 600,data: [['180 GM',200,197],['120 GM',100,157]]),
  General(imageUrl: 'assets/bg.jpg',title: 'freshVegetables',weight: 700, rate: 600,data: [['180 GM',200,197]]),
  General(imageUrl: 'assets/bg.jpg',title: 'freshVegetables',weight: 700, rate: 600,data: [['180 GM',200,197],['120 GM',100,157],['100 GM',50,100]]),
];
List<General> grocery =[
  General(imageUrl: 'assets/bg.jpg',title: 'grocery',weight: 700, rate: 600,data: [['180 GM',200,197],['120 GM',100,157],['100 GM',50,100]]),
  General(imageUrl: 'assets/bg.jpg',title: 'grocery',weight: 700, rate: 600,data: [['180 GM',200,197],['120 GM',100,157],['100 GM',50,100]]),
  General(imageUrl: 'assets/bg.jpg',title: 'grocery',weight: 700, rate: 600,data: [['180 GM',200,197],['120 GM',100,157],['100 GM',50,100]]),
  General(imageUrl: 'assets/bg.jpg',title: 'grocery',weight: 700, rate: 600,data: [['180 GM',200,197],['120 GM',100,157],['100 GM',50,100]]),
];
List<General> dairy =[
  General(imageUrl: 'assets/bg.jpg',title: 'dairy',weight: 700, rate: 600,data: [['180 GM',200,197],['120 GM',100,157],['100 GM',50,100]]),
  General(imageUrl: 'assets/bg.jpg',title: 'dairy',weight: 700, rate: 600,data: [['180 GM',200,197],['120 GM',100,157],['100 GM',50,100]]),
  General(imageUrl: 'assets/bg.jpg',title: 'dairy',weight: 700, rate: 600,data: [['180 GM',200,197],['120 GM',100,157],['100 GM',50,100]]),
  General(imageUrl: 'assets/bg.jpg',title: 'dairy',weight: 700, rate: 600,data: [['180 GM',200,197],['120 GM',100,157],['100 GM',50,100]]),
  General(imageUrl: 'assets/bg.jpg',title: 'dairy',weight: 700, rate: 600,data: [['180 GM',200,197],['120 GM',100,157],['100 GM',50,100]]),
];
List<General> bakery =[
  General(imageUrl: 'assets/bg.jpg',title: 'bakery',weight: 700, rate: 600,data: [['180 GM',200,197],['120 GM',100,157],['100 GM',50,100]]),
  General(imageUrl: 'assets/bg.jpg',title: 'bakery',weight: 700, rate: 600,data: [['180 GM',200,197],['120 GM',100,157],['100 GM',50,100]]),
  General(imageUrl: 'assets/bg.jpg',title: 'bakery',weight: 700, rate: 600,data: [['180 GM',200,197],['120 GM',100,157],['100 GM',50,100]]),
  General(imageUrl: 'assets/bg.jpg',title: 'bakery',weight: 700, rate: 600,data: [['180 GM',200,197],['120 GM',100,157],['100 GM',50,100]]),
];

int n = 0;
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
  _AddTodoPopupCard(int s){
    n =s;
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
                         color: Colors.purpleAccent,
                         fontSize: 14,
                         fontWeight: FontWeight.w600
                       ),
                    ),
                    Text(
                        'Farmerskart - ${temp[n].title}',
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
                    for(int k=0; k<temp[n].data.length; k++) ...{
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
                              Text('${temp[n].data[k][0]} -', style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Colors.white,
                              ),
                              ),
                              Spacer(flex: 2,),
                              Text('₹${temp[n].data[k][1]}', style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Colors.white,
                                decoration: TextDecoration. lineThrough,
                              ),
                              ),
                              Spacer(flex: 2,),
                              Text('₹${temp[n].data[k][2]}', style: TextStyle(
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
      height: 30,
      width: 100,
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