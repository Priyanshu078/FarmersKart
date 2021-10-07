import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shellcode2/Authentication%20pages/signinpage.dart';
import 'package:shellcode2/apiData/BannerImagesAPI.dart';
import 'package:shellcode2/apiData/OffersApiData.dart';
import 'package:shellcode2/apiData/loginApiData.dart';
import 'package:shellcode2/cart.dart';
import 'package:shellcode2/colors.dart';
import 'package:shellcode2/apiData/BestSellingProducts.dart';
import 'package:shellcode2/category.dart';
import 'package:provider/provider.dart';
import 'package:shellcode2/Provider/data.dart';
import 'package:shellcode2/home.dart';
import 'package:shellcode2/main.dart';

import 'apiData/AllCenter.dart';
import 'apiData/festiveSpecial.dart';
import 'apiData/immunityBooster.dart';

class FrontPage extends StatefulWidget {
  const FrontPage({Key key}) : super(key: key);

  @override
  _FrontPageState createState() => _FrontPageState();
}

// bool homePage = true;
// bool category = false;
// bool wishlist = false;

class _FrontPageState extends State<FrontPage> {
  List color = [
    Color.fromRGBO(177, 156, 217, 20.0),
    Color.fromRGBO(150, 111, 214, 20.0),
    Color.fromRGBO(111, 45, 168, 20.0),
    Color.fromRGBO(75, 0, 130, 20.0)
  ];
  bool loggedIn = false;
  @override
  void initState() {
    super.initState();
    // loginDetails();
    // fetchDataByDistrictApi();
    // fetchBestProductApiData();
    // fetchImmunityBoosterProductApiData();
    // fetchFestiveSpecialProductApiData();
    // fetchAllCenter();
    // Data data = new Data();
    // data.getOffersData();
    // fetchBannerImages();
    // Provider.of<APIData>(context, listen: false).checkDone(true);
    runAllMethods();
  }

  runAllMethods() async {
    try {
      bool loginData = await loginDetails();
      bool categoryProducts = await fetchDataByDistrictApi();
      bool bestProducts = await fetchBestProductApiData();
      bool immunityBooster = await fetchImmunityBoosterProductApiData();
      bool festiveSpecial = await fetchFestiveSpecialProductApiData();
      bool allcenter = await fetchAllCenter();
      Data data = new Data();
      bool offersData = await data.getOffersData();
      bool bannerImages = await fetchBannerImages();
      if (loginData &&
          categoryProducts &&
          bestProducts &&
          immunityBooster &&
          festiveSpecial &&
          allcenter &&
          offersData &&
          bannerImages) {
        Provider.of<APIData>(context, listen: false).checkDone(true);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              "Please check you internet connection and Restart the Application")));
    }
  }

  Future getLoginStatus(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(key);
  }

  Future<bool> loginDetails() async {
    bool gotData = false;
    loggedIn = await getLoginStatus(key2) ?? false;
    gotData = true;
    return gotData;
  }

  Future<List<UserOfApp>> getUserData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<UserOfApp> userData = [];
    print(preferences.getString(key1));
    print("data");
    Map<String, dynamic> userDataMap =
        jsonDecode(preferences.getString(key1) ?? "");
    print(userDataMap);
    print("data");
    List data = [];
    data.add(userDataMap);
    for (var item in data) {
      List<CenterOfStore> centerList = [];
      for (var center in item["center"]) {
        CenterOfStore centerOfStore = new CenterOfStore(
            centerName: center["center_name"].toString(),
            address: center["address"].toString(),
            pincode: center["pincode"].toString(),
            delFlag: center["del_flag"].toString(),
            deliveryDays: center["delivery_days"].toString(),
            deliveryTime: center["delivery_time"].toString(),
            id: center["id"].toString());
        centerList.add(centerOfStore);
      }
      UserOfApp userOfApp = new UserOfApp(
          id: item["id"],
          name: item["name"],
          email: item["email"],
          mobile: item["mobile"],
          password: item["password"],
          isActive: item["is_active"],
          delFlag: item["del_flag"],
          firebaseToken: item["firebase_token"],
          userType: item["user_type"],
          address: item["address"],
          societyName: item["society_name"],
          flatNo: item["flat_no"],
          wing: item["wing"],
          pincode: item["pincode"],
          gstNo: item["gst_no"],
          createdAt: DateTime.parse(item["created_at"]),
          from: item["from"],
          imageName: item["image_name"],
          centerId: item["center_id"],
          center: centerList);
      userData.add(userOfApp);
    }
    return userData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgcolor,
        body: Consumer<APIData>(builder: (context, data, child) {
          return data.done
              ? Container(
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
                            padding: const EdgeInsets.only(top: 120.0),
                            child: Center(
                              child: Text("Welcome To \nFarmerskart",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 28.0,
                                      color: Colors.purple)),
                            ),
                          ),
                          Positioned(
                              top: MediaQuery.of(context).size.height * 0.35,
                              left: MediaQuery.of(context).size.width * 0.1,
                              child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  height:
                                      MediaQuery.of(context).size.width * 0.52,
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
                              bottom: MediaQuery.of(context).size.height * 0.1,
                              left: MediaQuery.of(context).size.width * 0.35,
                              child: Card(
                                child: CircleAvatar(
                                  backgroundColor: Colors.purple,
                                  maxRadius: 55,
                                  child: IconButton(
                                    onPressed: () async {
                                      if (loggedIn) {
                                        await Login();
                                      } else {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SignIn()));
                                      }
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
                )
              : Center(
                  child: Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      gradient: LinearGradient(
                          colors: [left, middle, Colors.purple])),
                  height: 100,
                  width: MediaQuery.of(context).size.width * 4 / 5,
                  child: Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: CircularProgressIndicator()),
                      Text(
                        "Please Wait...",
                        style: TextStyle(
                            color: Colors.amber[600],
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  )),
                ));
        }));
  }

  Future<void> Login() async {
    bool authenticated = false;
    // print(phoneNo);
    // print(password);
    // String firebaseToken = await getToken();
    // if ((password != null && phoneNo != null) &&
    //     (phoneController.text != "" && pwController.text != "")) {
    List<UserOfApp> userAccountData = await getUserData();
    // await fetchLoginApiData(phoneNo, password);
    print(userAccountData);
    if (userAccountData == null) {
      authenticated = false;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Please try Again!!!")));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Login Successful")));
      authenticated = true;
      Provider.of<APIData>(context, listen: false)
          .initializeUser(userAccountData[0]);
      // SharedPreferences preferences = await SharedPreferences.getInstance();
      // updateFirebaseToken(firebaseToken,
      //     Provider.of<APIData>(context, listen: false).user.id);
      // print(userAccountData[0].toJson());
      // setUserData(key1, jsonEncode(userAccountData[0].toJson()));
      // status = true;
      // setLoginStatus(key2, status);
      print(authenticated);
      if (authenticated) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home()));
      }
    }
    // } else {
    //   ScaffoldMessenger.of(context)
    //       .showSnackBar(SnackBar(content: Text("Please try Again!!!")));
    // }
  }
}
