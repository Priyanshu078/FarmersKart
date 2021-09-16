import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shellcode2/apiData/Constants.dart';
import 'package:shellcode2/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shellcode2/Provider/data.dart';
import 'package:shellcode2/apiData/loginApiData.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class UserAcc extends StatefulWidget {
  const UserAcc({Key key}) : super(key: key);

  @override
  _UserAccState createState() => _UserAccState();
}

final ImagePicker _picker = ImagePicker();
XFile _imageFile;

class _UserAccState extends State<UserAcc> {
  Future pickImage() async {
    final XFile photo = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = photo;
    });
  }

  TextEditingController nameController = new TextEditingController();
  TextEditingController societyController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController flatController = new TextEditingController();
  TextEditingController wingController = new TextEditingController();
  TextEditingController pincodeController = new TextEditingController();

  Future updateData() async {
    Dio dio = new Dio();
    String url = "$header/app_api/updateProfile.php?apicall=uploadpic";
    Uri uri = Uri.parse("$header/app_api/updateProfile.php?apicall=uploadpic");
    Map<String, dynamic> data = {
      "name": nameController.text,
      "society_name": societyController.text,
      "email": emailController.text,
      "address": addressController.text,
      "image_name": "",
      "pincode": pincodeController.text,
      "gst_no": "",
      "wing": wingController.text,
      "flat_no": flatController.text,
      "phoneNo": phoneController.text
    };
    // http.Response response = await http.post(
    //   url,
    //   headers: <String, String>{
    //     "Accept": "application/json",
    //     "Content-Type": "application/x-www-form-urlencoded"
    //   },
    //   encoding: Encoding.getByName('utf-8'),
    //   body: body,
    // );
    var response = await dio.post(url,
        data: data,
        options: Options(headers: {
          "Accept": "application/json",
          "Content-Type": "application/form-data"
        }));
    var jsonData = jsonDecode(response.data);
    print(jsonData);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _textController1.text = null;
  }

  @override
  Widget build(BuildContext context) {
    // _textController1 = TextEditingController(text: '${user.name}');
    // _textController2 = TextEditingController(text: '${user.societyName}');
    // _textController3 = TextEditingController(text: '${user.email}');
    // _textController4 = TextEditingController(text: '${user.mobile}');
    // _textController5 = TextEditingController(text: '${user.address}');
    // _textController6 = TextEditingController(text: '${user.flatNo}');
    // _textController7 = TextEditingController(text: '${user.wing}');
    // _textController8 = TextEditingController(text: '${user.pincode}');
    // print(user.pincode);
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        toolbarHeight: 100,
        centerTitle: true,
        titleSpacing: 0.0,
        elevation: 0,
        //brightness: Brightness.light,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [left, middle, Colors.purple])),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, size: 20, color: yellow),
        ),
        title: Text(
          'User Account',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
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
              Consumer<APIData>(builder: (context, data, child) {
                return TextField(
                  cursorColor: Colors.purple,
                  controller: nameController,
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
                      hintStyle: TextStyle(
                        color: Colors.purple,
                      ),
                      hintText: data.name.toString(),
                      labelStyle: new TextStyle(color: Colors.purple)),
                  onChanged: (value) {
                    // _textController1.text = value;
                  },
                );
              }),
              SizedBox(
                height: 15,
              ),
              Consumer<APIData>(builder: (context, data, child) {
                return TextField(
                    cursorColor: Colors.purple,
                    controller: societyController,
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
                        hintStyle: TextStyle(
                          color: Colors.purple,
                        ),
                        hintText: data.societyName.toString(),
                        labelStyle: new TextStyle(color: Colors.purple)));
              }),
              SizedBox(
                height: 15,
              ),
              Consumer<APIData>(builder: (context, data, child) {
                return TextField(
                    cursorColor: Colors.purple,
                    controller: emailController,
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
                        hintStyle: TextStyle(
                          color: Colors.purple,
                        ),
                        hintText: data.email.toString(),
                        labelStyle: new TextStyle(color: Colors.purple)));
              }),
              SizedBox(
                height: 15,
              ),
              Consumer<APIData>(builder: (context, data, child) {
                return TextField(
                    cursorColor: Colors.purple,
                    controller: phoneController,
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
                        hintStyle: TextStyle(
                          color: Colors.purple,
                        ),
                        hintText: data.mobile.toString(),
                        labelStyle: new TextStyle(color: Colors.purple)));
              }),
              SizedBox(
                height: 15,
              ),
              Consumer<APIData>(builder: (context, data, child) {
                return TextField(
                    cursorColor: Colors.purple,
                    controller: addressController,
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
                        hintStyle: TextStyle(
                          color: Colors.purple,
                        ),
                        hintText: data.address.toString(),
                        labelStyle: new TextStyle(color: Colors.purple)));
              }),
              SizedBox(
                height: 15,
              ),
              Consumer<APIData>(builder: (context, data, child) {
                return TextField(
                    cursorColor: Colors.purple,
                    controller: flatController,
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
                        hintStyle: TextStyle(
                          color: Colors.purple,
                        ),
                        hintText: data.flat.toString(),
                        labelStyle: new TextStyle(color: Colors.purple)));
              }),
              SizedBox(
                height: 15,
              ),
              Consumer<APIData>(builder: (context, data, child) {
                return TextField(
                    cursorColor: Colors.purple,
                    controller: wingController,
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
                        hintStyle: TextStyle(
                          color: Colors.purple,
                        ),
                        hintText: data.wing.toString(),
                        labelStyle: new TextStyle(color: Colors.purple)));
              }),
              SizedBox(
                height: 15,
              ),
              Consumer<APIData>(builder: (context, data, child) {
                return TextField(
                    cursorColor: Colors.purple,
                    controller: pincodeController,
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
                        hintStyle: TextStyle(
                          color: Colors.purple,
                        ),
                        hintText: data.pincode.toString(),
                        labelStyle: new TextStyle(color: Colors.purple)));
              }),
              SizedBox(
                height: 25,
              ),
              GestureDetector(
                onTap: () {
                  updateData();
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Colors.purple),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'UPDATE',
                      style: TextStyle(
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
