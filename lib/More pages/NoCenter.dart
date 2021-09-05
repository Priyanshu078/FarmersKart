import 'package:flutter/material.dart';
import 'package:shellcode2/Authentication%20pages/signinpage.dart';
import 'package:shellcode2/colors.dart';

class NoCenter extends StatelessWidget {
  @override


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: violet,
        title: Center(
          child: Text(
            'Farmers Kart'
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 4,
          ),
          Center(
            child: Image.asset(
              'assets/farmersKartLogo.png',
              height: 200,
              width: 200,
            ),
          ),

          Text('Dear Customer, we regret to inform  that in your society we are not serviceable as of now, we will notify you once we start deliveries'
              ' in your Society. For any queries feel free to call US on 8530529100.',style: TextStyle(
            fontSize: 22,color: yellow,
          ),),

          SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>SignIn()));
            },
            child: Container(
              padding: EdgeInsets.all(10.0),
              height: 38,
              width: 200,
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
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  ' GO TO LOGIN ',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
