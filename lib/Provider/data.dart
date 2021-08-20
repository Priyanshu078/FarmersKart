import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:shellcode2/apiData/loginApiData.dart';

class UserAccountDetails extends ChangeNotifier {
  UserOfApp user;

  void initializeUser(UserOfApp user) {
    if (user != null) this.user = user;

    notifyListeners();
  }
}

// class CarouselChange extends ChangeNotifier{
//
//   void getindex(Corousal index){
//
//   }
// }

