import 'package:flutter/material.dart';
import 'package:shellcode2/colors.dart';

class UserAcc extends StatefulWidget {
  const UserAcc({Key? key}) : super(key: key);

  @override
  _UserAccState createState() => _UserAccState();
}

class _UserAccState extends State<UserAcc> {
  final _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar:  AppBar(
        centerTitle: true,
        titleSpacing: 0.0,
        elevation: 0,
        //brightness: Brightness.light,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [left,middle,Colors.purple]
              )
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios,
              size: 20,
              color: yellow),
        ),
        title: Text('User Account',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 18,
            color: Colors.white,
          ),),

      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('User Name',style: TextStyle(color: Colors.orangeAccent,fontSize: 20),),
              SizedBox(
                height: 15,
              ),
              TextField(
                  cursorColor: Colors.purpleAccent,
                controller: _textController,
                decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.purpleAccent),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple),
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple),
                    ),
                  hintStyle: TextStyle( color: Colors. purple, ),
                  hintText: 'name',
                    labelStyle: new TextStyle(
                        color: Colors.purpleAccent
                    )
              )
              ),
              SizedBox(
                height: 15,
              ),
              Text('User Name',style: TextStyle(color: Colors.orangeAccent,fontSize: 20),),
              SizedBox(
                height: 15,
              ),
              TextField(
                  cursorColor: Colors.purpleAccent,
                  controller: _textController,
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.purpleAccent),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple),
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple),
                      ),
                      hintStyle: TextStyle( color: Colors. purple, ),
                      hintText: 'name',
                      labelStyle: new TextStyle(
                          color: Colors.purpleAccent
                      )
                  )
              ),
              SizedBox(
                height: 15,
              ),
              Text('User Name',style: TextStyle(color: Colors.orangeAccent,fontSize: 20),),
              SizedBox(
                height: 15,
              ),
              TextField(
                  cursorColor: Colors.purpleAccent,
                  controller: _textController,
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.purpleAccent),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple),
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple),
                      ),
                      hintStyle: TextStyle( color: Colors. purple, ),
                      hintText: 'name',
                      labelStyle: new TextStyle(
                          color: Colors.purpleAccent
                      )
                  )
              ),
              SizedBox(
                height: 15,
              ),
              Text('User Name',style: TextStyle(color: Colors.orangeAccent,fontSize: 20),),
              SizedBox(
                height: 15,
              ),
              TextField(
                  cursorColor: Colors.purpleAccent,
                  controller: _textController,
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.purpleAccent),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple),
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple),
                      ),
                      hintStyle: TextStyle( color: Colors. purple, ),
                      hintText: 'name',
                      labelStyle: new TextStyle(
                          color: Colors.purpleAccent
                      )
                  )
              ),
              SizedBox(
                height: 15,
              ),
              Text('User Name',style: TextStyle(color: Colors.orangeAccent,fontSize: 20),),
              SizedBox(
                height: 15,
              ),
              TextField(
                  cursorColor: Colors.purpleAccent,
                  controller: _textController,
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.purpleAccent),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple),
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple),
                      ),
                      hintStyle: TextStyle( color: Colors. purple, ),
                      hintText: 'name',
                      labelStyle: new TextStyle(
                          color: Colors.purpleAccent
                      )
                  )
              ),
              SizedBox(
                height: 15,
              ),
              Text('User Name',style: TextStyle(color: Colors.orangeAccent,fontSize: 20),),
              SizedBox(
                height: 15,
              ),
              TextField(
                  cursorColor: Colors.purpleAccent,
                  controller: _textController,
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.purpleAccent),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple),
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple),
                      ),
                      hintStyle: TextStyle( color: Colors. purple, ),
                      hintText: 'name',
                      labelStyle: new TextStyle(
                          color: Colors.purpleAccent
                      )
                  )
              ),
              SizedBox(
                height: 15,
              ),
              Text('User Name',style: TextStyle(color: Colors.orangeAccent,fontSize: 20),),
              SizedBox(
                height: 15,
              ),
              TextField(
                  cursorColor: Colors.purpleAccent,
                  controller: _textController,
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.purpleAccent),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple),
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple),
                      ),
                      hintStyle: TextStyle( color: Colors. purple, ),
                      hintText: 'name',
                      labelStyle: new TextStyle(
                          color: Colors.purpleAccent
                      )
                  )
              ),
              SizedBox(
                height: 15,
              ),
              Text('User Name',style: TextStyle(color: Colors.orangeAccent,fontSize: 20),),
              SizedBox(
                height: 15,
              ),
              TextField(
                  cursorColor: Colors.purpleAccent,
                  controller: _textController,
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.purpleAccent),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple),
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple),
                      ),
                      hintStyle: TextStyle( color: Colors. purple, ),
                      hintText: 'name',
                      labelStyle: new TextStyle(
                          color: Colors.purpleAccent
                      )
                  )
              ),
              SizedBox(
                height: 25,
              ),
              GestureDetector(
                onTap: (){

                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Colors.purple
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text('UPDATE', style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      letterSpacing: 1,
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
}
