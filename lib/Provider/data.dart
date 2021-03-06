import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:shellcode2/apiData/getUserFav.dart';
import 'package:shellcode2/apiData/loginApiData.dart';
import 'package:shellcode2/cart.dart';
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
  String name;
  String societyName;
  String email;
  String pincode;
  String wing;
  String flat;
  String mobile;
  String image;
  int index;
  String paymentText = "MAKE PAYMENT";
  int cartProductCount = 0;
  int productQuantity = 1;
  double totalAddedProductAmount = 0.0;
  int productIndex = 0;
  int productPriceIndex = 0;
  int newNotification = 0;
  bool done = false;

  List<UserFavProductCategories> detailsByCategory = [];

  void initialUserFavProductCategories(List<UserFavProductCategories> list) {
    this.detailsByCategory = list;
    notifyListeners();
  }

  void checkDone(bool done) {
    this.done = done;
    notifyListeners();
  }

  void initializetotalAddedProductAmount(double totalAddedProductAmount) {
    if (totalAddedProductAmount != null) {
      this.totalAddedProductAmount = totalAddedProductAmount;
    }
    notifyListeners();
  }

  void initializeProductIndex(int productIndex) {
    if (productIndex != null) {
      this.productIndex = productIndex;
    }
  }

  void initializeProductPriceIndex(int productPriceIndex) {
    if (productPriceIndex != null) {
      this.productPriceIndex = productPriceIndex;
    }
    notifyListeners();
  }

  void initializeNewNotificationCount(int newNotification) {
    if (newNotification != null) {
      this.newNotification = newNotification;
    }
    notifyListeners();
  }

  void initializeProductQuantity(int productQuantity) {
    if (productQuantity != null) {
      this.productQuantity = productQuantity;
    }
    notifyListeners();
  }

  void initializeIndex(int index) {
    if (index != null) {
      this.index = index;
    }
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
    if (choice == Payment.online) {
      paymentText = 'MAKE PAYMENT';
    } else if (choice == Payment.cod) {
      paymentText = 'PLACE ORDER';
    }
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

  void inititalizeCartProductCount(int cartProductCount) async {
    if (cartProductCount != null) {
      this.cartProductCount = cartProductCount;
    }
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

  void initializeUserId(String userId) {
    if (userId != null) {
      this.userId = userId;
    }
    notifyListeners();
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

  void initailizeImage(String image) {
    if (image != null) {
      this.image = image;
    }
  }

  void initializeName(String name) {
    if (name != null) {
      this.name = name;
    }
    notifyListeners();
  }

  void initializeSocietyName(String societyName) {
    if (societyName != null) {
      this.societyName = societyName;
    }
    notifyListeners();
  }

  void initializeEmail(String email) {
    if (email != null) {
      this.email = email;
    }
    notifyListeners();
  }

  void initializeMobileNo(String mobile) {
    if (mobile != null) {
      this.mobile = mobile;
    }
    notifyListeners();
  }

  void initializeFlatNo(String flat) {
    if (flat != null) {
      this.flat = flat;
    }
    notifyListeners();
  }

  void initializeWing(String wing) {
    if (wing != null) {
      this.wing = wing;
    }
    notifyListeners();
  }

  void initializePincode(String pincode) {
    if (pincode != null) {
      this.pincode = pincode;
    }
    notifyListeners();
  }
}
