import 'package:decimal/decimal.dart';
import 'package:uplace/models/item_category.dart';

class Item {
  String id;
  String name;
  // String photo;
  // int units;
  Decimal price;
  String description;
  // String subTitle;
  ItemCategory category;
  String itemImage;
  bool isItemImageBase64;
  String sellerId;

  Item({
    required this.id,
    required this.name,
    // required this.photo,
    // required this.units,
    required this.price,
    required this.description,
    required this.category,
    required this.itemImage,
    required this.isItemImageBase64,
    required this.sellerId,
    // required this.subTitle,
  });

  factory Item.FromFirebase(Map<String, dynamic> json, String id) {
    var category = ItemCategory.food;
    switch (json["category"]) {
      case 0:
        category = ItemCategory.food;
      case 1:
        category = ItemCategory.product;
      case 2:
        category = ItemCategory.service;
      default:
        category = ItemCategory.food;
    }
    return Item(
      name: json["name"],
      price: Decimal.fromJson(json["price"].toString()),
      id: id,
      description: json["description"],
      itemImage: json["itemImage"],
      isItemImageBase64: json["isItemImageBase64"],
      category: category,
      sellerId: json["sellerId"],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
      if (price != null) "price": price.toDouble(),
      if (description != null) "description": description,
      if (category != null) "category": category.name,
      if (itemImage != null) "itemImage": itemImage,
      if (isItemImageBase64 != null) "isItemImageBase64": isItemImageBase64,
      if (sellerId != null) "sellerId": sellerId,
    };
  }

  @override
  String toString() {
    var catName = category.name;
    return 'Item('
        'title: $name, '
        'description: $description, '
        'price: $price, '
        'category: $catName,';
  }
}
