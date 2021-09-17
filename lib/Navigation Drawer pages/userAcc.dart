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

class _UserAccState extends State<UserAcc> {
  final ImagePicker _picker = ImagePicker();
  XFile _imageFile;
  Dio dio = new Dio();
  Future pickImage() async {
    final XFile photo = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = photo;
      if (_imageFile != null) {
        Provider.of<APIData>(context, listen: false)
            .initailizeImage(_imageFile.name);
      }

      // print(Provider.of<APIData>(context, listen: false).image);
      print(_imageFile.path);
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
    String url = "$header/app_api/updateProfile.php?apicall=uploadpic";
    String userId = Provider.of<APIData>(context, listen: false).user.id;
    var formData = new FormData.fromMap({
      'name': nameController.text,
      'society_name': societyController.text,
      'email': emailController.text,
      'user_id': userId,
      'address': addressController.text,
      'image_name': _imageFile != null ? _imageFile.name : '',
      'pincode': pincodeController.text,
      'gst_no': '',
      'wing': wingController.text,
      'flat_no': flatController.text,
      'phoneNo': phoneController.text,
    });
    http.StreamedResponse responseImage;
    if (_imageFile != null) {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.files.add(http.MultipartFile(
          'pic',
          File(_imageFile.path).readAsBytes().asStream(),
          File(_imageFile.path).lengthSync(),
          filename: _imageFile.path));
      responseImage = await request.send();
      print(responseImage.statusCode);
    }
    var responseData = await dio.post(url,
        data: formData,
        options: Options(headers: {
          "Accept": "application/json",
          "Content-Type": "multipart/form-data"
        }));
    print(responseData.statusCode);
    if (_imageFile != null) {
      if (responseData.statusCode == 200 && responseImage.statusCode == 200) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Updated Successfully")));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Something Went Wrong")));
      }
    } else {
      if (responseData.statusCode == 200) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Updated Successfully")));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Updated Successfully")));
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text = Provider.of<APIData>(context, listen: false).name;
    societyController.text =
        Provider.of<APIData>(context, listen: false).societyName;
    emailController.text = Provider.of<APIData>(context, listen: false).email;
    phoneController.text = Provider.of<APIData>(context, listen: false).mobile;
    addressController.text =
        Provider.of<APIData>(context, listen: false).address;
    flatController.text = Provider.of<APIData>(context, listen: false).flat;
    wingController.text = Provider.of<APIData>(context, listen: false).wing;
    pincodeController.text =
        Provider.of<APIData>(context, listen: false).pincode;
  }

  @override
  Widget build(BuildContext context) {
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
              Align(
                alignment: Alignment.topCenter,
                child: Stack(
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.grey),
                      child: _imageFile == null
                          ? Image.file(
                              File(
                                  "http://localhost/app_api/files/${Provider.of<APIData>(context, listen: false).image}"),
                              filterQuality: FilterQuality.high,
                            )
                          : Image.file(
                              File(_imageFile.path),
                              filterQuality: FilterQuality.high,
                            ),
                    ),
                    Positioned(
                      height: 175,
                      width: 175,
                      child: IconButton(
                        iconSize: 25,
                        splashColor: Colors.grey,
                        highlightColor: Colors.grey,
                        onPressed: () {
                          pickImage();
                        },
                        icon: Icon(CupertinoIcons.photo),
                        color: Colors.blueGrey,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 45,
              ),
              TextField(
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
                    labelStyle: new TextStyle(color: Colors.purple)),
                onChanged: (value) {},
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
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
                      labelStyle: new TextStyle(color: Colors.purple))),
              SizedBox(
                height: 15,
              ),
              TextField(
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
                      labelStyle: new TextStyle(color: Colors.purple))),
              SizedBox(
                height: 15,
              ),
              TextField(
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
                      labelStyle: new TextStyle(color: Colors.purple))),
              SizedBox(
                height: 15,
              ),
              TextField(
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
                      labelStyle: new TextStyle(color: Colors.purple))),
              SizedBox(
                height: 15,
              ),
              TextField(
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
                      labelStyle: new TextStyle(color: Colors.purple))),
              SizedBox(
                height: 15,
              ),
              TextField(
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
                      labelStyle: new TextStyle(color: Colors.purple))),
              SizedBox(
                height: 15,
              ),
              TextField(
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
                      labelStyle: new TextStyle(color: Colors.purple))),
              SizedBox(
                height: 25,
              ),
              GestureDetector(
                onTap: () {
                  if (_imageFile != null) {
                    Provider.of<APIData>(context, listen: false)
                        .initailizeImage(_imageFile.name.toString());
                  }
                  Provider.of<APIData>(context, listen: false)
                      .initializeName(nameController.text);
                  Provider.of<APIData>(context, listen: false)
                      .initializeSocietyName(societyController.text);
                  Provider.of<APIData>(context, listen: false)
                      .initializeEmail(emailController.text);
                  Provider.of<APIData>(context, listen: false)
                      .initializeMobileNo(phoneController.text);
                  Provider.of<APIData>(context, listen: false)
                      .initializeAddress(addressController.text);
                  Provider.of<APIData>(context, listen: false)
                      .initializeFlatNo(flatController.text);
                  Provider.of<APIData>(context, listen: false)
                      .initializeWing(wingController.text);
                  Provider.of<APIData>(context, listen: false)
                      .initializePincode(pincodeController.text);
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
