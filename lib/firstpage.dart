import 'package:flutter/material.dart';

class FrontPage extends StatelessWidget {
  List color=[Color.fromRGBO(177,156,217,20.0),Color.fromRGBO(150,111,214,20.0),Color.fromRGBO(111,45,168,20.0),Color.fromRGBO(75,0,130,20.0)];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/bg.jpg'),
                    fit: BoxFit.cover,
                  ),
                color: Colors.blue,
              ),
            )
          ],
        ),
    );
  }
}

