import 'package:flutter/material.dart';
import 'package:shellcode2/colors.dart';

class Filter extends StatefulWidget {
  const Filter({Key? key}) : super(key: key);

  @override
  _FilterState createState() => _FilterState();
}
int val=0;
class _FilterState extends State<Filter> {
  bool checkedValue =false;
  Color getColor1(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.white;
    }
    return Colors.purple;
  }
  Color getColor2(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.white;
    }
    return Colors.purple;
  }
  Color getColor3(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.white;
    }
    return Colors.purple;
  }
  Color getColor4(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.white;
    }
    return Colors.purple;
  }
  Color getColor5(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.white;
    }
    return Colors.purple;
  }
  Color getColor6(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.white;
    }
    return Colors.purple;
  }
  Color getColor7(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.white;
    }
    return Colors.purple;
  }
  Color getColor8(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.white;
    }
    return Colors.purple;
  }
  Color getColor9(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.white;
    }
    return Colors.purple;
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Builder(builder: (BuildContext context) {
          final TabController _tabController = DefaultTabController.of(
              context)!;
          _tabController.addListener(() {
            if (!_tabController.indexIsChanging) {
              setState(() {
                val = _tabController.index;
              });
            }
          });
          return Scaffold(
            backgroundColor: bgcolor,
            appBar: AppBar(
                centerTitle: true,
                titleSpacing: 0.0,
                elevation: 0,
                automaticallyImplyLeading: false,
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [left, middle, Colors.purple]
                      )
                  ),
                ),
                title: Text('Filter',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    color: Colors.white,
                  ),)

            ),
            body: DefaultTabController(
              length: 1,
              child: Column(
                children: <Widget>[
                  Container(
                    height: 60,
                    constraints: BoxConstraints(maxHeight: 150.0),
                    child: Material(
                      color: bgcolor,
                      child: TabBar(
                        controller: _tabController,
                        indicatorColor: yellow,
                        unselectedLabelColor: Colors.black,
                        tabs: [
                          Tab(child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                                color: val == 0
                                    ? yellow.withOpacity(0.7)
                                    : yellow.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10.0)
                            ),
                            child: Align(
                                alignment: Alignment.center,
                                child: Text('Refine by', style: TextStyle(
                                  letterSpacing: 0.8,
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),)),
                          ),),
                          Tab(child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                                color: val == 2
                                    ? yellow.withOpacity(0.7)
                                    : yellow.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10.0)
                            ),
                            child: Align(
                                alignment: Alignment.center,
                                child: Text('Sort by', style: TextStyle(
                                    color: Colors.white,
                                    letterSpacing: 0.8,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),)),
                          ),),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        SingleChildScrollView(child: val == 0 ? Container(
                          padding: EdgeInsets.all(40.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('Discount',style: TextStyle(color: Colors.purple[700],fontSize: 18,fontWeight: FontWeight.bold),),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Upto Rs 5',style: TextStyle(color: Colors.purple[700],fontSize: 16),),
                                    Checkbox(
                                      checkColor: bgcolor,
                                      fillColor: MaterialStateProperty.resolveWith(getColor1),
                                      value: checkedValue,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          checkedValue = value!;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Rs 5 to Rs 15',style: TextStyle(color: Colors.purple[700],fontSize: 16),),
                                    Checkbox(
                                      checkColor: bgcolor,
                                      fillColor: MaterialStateProperty.resolveWith(getColor2),
                                      value: checkedValue,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          checkedValue = value!;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('More than Rs 15',style: TextStyle(color: Colors.purple[700],fontSize: 16),),
                                    Checkbox(
                                      checkColor: bgcolor,
                                      fillColor: MaterialStateProperty.resolveWith(getColor3),
                                      value: checkedValue,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          checkedValue = value!;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text('Price',style: TextStyle(color: Colors.purple[700],fontSize: 18,fontWeight: FontWeight.bold),),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Less than Rs 20',style: TextStyle(color: Colors.purple[700],fontSize: 16),),
                                    Checkbox(
                                      checkColor: bgcolor,
                                      fillColor: MaterialStateProperty.resolveWith(getColor4),
                                      value: checkedValue,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          checkedValue = value!;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Rs 20 to Rs 100',style: TextStyle(color: Colors.purple[700],fontSize: 16),),
                                    Checkbox(
                                      checkColor: bgcolor,
                                      fillColor: MaterialStateProperty.resolveWith(getColor5),
                                      value: checkedValue,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          checkedValue = value!;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Rs 101 to Rs 300',style: TextStyle(color: Colors.purple[700],fontSize: 16),),
                                    Checkbox(
                                      checkColor: bgcolor,
                                      fillColor: MaterialStateProperty.resolveWith(getColor6),
                                      value: checkedValue,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          checkedValue = value!;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('More than Rs 301',style: TextStyle(color: Colors.purple[700],fontSize: 16),),
                                    Checkbox(
                                      checkColor: bgcolor,
                                      fillColor: MaterialStateProperty.resolveWith(getColor7),
                                      value: checkedValue,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          checkedValue = value!;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text('Product Rating',style: TextStyle(color: Colors.purple[700],fontSize: 18,fontWeight: FontWeight.bold),),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.star,color: Colors.purple[700],size: 14,),
                                        Icon(Icons.star,color: Colors.purple[700],size: 14,),
                                        Icon(Icons.star,color: Colors.purple[700],size: 14,),
                                        Icon(Icons.star,color: Colors.purple[700],size: 14,),
                                      ],
                                    ),
                                    Checkbox(
                                      checkColor: bgcolor,
                                      fillColor: MaterialStateProperty.resolveWith(getColor6),
                                      value: checkedValue,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          checkedValue = value!;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.star,color: Colors.purple,size: 14,),
                                        Icon(Icons.star,color: Colors.purple,size: 14,),
                                        Icon(Icons.star,color: Colors.purple,size: 14,),
                                      ],
                                    ),
                                    Checkbox(
                                      checkColor: bgcolor,
                                      fillColor: MaterialStateProperty.resolveWith(getColor7),
                                      value: checkedValue,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          checkedValue = value!;
                                        });
                                      },
                                    ),
                                  ],
                                ),

                              ],
                            )) :
                        Container(
                            padding: EdgeInsets.all(40.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Price - Low to High',style: TextStyle(color: yellow,fontSize: 14),),
                                        Checkbox(
                                          checkColor: bgcolor,
                                          shape: CircleBorder(),
                                          fillColor: MaterialStateProperty.resolveWith(getColor1),
                                          value: checkedValue,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              checkedValue = value!;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Price - High to Low',style: TextStyle(color: yellow,fontSize: 14),),
                                        Checkbox(
                                          checkColor: bgcolor,
                                          shape: CircleBorder(),
                                          fillColor: MaterialStateProperty.resolveWith(getColor2),
                                          value: checkedValue,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              checkedValue = value!;
                                            });
                                          },
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            )
                        ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: Navigate(),
          );
        }
        ),
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
        color: bgcolor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children:[
                  Expanded(
                    child: ElevatedButton(
                      onPressed: (){
                       // Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
                      },
                      child: Text('APPLY',style: TextStyle(color: Colors.white),),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.purple[600]),
                          padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 15)),
                          textStyle: MaterialStateProperty.all(TextStyle(fontSize: 18))),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: null,
                child: Text('Reset Filter',style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w500),),
              ),
            ),
            SizedBox(
              height: 40,
            ),
          ],
        )
    );
  }
}