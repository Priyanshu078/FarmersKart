class OrdersData {
  String categoryName;
  String productName;
  String productImage;
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
  String createdDate;
  String totalAmount;
  String updatedDate;
  String cancelledReason;
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
  String deliveryCharges;
  String deliveryDate;
  String specification;
  List center;
  OrdersData(
      this.categoryName,
      this.productName,
      this.productImage,
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
      this.deliveryCharges,
      this.deliveryDate,
      this.specification,
      this.center);
}

class CenterData {
  String centerName;
  String address;
  String pincode;
  String delFlag;
  String deliveryDays;
  String deliveryTime;
  String id;
  CenterData(this.centerName, this.address, this.pincode, this.delFlag,
      this.deliveryDays, this.deliveryTime, this.id);
}

String get productName {
  return productName;
}
