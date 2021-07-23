import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shellcode2/Bottom%20bar%20pages/categories.dart';
import 'package:shellcode2/colors.dart';
import 'package:shellcode2/detailServiceList.dart';
import 'package:shellcode2/home.dart';


const String _heroAddTodo = 'add-todo-hero';
class Wishlist extends StatefulWidget {
  const Wishlist({Key? key}) : super(key: key);

  @override
  _WishlistState createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  List<String> tempin = ['All','Fresh vegetables & fruit','Grocery & Staples','Dairy','Bakery & Confectionery'];
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
        //brightness: Brightness.light,
        flexibleSpace: Container(
          color: left,
        ),
        title: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text('Wishlist',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 18,
              color: Colors.white,
            ),),
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
                  itemCount: tempin.length,
                  itemBuilder: (context, index) => choiceChipWidget(tempin)),
            ),
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: new ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: detail.length,
                    physics: ClampingScrollPhysics(),
                    itemBuilder: (context, index){
                      return Container(
                        margin: EdgeInsets.all(10),
                        width: 150,
                        color: bgcolor,
                        child:
                        Column(
                          children:[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 28,
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
                                    padding: const EdgeInsets.all(5.0),
                                    child:
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('₹ 3 OFF', style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                          color: Colors.white,
                                        ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                IconButton(onPressed: null, icon: Icon(CupertinoIcons.clear_circled_solid,color: Colors.white.withOpacity(0.5),))
                              ],
                            ),
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
                                    Text(temp[index].title,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: Colors.purpleAccent,
                                      ),),
                                    SizedBox(
                                      height: 10,
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
                                              top: BorderSide(width: 1.0, color: Colors.deepPurpleAccent),
                                              left: BorderSide(width: 1.0, color: Colors.deepPurpleAccent),
                                              right: BorderSide(width: 1.0, color: Colors.deepPurpleAccent),
                                              bottom: BorderSide(width: 1.0, color: Colors.deepPurpleAccent),
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
                                      height: 10,
                                    ),
                                    Text("₹  ${temp[index].rate}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        color: Colors.purpleAccent,
                                      ),),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: ElevatedButton(
                                        onPressed: (){
                                          Navigator.of(context).push(HeroDialogRoute(builder: (context) {
                                            return _AddTodoPopupCard(index);
                                          }, settings:  ModalRoute.of(context)!.settings));
                                        },
                                        child: Text('Move to Cart',style: TextStyle(color: Colors.white),),
                                        style: ButtonStyle(
                                            backgroundColor: MaterialStateProperty.all(Colors.purple[600]),
                                            padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 12,horizontal: 20)),
                                            textStyle: MaterialStateProperty.all(TextStyle(fontSize: 14))),
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
            ),
          ],
        ),
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
        padding: const EdgeInsets.all(3.0),
        color: bgcolor,
        child: ChoiceChip(
          label: Text(item),
          labelStyle: TextStyle(
              color: Colors.white, fontSize: 14.0,fontWeight: FontWeight.w400),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          backgroundColor: Colors.yellow[700]!.withOpacity(0.8),
          selectedColor: Colors.yellow[900],
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
                      'Farmerskart - ${detail[n].title}',
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
                    for(int k=0; k<detail[n].weight.length; k++) ...{
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
                              Text('${detail[n].weight[k][0]} -', style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Colors.white,
                              ),
                              ),
                              Spacer(flex: 2,),
                              Text('₹${detail[n].weight[k][1]}', style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Colors.white,
                                decoration: TextDecoration. lineThrough,
                              ),
                              ),
                              Spacer(flex: 2,),
                              Text('₹${detail[n].weight[k][2]}', style: TextStyle(
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

class Detail{
  String title;
  int rate;
  List weight;
  Detail({
    required this.title,
    required this.rate,
    required this.weight,
  });
}
List<Detail> detail =[
  Detail(title: 'Fresh Vegetables & fruits',rate: 500,weight: [['180 GM',200,197],['250 GM',500,400]]),
  Detail(title: 'Fresh Vegetables & fruits',rate: 500,weight: [['180 GM',200,197],['250 GM',500,400]]),
  Detail(title: 'Fresh Vegetables & fruits',rate: 500,weight: [['180 GM',200,197],['250 GM',500,400]]),
  Detail(title: 'Fresh Vegetables & fruits',rate: 500,weight: [['180 GM',200,197],['250 GM',500,400]])
];