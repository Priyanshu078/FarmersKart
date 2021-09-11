import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:shellcode2/apiData/getUserFav.dart';
import 'package:shellcode2/apiData/loginApiData.dart';
import 'package:shellcode2/filter.dart';
// import 'package:shellcode2/apiData/BannerImagesAPI.dart';
import 'package:shellcode2/apiData/subCategory.dart';

import '../detailServiceList.dart';
import '../paymentOption.dart';

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
  double totalAmount = 0.0;
  double discountAmount = 0.0;
  int quantity = 1;
  String centerId;
  double walletAmount = 0;
  bool walletUsed = false;
  bool onlinePayment = false;
  bool cashOnDelivery = false;
  Payment choice;
  double deliveryCharges = 40.0;
  double walletAmountUsed = 0;

  List<UserFavProductCategories> detailsByCategory = [];

  void initialUserFavProductCategories(List<UserFavProductCategories> list) {
    this.detailsByCategory = list;
    notifyListeners();
  }

  void changeDeliveryCharges(double deliveryCharges) {
    if (deliveryCharges != null) {
      this.deliveryCharges = deliveryCharges;
    }
    notifyListeners();
  }

  void initializeWalletAmount(double amount) {
    if (amount != null) {
      walletAmount = amount;
    }
    notifyListeners();
  }

  void initializepaymentChoice(Payment value) {
    choice = value;
    notifyListeners();
  }

  void preferOnlinePayment() {
    onlinePayment = true;
    cashOnDelivery = false;
    notifyListeners();
  }

  void preferCOD() {
    cashOnDelivery = true;
    onlinePayment = false;
    notifyListeners();
  }

  void useWallet() {
    walletUsed = !walletUsed;
    notifyListeners();
    print("total Amount $totalAmount");
    if (walletUsed == true) {
      if (walletAmount < totalAmount) {
        walletAmountUsed = (walletAmount).toDouble();
        totalAmount -= walletAmount;
      } else {
        walletAmountUsed = totalAmount;
        totalAmount = 0;
      }
    } else {
      if (walletAmount < totalAmount) {
        totalAmount += walletAmountUsed;
        walletAmountUsed = 0;
      } else if (totalAmount == 0) {
        totalAmount = walletAmountUsed;
        walletAmountUsed = 0;
      } else {
        totalAmount += walletAmountUsed;
        walletAmountUsed = 0;
      }
    }
    initializeTotalAmount(totalAmount);
    print("total Amount $totalAmount");
    walletAmountUsedWhenPaying(walletAmountUsed);
    print("wallet amount used $walletAmountUsed");
  }

  void initializeCenterId(String centerId) {
    if (centerId != null) {
      this.centerId = centerId;
    }
    notifyListeners();
  }

  void walletAmountUsedWhenPaying(double walletAmountUsed) {
    if (walletAmountUsed != null) {
      this.walletAmountUsed = walletAmountUsed;
    }
    notifyListeners();
  }

  void initializeTotalAmount(double amount) {
    if (amount != null) {
      this.totalAmount = amount;
    }
    notifyListeners();
  }

  void initializeTotalDiscount(double discountAmount) {
    if (discountAmount != null) {
      this.discountAmount = discountAmount;
    }
    notifyListeners();
  }

  void initializeQuantity(int value) {
    if (value != null) {
      this.quantity = value;
    }
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
