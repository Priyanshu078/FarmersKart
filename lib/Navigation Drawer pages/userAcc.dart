import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shellcode2/colors.dart';
import 'package:image_picker/image_picker.dart';

class UserAcc extends StatefulWidget {
  const UserAcc({Key? key}) : super(key: key);

  @override
  _UserAccState createState() => _UserAccState();
}
final ImagePicker _picker = ImagePicker();
XFile? _imageFile;

class _UserAccState extends State<UserAcc> {
  final _textController = TextEditingController();
  Future pickImage() async{
    final XFile? photo = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile= photo;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar:  AppBar(
        toolbarHeight: 100,
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 45,
              ),
              Text('User Name',style: TextStyle(color: Colors.orangeAccent,fontSize: 20),),
              SizedBox(
                height: 15,
              ),
              TextField(
                  cursorColor: Colors.purple,
                controller: _textController,
                decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey),
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey),
                    ),
                  hintStyle: TextStyle( color: Colors. purple, ),
                  hintText: 'name',
                    labelStyle: new TextStyle(
                        color: Colors.purple
                    )
              )
              ),
              SizedBox(
                height: 15,
              ),
              Text('Society Name',style: TextStyle(color: Colors.orangeAccent,fontSize: 20),),
              SizedBox(
                height: 15,
              ),
              TextField(
                  cursorColor: Colors.purple,
                  controller: _textController,
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueGrey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueGrey),
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueGrey),
                      ),
                      hintStyle: TextStyle( color: Colors. purple, ),
                      hintText: 'name',
                      labelStyle: new TextStyle(
                          color: Colors.purple
                      )
                  )
              ),
              SizedBox(
                height: 15,
              ),
              Text('Email ID',style: TextStyle(color: Colors.orangeAccent,fontSize: 20),),
              SizedBox(
                height: 15,
              ),
              TextField(
                  cursorColor: Colors.purple,
                  controller: _textController,
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueGrey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueGrey),
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueGrey),
                      ),
                      hintStyle: TextStyle( color: Colors. purple, ),
                      hintText: 'ID',
                      labelStyle: new TextStyle(
                          color: Colors.purple
                      )
                  )
              ),
              SizedBox(
                height: 15,
              ),
              Text('Mobile No',style: TextStyle(color: Colors.orangeAccent,fontSize: 20),),
              SizedBox(
                height: 15,
              ),
              TextField(
                  cursorColor: Colors.purple,
                  controller: _textController,
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueGrey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueGrey),
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueGrey),
                      ),
                      hintStyle: TextStyle( color: Colors. purple, ),
                      hintText: 'no',
                      labelStyle: new TextStyle(
                          color: Colors.purple
                      )
                  )
              ),
              SizedBox(
                height: 15,
              ),
              Text('Address',style: TextStyle(color: Colors.orangeAccent,fontSize: 20),),
              SizedBox(
                height: 15,
              ),
              TextField(
                  cursorColor: Colors.purple,
                  controller: _textController,
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueGrey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueGrey),
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueGrey),
                      ),
                      hintStyle: TextStyle( color: Colors. purple, ),
                      hintText: 'Address',
                      labelStyle: new TextStyle(
                          color: Colors.purple
                      )
                  )
              ),
              SizedBox(
                height: 15,
              ),
              Text('Flat No',style: TextStyle(color: Colors.orangeAccent,fontSize: 20),),
              SizedBox(
                height: 15,
              ),
              TextField(
                  cursorColor: Colors.purple,
                  controller: _textController,
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueGrey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueGrey),
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueGrey),
                      ),
                      hintStyle: TextStyle( color: Colors. purple, ),
                      hintText: 'no',
                      labelStyle: new TextStyle(
                          color: Colors.purple
                      )
                  )
              ),
              SizedBox(
                height: 15,
              ),
              Text('Wing',style: TextStyle(color: Colors.orangeAccent,fontSize: 20),),
              SizedBox(
                height: 15,
              ),
              TextField(
                  cursorColor: Colors.purple,
                  controller: _textController,
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueGrey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueGrey),
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueGrey),
                      ),
                      hintStyle: TextStyle( color: Colors. purple, ),
                      hintText: 'name',
                      labelStyle: new TextStyle(
                          color: Colors.purple
                      )
                  )
              ),
              SizedBox(
                height: 15,
              ),
              Text('Pincode',style: TextStyle(color: Colors.orangeAccent,fontSize: 20),),
              SizedBox(
                height: 15,
              ),
              TextField(
                  cursorColor: Colors.purple,
                  controller: _textController,
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueGrey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueGrey),
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueGrey),
                      ),
                      hintStyle: TextStyle( color: Colors. purple, ),
                      hintText: 'code',
                      labelStyle: new TextStyle(
                          color: Colors.purple
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

/*
/*
Stack(
                children: [
                  Positioned(
                    top: 80,
                    left: 80,
                    child:
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey
                      ),
                      child:  _imageFile==null?Container(): Image.file(File(_imageFile!.path),filterQuality: FilterQuality.high,),
                    ),
                  ),
                  Positioned(
                    top: 500,
                    left: 200,
                    child: IconButton(
                      onPressed: (){
                        pickImage();
                      },
                      icon: Icon(CupertinoIcons.photo),color: Colors.blueGrey,) ,
                  ),
                ],
              ),
 */
 */