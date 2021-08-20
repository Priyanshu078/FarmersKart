import 'package:flutter/material.dart';
import 'package:shellcode2/Authentication%20pages/signinpage.dart';
import 'package:shellcode2/apiData/OffersApiData.dart';
import 'package:shellcode2/colors.dart';
import 'package:shellcode2/apiData/BestSellingProducts.dart';
import 'package:shellcode2/category.dart';
import 'package:provider/provider.dart';
import 'package:shellcode2/Provider/data.dart';

class FrontPage extends StatefulWidget {
  const FrontPage({Key key}) : super(key: key);

  @override
  _FrontPageState createState() => _FrontPageState();
}

class _FrontPageState extends State<FrontPage> {
  List color = [
    Color.fromRGBO(177, 156, 217, 20.0),
    Color.fromRGBO(150, 111, 214, 20.0),
    Color.fromRGBO(111, 45, 168, 20.0),
    Color.fromRGBO(75, 0, 130, 20.0)
  ];

  @override
  void initState() {
    super.initState();
    fetchDataByDistrictApi();
    fetchBestProductApiData();
    Data data = new Data();
    data.getOffersData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      body: Container(
        child: Column(
          children: [
            Stack(
              children: <Widget>[
                Image.asset(
                  'assets/opaque.png',
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.7,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 118.0),
                  child: Center(
                    child: Text("Welcome To \nFarmerskart",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 28.0,
                            color: Colors.purple)),
                  ),
                ),
                Positioned(
                    top: 280,
                    left: 40,
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 200,
                        child: Image.asset(
                          'assets/farmersKartLogo.png',
                          fit: BoxFit.cover,
                        )))
              ],
            ),
            Stack(
              children: <Widget>[
                Image.asset(
                  'assets/bg_neww.png',
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.3,
                ),
                Positioned(
                    bottom: 70,
                    left: 150,
                    child: Card(
                      child: CircleAvatar(
                        backgroundColor: Colors.purple,
                        maxRadius: 50,
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignIn()));
                          },
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 35,
                          ),
                        ),
                      ),
                      elevation: 15.0,
                      shape: CircleBorder(),
                      clipBehavior: Clip.antiAlias,
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
