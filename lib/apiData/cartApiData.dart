// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Welcome({
    this.order,
    this.code,
    this.msg,
  });

  List<Order> order;
  String code;
  String msg;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        order: List<Order>.from(json["order"].map((x) => Order.fromJson(x))),
        code: json["code"],
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "order": List<dynamic>.from(order.map((x) => x.toJson())),
        "code": code,
        "msg": msg,
      };
}

class Order {
  Order({
    this.categoryName,
    this.productName,
    this.productImg,
    this.id,
    this.userId,
    this.orderId,
    this.addressId,
    this.quantity,
    this.productId,
    this.unitPrice,
    this.orderStatus,
    this.adminStatus,
    this.cart,
    this.createdDate,
    this.totalAmount,
    this.updatedDate,
    this.cancelledReason,
    this.wallet,
    this.weight,
    this.usedWalletAmount,
    this.couponValue,
    this.unitOriginalPrice,
    this.centerId,
    this.paymentOption,
    this.deliveryDay,
    this.deliveryTime,
    this.couponCode,
    this.couponId,
    this.deliveryChrges,
    this.deliveryDate,
    this.specification,
    this.center,
  });

  String categoryName;
  String productName;
  String productImg;
  String id;
  String userId;
  String orderId;
  String addressId;
  String quantity;
  String productId;
  String unitPrice;
  String orderStatus;
  String adminStatus;
  String cart;
  DateTime createdDate;
  String totalAmount;
  DateTime updatedDate;
  dynamic cancelledReason;
  String wallet;
  String weight;
  String usedWalletAmount;
  String couponValue;
  String unitOriginalPrice;
  String centerId;
  String paymentOption;
  String deliveryDay;
  String deliveryTime;
  String couponCode;
  String couponId;
  String deliveryChrges;
  DateTime deliveryDate;
  dynamic specification;
  List<Center> center;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        categoryName: json["category_name"],
        productName: json["product_name"],
        productImg: json["product_img"],
        id: json["id"],
        userId: json["user_id"],
        orderId: json["order_id"],
        addressId: json["address_id"],
        quantity: json["quantity"],
        productId: json["product_id"],
        unitPrice: json["unit_price"],
        orderStatus: json["order_status"],
        adminStatus: json["admin_status"],
        cart: json["cart"],
        createdDate: DateTime.parse(json["created_date"]),
        totalAmount: json["total_amount"],
        updatedDate: DateTime.parse(json["updated_date"]),
        cancelledReason: json["cancelled_reason"],
        wallet: json["wallet"],
        weight: json["weight"],
        usedWalletAmount: json["used_wallet_amount"],
        couponValue: json["coupon_value"],
        unitOriginalPrice: json["unit_original_price"],
        centerId: json["center_id"],
        paymentOption: json["payment_option"],
        deliveryDay: json["delivery_day"],
        deliveryTime: json["delivery_time"],
        couponCode: json["coupon_code"],
        couponId: json["coupon_id"],
        deliveryChrges: json["delivery_chrges"],
        deliveryDate: DateTime.parse(json["delivery_date"]),
        specification: json["specification"],
        center:
            List<Center>.from(json["center"].map((x) => Center.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "category_name": categoryName,
        "product_name": productName,
        "product_img": productImg,
        "id": id,
        "user_id": userId,
        "order_id": orderId,
        "address_id": addressId,
        "quantity": quantity,
        "product_id": productId,
        "unit_price": unitPrice,
        "order_status": orderStatus,
        "admin_status": adminStatus,
        "cart": cart,
        "created_date": createdDate.toIso8601String(),
        "total_amount": totalAmount,
        "updated_date": updatedDate.toIso8601String(),
        "cancelled_reason": cancelledReason,
        "wallet": wallet,
        "weight": weight,
        "used_wallet_amount": usedWalletAmount,
        "coupon_value": couponValue,
        "unit_original_price": unitOriginalPrice,
        "center_id": centerId,
        "payment_option": paymentOption,
        "delivery_day": deliveryDay,
        "delivery_time": deliveryTime,
        "coupon_code": couponCode,
        "coupon_id": couponId,
        "delivery_chrges": deliveryChrges,
        "delivery_date":
            "${deliveryDate.year.toString().padLeft(4, '0')}-${deliveryDate.month.toString().padLeft(2, '0')}-${deliveryDate.day.toString().padLeft(2, '0')}",
        "specification": specification,
        "center": List<dynamic>.from(center.map((x) => x.toJson())),
      };
}

class Center {
  Center({
    this.centerName,
    this.address,
    this.pincode,
    this.delFlag,
    this.deliveryDays,
    this.deliveryTime,
    this.id,
  });

  String centerName;
  String address;
  String pincode;
  String delFlag;
  String deliveryDays;
  String deliveryTime;
  String id;

  factory Center.fromJson(Map<String, dynamic> json) => Center(
        centerName: json["center_name"],
        address: json["address"],
        pincode: json["pincode"],
        delFlag: json["del_flag"],
        deliveryDays: json["delivery_days"],
        deliveryTime: json["delivery_time"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "center_name": centerName,
        "address": address,
        "pincode": pincode,
        "del_flag": delFlag,
        "delivery_days": deliveryDays,
        "delivery_time": deliveryTime,
        "id": id,
      };
}
