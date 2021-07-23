import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shellcode2/colors.dart';

class Wallet extends StatefulWidget {
  const Wallet({Key? key}) : super(key: key);

  @override
  _WalletState createState() => _WalletState();
}
String selectedChoice = "";
class _WalletState extends State<Wallet> {
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
        title: Text('Wallet',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 18,
            color: Colors.white,
          ),),

      ),
      body: Container(
        padding: EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Farmers Kart Wallet',style: TextStyle(color: Colors.purpleAccent,fontSize: 18,fontWeight: FontWeight.bold,letterSpacing: 0.8),),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      children: [
                        Text(' ₹ ',style: TextStyle(color: Colors.deepPurpleAccent,fontSize: 18,fontWeight: FontWeight.bold,letterSpacing: 0.8),),
                        Text('74',style: TextStyle(color: Colors.deepPurpleAccent[100],fontSize: 18,fontWeight: FontWeight.bold,letterSpacing: 0.8),)
                      ],
                    )

                  ],
                ),
                CircleAvatar(
                  maxRadius: 30,
                  backgroundColor: Colors.orange.withOpacity(0.5),
                  child: Icon(Icons.account_balance_wallet_outlined,color: Colors.white,size: 35,),
                ),

              ],
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(' ₹ ',style: TextStyle(color: Colors.deepPurpleAccent,fontSize: 18,fontWeight: FontWeight.bold,letterSpacing: 0.8),),
                    Text('0',style: TextStyle(color: Colors.deepPurpleAccent[100],fontSize: 18,fontWeight: FontWeight.bold,letterSpacing: 0.8),)
                  ],
                ),
                GestureDetector(
                  onTap: (){

                  },
                  child: Container(
                    height: 50,
                    width: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.purple
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text('ADD MONEY', style: TextStyle(
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
            SizedBox(
              height: 20,
            ),
            Divider(
              color: Colors.greenAccent,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: const EdgeInsets.all(3.0),
                  child: ChoiceChip(
                    label: Text('   Debit Amount   '),
                    labelStyle: TextStyle(
                        color: Colors.white, fontSize: 12.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    backgroundColor: Colors.yellow[800],
                    selectedColor: Colors.deepOrangeAccent.withOpacity(0.9),
                    selected: selectedChoice == 'Debit Amount',
                    onSelected: (selected) {
                      setState(() {
                        selectedChoice = 'Debit Amount';
                      });
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(3.0),
                  child: ChoiceChip(
                    label: Text('   Credit Amount   '),
                    labelStyle: TextStyle(
                        color: Colors.white, fontSize: 12.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    backgroundColor: Colors.yellow[800],
                    selectedColor: Colors.deepOrangeAccent.withOpacity(0.9),
                    selected: selectedChoice == 'Credit Amount',
                    onSelected: (selected) {
                      setState(() {
                        selectedChoice = 'Credit Amount';
                      });
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
