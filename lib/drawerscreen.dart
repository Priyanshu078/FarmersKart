import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shellcode2/Authentication%20pages/signinpage.dart';
import 'package:shellcode2/Authentication%20pages/signuppage.dart';
import 'package:shellcode2/Bottom%20bar%20pages/wishlist.dart';
import 'package:shellcode2/ComplaintsStatus.dart';
import 'package:shellcode2/Navigation%20Drawer%20pages/handyOrder.dart';
import 'package:shellcode2/Navigation%20Drawer%20pages/myOrders.dart';
import 'package:shellcode2/Navigation%20Drawer%20pages/userAcc.dart';
import 'package:shellcode2/Navigation%20Drawer%20pages/wallet.dart';
import 'package:shellcode2/Subscriptions.dart';
import 'package:shellcode2/apiData/Constants.dart';
import 'package:shellcode2/apiData/loginApiData.dart';
import 'package:shellcode2/colors.dart';
import 'package:shellcode2/home.dart';
import 'package:provider/provider.dart';
import 'package:shellcode2/Provider/data.dart';
import 'package:shellcode2/main.dart';
import 'package:url_launcher/url_launcher.dart';

class NavigationDrawerWidget extends StatefulWidget {
  @override
  _NavigationDrawerWidgetState createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  final padding = EdgeInsets.symmetric(horizontal: 15);

  String getImageUrl(BuildContext context) {
    UserOfApp user = Provider.of<APIData>(context, listen: false).user;
    return "$header//app_api/files/" + user.imageName;
  }

  String getUserName(BuildContext context) {
    String userName = Provider.of<APIData>(context, listen: false).user.name;
    if (userName.contains(" ")) {
      List name = userName.split(" ");
      userName = name[0] + "\n" + name[1];
    }
    return userName;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [left, middle, Colors.purple])),
        child: ListView(
          children: <Widget>[
            buildHeader(
              urlImage: getImageUrl(context),
              name: getUserName(context),
              onClicked: () {
                Navigator.pop(context);
              },
            ),
            Container(
              padding: padding,
              child: Column(
                children: [
                  buildMenuItem(
                    text: 'Home',
                    icon: Icons.home,
                    onClicked: () =>
                        Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Home(),
                    )),
                  ),
                  buildMenuItem(
                    text: 'My Orders',
                    icon: Icons.shop,
                    onClicked: () =>
                        Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Orders(),
                    )),
                  ),
                  buildMenuItem(
                      text: 'My Subscriptions',
                      icon: Icons.subscriptions_rounded,
                      onClicked: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Subscriptions()));
                      }),
                  buildMenuItem(
                    text: 'Favourites Or Wishlist',
                    icon: Icons.favorite_border,
                    onClicked: () =>
                        Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Wishlist(),
                    )),
                  ),
                  buildMenuItem(
                    text: 'Wallet',
                    icon: Icons.account_balance_wallet_rounded,
                    onClicked: () =>
                        Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Wallet(),
                    )),
                  ),
                  buildMenuItem(
                    text: 'Rate us',
                    icon: Icons.star_border_outlined,
                    onClicked: () =>
                        Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Home(),
                    )),
                  ),
                  buildMenuItem(
                      text: 'User Account',
                      icon: Icons.account_circle,
                      onClicked: () {
                        UserOfApp user =
                            Provider.of<APIData>(context, listen: false).user;
                        if (Provider.of<APIData>(context, listen: false)
                                    .image ==
                                null &&
                            Provider.of<APIData>(context, listen: false)
                                    .name ==
                                null &&
                            Provider.of<APIData>(context,
                                        listen: false)
                                    .societyName ==
                                null &&
                            Provider.of<APIData>(context, listen: false)
                                    .email ==
                                null &&
                            Provider.of<APIData>(context,
                                        listen: false)
                                    .mobile ==
                                null &&
                            Provider.of<APIData>(context,
                                        listen: false)
                                    .address ==
                                null &&
                            Provider.of<APIData>(context, listen: false).flat ==
                                null &&
                            Provider.of<APIData>(context, listen: false).wing ==
                                null &&
                            Provider.of<APIData>(context, listen: false)
                                    .pincode ==
                                null) {
                          Provider.of<APIData>(context, listen: false)
                              .initailizeImage(user.imageName);
                          Provider.of<APIData>(context, listen: false)
                              .initializeName(user.name);
                          Provider.of<APIData>(context, listen: false)
                              .initializeSocietyName(user.societyName);
                          Provider.of<APIData>(context, listen: false)
                              .initializeEmail(user.email);
                          Provider.of<APIData>(context, listen: false)
                              .initializeMobileNo(user.mobile);
                          Provider.of<APIData>(context, listen: false)
                              .initializeAddress(user.address);
                          Provider.of<APIData>(context, listen: false)
                              .initializeFlatNo(user.flatNo);
                          Provider.of<APIData>(context, listen: false)
                              .initializeWing(user.wing);
                          Provider.of<APIData>(context, listen: false)
                              .initializePincode(user.pincode);
                        }
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => UserAcc(),
                        ));
                      }),
                  buildMenuItem(
                      text: 'Complaints Status',
                      icon: CupertinoIcons.percent,
                      onClicked: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ComplaintStatus()));
                      }),
                  buildMenuItem(
                    text: 'Handy Order',
                    icon: Icons.assignment,
                    onClicked: () =>
                        Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => HandyOrder(),
                    )),
                  ),
                  buildMenuItem(
                      text: 'About us',
                      icon: Icons.person,
                      onClicked: () async {
                        await launch(
                            "https://docs.google.com/forms/d/e/1FAIpQLSdPicJAxB969UMGziYKeuTE09Ol7Rx8wp_YUMiYhGYUp792eg/viewform");
                      }),
                  buildMenuItem(
                      text: 'Privacy Policy',
                      icon: Icons.privacy_tip,
                      onClicked: () async {
                        await launch("https://farmerskart.com/privacy.htm");
                      }),
                  buildMenuItem(
                      text: 'Sign out',
                      icon: Icons.exit_to_app,
                      onClicked: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => SignIn(),
                        ));
                        status = false;
                        setLoginStatus(key2, status);
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future setLoginStatus(String key, bool status) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool(key, status);
  }

  Widget buildHeader({
    @required String urlImage,
    @required String name,
    @required VoidCallback onClicked,
  }) =>
      InkWell(
        onTap: null,
        child: Container(
          padding: padding.add(EdgeInsets.symmetric(vertical: 40)),
          child: Row(
            children: [
              CircleAvatar(radius: 30, backgroundImage: NetworkImage(urlImage)),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ],
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                    onTap: onClicked, child: Icon(Icons.close, color: yellow)),
              ),
            ],
          ),
        ),
      );

  Widget buildMenuItem({
    @required String text,
    @required IconData icon,
    VoidCallback onClicked,
  }) {
    final color = yellow;
    final hoverColor = yellow;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: Colors.white)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }
}
