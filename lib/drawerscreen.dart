import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shellcode2/Authentication%20pages/signinpage.dart';
import 'package:shellcode2/Authentication%20pages/signuppage.dart';
import 'package:shellcode2/Bottom%20bar%20pages/wishlist.dart';
import 'package:shellcode2/Navigation%20Drawer%20pages/handyOrder.dart';
import 'package:shellcode2/Navigation%20Drawer%20pages/myOrders.dart';
import 'package:shellcode2/Navigation%20Drawer%20pages/userAcc.dart';
import 'package:shellcode2/Navigation%20Drawer%20pages/wallet.dart';
import 'package:shellcode2/colors.dart';
import 'package:shellcode2/home.dart';
import 'package:provider/provider.dart';
import 'package:shellcode2/Provider/data.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 15);

  @override
  Widget build(BuildContext context) {
    final name = 'Sarah Abs';
    final urlImage =
        'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80';
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [left, middle, Colors.purple])),
        child: ListView(
          children: <Widget>[
            buildHeader(
              urlImage: urlImage,
              name:  Provider.of<APIData>(context,listen: false).user.name,
              onClicked: () {
                Navigator.pop(context);
              },
              /* onClicked: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => UserPage(
                  name: 'Sarah Abs',
                  urlImage: urlImage,
                ),
              )),*/
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
                    text: 'Favourites Or wishlist',
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
                    onClicked: () =>
                        Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => UserAcc(),
                    )),
                  ),
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
                    onClicked: () =>
                        Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Home(),
                    )),
                  ),
                  buildMenuItem(
                    text: 'Sign out',
                    icon: Icons.exit_to_app,
                    onClicked: () =>
                        Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SignIn(),
                    )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
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
