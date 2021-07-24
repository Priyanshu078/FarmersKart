import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shellcode2/Authentication%20pages/otpverification.dart';
import 'package:shellcode2/colors.dart';

class SSH extends StatefulWidget {
  int ind;
  SSH(this.ind){
    index=ind;
  }
  @override
  _SSHState createState() => _SSHState();
}
int index=0;
class _SSHState extends State<SSH> {
  final phoneController1 = TextEditingController();
  final phoneController2 = TextEditingController();
  final phoneController3 = TextEditingController();
  final phoneController4 = TextEditingController();
  final phoneController5 = TextEditingController();
  final phoneController6 = TextEditingController();
  final phoneController7 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightbg,
      appBar: AppBar(
      centerTitle: true,
      titleSpacing: 0.0,
      elevation: 0,
        automaticallyImplyLeading: false,
      flexibleSpace: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [left,middle,Colors.purple]
            )
        ),
      ),
      title: index==0? Text('Society',
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 18,
          color: Colors.white,
        ),):index==1?Text('Shop',
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 18,
          color: Colors.white,
        ),):Text('Hotel',
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 18,
          color: Colors.white,
        ),),

    ),
      body: Container(
        child: index==0?Container(
          padding: EdgeInsets.only(left: 30,right: 30,top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              MaterialButton(
                minWidth: double.infinity,
                height: 50,
                onPressed: null,
                //() {
                // Navigator.push(context,
                //   MaterialPageRoute(builder: (context) => login2()));
                //},
                color: bgcolor,
                elevation: 0,
                disabledColor: bgcolor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: phoneController1,
                  style: TextStyle(
                      height: 1.5,color: Colors.purple
                  ),
                  cursorColor: Colors.purpleAccent,
                  decoration: InputDecoration(
                    hintText: "Society Name",
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintStyle: Theme.of(context).textTheme.caption!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: yellow, // Set Your Own Color
                    ),
                  ),
                  onChanged: null,
                ), //fontSize: 12,color: tertiaryColor,fontWeight: FontWeight.w400,
              ),
              SizedBox(
                height: 10,
              ),
              MaterialButton(
                minWidth: double.infinity,
                height: 50,
                onPressed: null,
                //() {
                // Navigator.push(context,
                //   MaterialPageRoute(builder: (context) => login2()));
                //},
                color: bgcolor,
                elevation: 0,
                disabledColor: bgcolor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: phoneController2,
                  style: TextStyle(
                      height: 1.5,color: Colors.purple
                  ),
                  cursorColor: Colors.purpleAccent,
                  decoration: InputDecoration(
                    hintText: "Flat No",
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintStyle: Theme.of(context).textTheme.caption!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: yellow, // Set Your Own Color
                    ),
                  ),
                  onChanged: null
                ), //fontSize: 12,color: tertiaryColor,fontWeight: FontWeight.w400,
              ),
              SizedBox(
                height: 10,
              ),
              MaterialButton(
                minWidth: double.infinity,
                height: 50,
                onPressed: null,
                //() {
                // Navigator.push(context,
                //   MaterialPageRoute(builder: (context) => login2()));
                //},
                color: bgcolor,
                elevation: 0,
                disabledColor: bgcolor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: phoneController3,
                  style: TextStyle(
                      height: 1.5,color: Colors.purple
                  ),
                  cursorColor: Colors.purpleAccent,
                  decoration: InputDecoration(
                    hintText: "Wing",
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintStyle: Theme.of(context).textTheme.caption!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: yellow, // Set Your Own Color
                    ),
                  ),
                  onChanged: null,
                ), //fontSize: 12,color: tertiaryColor,fontWeight: FontWeight.w400,
              ),
              SizedBox(
                height: 10,
              ),
              MaterialButton(
                minWidth: double.infinity,
                height: 50,
                onPressed: null,
                //() {
                // Navigator.push(context,
                //   MaterialPageRoute(builder: (context) => login2()));
                //},
                color: bgcolor,
                elevation: 0,
                disabledColor: bgcolor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: phoneController4,
                  style: TextStyle(
                      height: 1.5,color: Colors.purple
                  ),
                  cursorColor: Colors.purpleAccent,
                  decoration: InputDecoration(
                    hintText: "Address / Area",
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintStyle: Theme.of(context).textTheme.caption!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: yellow, // Set Your Own Color
                    ),
                  ),
                  onChanged: null,
                ), //fontSize: 12,color: tertiaryColor,fontWeight: FontWeight.w400,
              ),
              SizedBox(
                height: 10,
              ),
              MaterialButton(
                minWidth: double.infinity,
                height: 50,
                onPressed: null,
                //() {
                // Navigator.push(context,
                //   MaterialPageRoute(builder: (context) => login2()));
                //},
                color: bgcolor,
                elevation: 0,
                disabledColor: bgcolor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: phoneController5,
                  style: TextStyle(
                      height: 1.5,color: Colors.purple
                  ),
                  cursorColor: Colors.purpleAccent,
                  decoration: InputDecoration(
                    hintText: "Pincode",
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintStyle: Theme.of(context).textTheme.caption!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: yellow, // Set Your Own Color
                    ),
                  ),
                  onChanged: null,
                ), //fontSize: 12,color: tertiaryColor,fontWeight: FontWeight.w400,
              ),
              SizedBox(
                height: 10,
              ),
              MaterialButton(
                minWidth: double.infinity,
                height: 50,
                onPressed: null,
                //() {
                // Navigator.push(context,
                //   MaterialPageRoute(builder: (context) => login2()));
                //},
                color: bgcolor,
                elevation: 0,
                disabledColor: bgcolor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: phoneController6,
                  style: TextStyle(
                      height: 1.5,color: Colors.purple
                  ),
                  cursorColor: Colors.purpleAccent,
                  decoration: InputDecoration(
                    hintText: "Password",
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintStyle: Theme.of(context).textTheme.caption!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: yellow, // Set Your Own Color
                    ),
                  ),
                  onChanged: null,
                ), //fontSize: 12,color: tertiaryColor,fontWeight: FontWeight.w400,
              ),
              SizedBox(
                height: 10,
              ),
              MaterialButton(
                minWidth: double.infinity,
                height: 50,
                onPressed: null,
                //() {
                // Navigator.push(context,
                //   MaterialPageRoute(builder: (context) => login2()));
                //},
                color: bgcolor,
                elevation: 0,
                disabledColor: bgcolor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: phoneController7,
                  style: TextStyle(
                      height: 1.5,color: Colors.purple
                  ),
                  cursorColor: Colors.purpleAccent,
                  decoration: InputDecoration(
                    hintText: "Confirm Password",
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintStyle: Theme.of(context).textTheme.caption!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: yellow, // Set Your Own Color
                    ),
                  ),
                  onChanged: null,
                ), //fontSize: 12,color: tertiaryColor,fontWeight: FontWeight.w400,
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                children:[
                Expanded(
                child: ElevatedButton(
                  onPressed: null,
                  child: Text('SUBMIT',style: TextStyle(color: Colors.white),),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.purple[600]),
                      padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 15)),
                      textStyle: MaterialStateProperty.all(TextStyle(fontSize: 18))),
                ),
              ),
            ],
          ),
          ],
        ),
        ):index==1?Container(
          padding: EdgeInsets.only(left: 30,right: 30,top: 10),
          child: Column(
            children: [
              MaterialButton(
                minWidth: double.infinity,
                height: 50,
                onPressed: null,
                //() {
                // Navigator.push(context,
                //   MaterialPageRoute(builder: (context) => login2()));
                //},
                color: bgcolor,
                elevation: 0,
                disabledColor: bgcolor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                    controller: phoneController2,
                    style: TextStyle(
                        height: 1.5,color: Colors.purple
                    ),
                    cursorColor: Colors.purpleAccent,
                    decoration: InputDecoration(
                      hintText: "Shop Name",
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintStyle: Theme.of(context).textTheme.caption!.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: yellow, // Set Your Own Color
                      ),
                    ),
                    onChanged: null
                ), //fontSize: 12,color: tertiaryColor,fontWeight: FontWeight.w400,
              ),
              SizedBox(
                height: 10,
              ),
              MaterialButton(
                minWidth: double.infinity,
                height: 50,
                onPressed: null,
                //() {
                // Navigator.push(context,
                //   MaterialPageRoute(builder: (context) => login2()));
                //},
                color: bgcolor,
                elevation: 0,
                disabledColor: bgcolor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: phoneController3,
                  style: TextStyle(
                      height: 1.5,color: Colors.purple
                  ),
                  cursorColor: Colors.purpleAccent,
                  decoration: InputDecoration(
                    hintText: "Address / Area",
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintStyle: Theme.of(context).textTheme.caption!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: yellow, // Set Your Own Color
                    ),
                  ),
                  onChanged: null,
                ), //fontSize: 12,color: tertiaryColor,fontWeight: FontWeight.w400,
              ),
              SizedBox(
                height: 10,
              ),
              MaterialButton(
                minWidth: double.infinity,
                height: 50,
                onPressed: null,
                //() {
                // Navigator.push(context,
                //   MaterialPageRoute(builder: (context) => login2()));
                //},
                color: bgcolor,
                elevation: 0,
                disabledColor: bgcolor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: phoneController4,
                  style: TextStyle(
                      height: 1.5,color: Colors.purple
                  ),
                  cursorColor: Colors.purpleAccent,
                  decoration: InputDecoration(
                    hintText: "Pincode",
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintStyle: Theme.of(context).textTheme.caption!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: yellow, // Set Your Own Color
                    ),
                  ),
                  onChanged: null,
                ), //fontSize: 12,color: tertiaryColor,fontWeight: FontWeight.w400,
              ),
              SizedBox(
                height: 10,
              ),
              MaterialButton(
                minWidth: double.infinity,
                height: 50,
                onPressed: null,
                //() {
                // Navigator.push(context,
                //   MaterialPageRoute(builder: (context) => login2()));
                //},
                color: bgcolor,
                elevation: 0,
                disabledColor: bgcolor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: phoneController5,
                  style: TextStyle(
                      height: 1.5,color: Colors.purple
                  ),
                  cursorColor: Colors.purpleAccent,
                  decoration: InputDecoration(
                    hintText: "GST No",
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintStyle: Theme.of(context).textTheme.caption!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: yellow, // Set Your Own Color
                    ),
                  ),
                  onChanged: null,
                ), //fontSize: 12,color: tertiaryColor,fontWeight: FontWeight.w400,
              ),
              SizedBox(
                height: 10,
              ),
              MaterialButton(
                minWidth: double.infinity,
                height: 50,
                onPressed: null,
                //() {
                // Navigator.push(context,
                //   MaterialPageRoute(builder: (context) => login2()));
                //},
                color: bgcolor,
                elevation: 0,
                disabledColor: bgcolor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: phoneController6,
                  style: TextStyle(
                      height: 1.5,color: Colors.purple
                  ),
                  cursorColor: Colors.purpleAccent,
                  decoration: InputDecoration(
                    hintText: "Password",
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintStyle: Theme.of(context).textTheme.caption!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: yellow, // Set Your Own Color
                    ),
                  ),
                  onChanged: null,
                ), //fontSize: 12,color: tertiaryColor,fontWeight: FontWeight.w400,
              ),
              SizedBox(
                height: 10,
              ),
              MaterialButton(
                minWidth: double.infinity,
                height: 50,
                onPressed: null,
                //() {
                // Navigator.push(context,
                //   MaterialPageRoute(builder: (context) => login2()));
                //},
                color: bgcolor,
                elevation: 0,
                disabledColor: bgcolor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: phoneController7,
                  style: TextStyle(
                      height: 1.5,color: Colors.purple
                  ),
                  cursorColor: Colors.purpleAccent,
                  decoration: InputDecoration(
                    hintText: "Confirm Password",
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintStyle: Theme.of(context).textTheme.caption!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: yellow, // Set Your Own Color
                    ),
                  ),
                  onChanged: null,
                ), //fontSize: 12,color: tertiaryColor,fontWeight: FontWeight.w400,
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                children:[
                  Expanded(
                    child: ElevatedButton(
                      onPressed: (){
                        Navigator.push(context,MaterialPageRoute(builder: (context) => OtpVerification()));
                      },
                      child: Text('PROCEED',style: TextStyle(color: Colors.white),),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.purple[600]),
                          padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 15)),
                          textStyle: MaterialStateProperty.all(TextStyle(fontSize: 18))),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ):Container(
          padding: EdgeInsets.only(left: 30,right: 30,top: 10),
          child: Column(
            children: [
              MaterialButton(
                minWidth: double.infinity,
                height: 50,
                onPressed: null,
                //() {
                // Navigator.push(context,
                //   MaterialPageRoute(builder: (context) => login2()));
                //},
                color: bgcolor,
                elevation: 0,
                disabledColor: bgcolor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                    controller: phoneController2,
                    style: TextStyle(
                        height: 1.5,color: Colors.purple
                    ),
                    cursorColor: Colors.purpleAccent,
                    decoration: InputDecoration(
                      hintText: "Hotel Name",
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintStyle: Theme.of(context).textTheme.caption!.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: yellow, // Set Your Own Color
                      ),
                    ),
                    onChanged: null
                ), //fontSize: 12,color: tertiaryColor,fontWeight: FontWeight.w400,
              ),
              SizedBox(
                height: 10,
              ),
              MaterialButton(
                minWidth: double.infinity,
                height: 50,
                onPressed: null,
                //() {
                // Navigator.push(context,
                //   MaterialPageRoute(builder: (context) => login2()));
                //},
                color: bgcolor,
                elevation: 0,
                disabledColor: bgcolor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: phoneController3,
                  style: TextStyle(
                      height: 1.5,color: Colors.purple
                  ),
                  cursorColor: Colors.purpleAccent,
                  decoration: InputDecoration(
                    hintText: "Address / Area",
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintStyle: Theme.of(context).textTheme.caption!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: yellow, // Set Your Own Color
                    ),
                  ),
                  onChanged: null,
                ), //fontSize: 12,color: tertiaryColor,fontWeight: FontWeight.w400,
              ),
              SizedBox(
                height: 10,
              ),
              MaterialButton(
                minWidth: double.infinity,
                height: 50,
                onPressed: null,
                //() {
                // Navigator.push(context,
                //   MaterialPageRoute(builder: (context) => login2()));
                //},
                color: bgcolor,
                elevation: 0,
                disabledColor: bgcolor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: phoneController4,
                  style: TextStyle(
                      height: 1.5,color: Colors.purple
                  ),
                  cursorColor: Colors.purpleAccent,
                  decoration: InputDecoration(
                    hintText: "Pincode",
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintStyle: Theme.of(context).textTheme.caption!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: yellow, // Set Your Own Color
                    ),
                  ),
                  onChanged: null,
                ), //fontSize: 12,color: tertiaryColor,fontWeight: FontWeight.w400,
              ),
              SizedBox(
                height: 10,
              ),
              MaterialButton(
                minWidth: double.infinity,
                height: 50,
                onPressed: null,
                //() {
                // Navigator.push(context,
                //   MaterialPageRoute(builder: (context) => login2()));
                //},
                color: bgcolor,
                elevation: 0,
                disabledColor: bgcolor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: phoneController6,
                  style: TextStyle(
                      height: 1.5,color: Colors.purple
                  ),
                  cursorColor: Colors.purpleAccent,
                  decoration: InputDecoration(
                    hintText: "Password",
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintStyle: Theme.of(context).textTheme.caption!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: yellow, // Set Your Own Color
                    ),
                  ),
                  onChanged: null,
                ), //fontSize: 12,color: tertiaryColor,fontWeight: FontWeight.w400,
              ),
              SizedBox(
                height: 10,
              ),
              MaterialButton(
                minWidth: double.infinity,
                height: 50,
                onPressed: null,
                //() {
                // Navigator.push(context,
                //   MaterialPageRoute(builder: (context) => login2()));
                //},
                color: bgcolor,
                elevation: 0,
                disabledColor: bgcolor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: phoneController7,
                  style: TextStyle(
                      height: 1.5,color: Colors.purple
                  ),
                  cursorColor: Colors.purpleAccent,
                  decoration: InputDecoration(
                    hintText: "Confirm Password",
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintStyle: Theme.of(context).textTheme.caption!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: yellow, // Set Your Own Color
                    ),
                  ),
                  onChanged: null,
                ), //fontSize: 12,color: tertiaryColor,fontWeight: FontWeight.w400,
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                children:[
                  Expanded(
                    child: ElevatedButton(
                      onPressed: (){
                        Navigator.push(context,MaterialPageRoute(builder: (context) => OtpVerification()));
                      },
                      child: Text('PROCEED',style: TextStyle(color: Colors.white),),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.purple[600]),
                          padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 15)),
                          textStyle: MaterialStateProperty.all(TextStyle(fontSize: 18))),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
