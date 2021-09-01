import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:shellcode2/apiData/getUserFav.dart';
import 'package:shellcode2/apiData/loginApiData.dart';
import 'package:shellcode2/apiData/BannerImagesAPI.dart';
import 'package:shellcode2/apiData/subCategory.dart';

import '../detailServiceList.dart';

class APIData extends ChangeNotifier {
  UserOfApp user;
  List<General> temp = [];
  bool discountUpToRs5 = false;
  bool discountUpToRs15 = false;
  bool discountMoreThan15 = false;
  bool priceLessThan20 = false;
  bool priceLessThan100 = false;
  bool priceLessThan300 = false;
  bool priceMoreThan300 = false;
  bool productRatingMoreThan4 = false;
  bool productRatingMoreThan3 = false;
  String userId;
  String address;
  List<UserFavProductCategories> detailsByCategory = [];

  void initialUserFavProductCategories(List<UserFavProductCategories> list) {
    this.detailsByCategory = list;
    notifyListeners();
  }

  void initializeUser(UserOfApp user) {
    if (user != null) {
      this.user = user;
    }

    notifyListeners();
  }

  void initializeAddress(String address) {
    if (address != null) {
      this.address = address;
    }
    notifyListeners();
  }

  void initializeTemp(List<General> list) {
    if (list != null) this.temp = list;

    notifyListeners();
  }

  void initializeDiscountUpToRs5() {
    this.discountUpToRs5 = true;
    this.discountMoreThan15 = false;
    this.discountUpToRs15 = false;

    notifyListeners();
  }

  void initializeDiscountUpToRs15() {
    this.discountUpToRs5 = false;
    this.discountMoreThan15 = false;
    this.discountUpToRs15 = true;

    notifyListeners();
  }

  void initializeDiscountMoreThan15() {
    this.discountUpToRs5 = false;
    this.discountMoreThan15 = true;
    this.discountUpToRs15 = false;

    notifyListeners();
  }

  void initializePriceLessThan20() {
    this.priceLessThan20 = true;
    this.priceLessThan100 = false;
    this.priceLessThan300 = false;
    this.priceMoreThan300 = false;

    notifyListeners();
  }

  void initializePriceLessThan100() {
    this.priceLessThan20 = false;
    this.priceLessThan100 = true;
    this.priceLessThan300 = false;
    this.priceMoreThan300 = false;

    notifyListeners();
  }

  void initializePriceLessThan300() {
    this.priceLessThan20 = false;
    this.priceLessThan100 = false;
    this.priceLessThan300 = true;
    this.priceMoreThan300 = false;

    notifyListeners();
  }

  void initializePriceMoreThan300() {
    this.priceLessThan20 = false;
    this.priceLessThan100 = false;
    this.priceLessThan300 = false;
    this.priceMoreThan300 = true;

    notifyListeners();
  }

  void resetAllFilter() {
    this.priceLessThan20 = false;
    this.priceLessThan100 = false;
    this.priceLessThan300 = false;
    this.priceMoreThan300 = false;

    this.discountUpToRs5 = false;
    this.discountMoreThan15 = false;
    this.discountUpToRs15 = false;

    notifyListeners();
  }
}
