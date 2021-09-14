class AllProducts {
  List price;
  String categoryName;
  String id;
  String category;
  String subCategory;
  String name;
  String img;
  String description;
  String delFlag;
  String rating;
  AllProducts(
      this.price,
      this.categoryName,
      this.id,
      this.category,
      this.subCategory,
      this.name,
      this.img,
      this.description,
      this.delFlag,
      this.rating);
}

class Price {
  String p_Id;
  String userType;
  String originalPrice;
  var discount;
  String discountedPrice;
  String weight;
  String unit;
  Price(this.p_Id, this.userType, this.originalPrice, this.discount,
      this.discountedPrice, this.weight, this.unit);
}
