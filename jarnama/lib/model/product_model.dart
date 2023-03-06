import 'dart:convert';

class Product {
  Product(
      {this.images,
      required this.title,
      required this.description,
      required this.dateTime,
      required this.phonNumber,
      required this.userName,
      required this.address,
      this.price});

  final List<String>? images;
  final String title;
  final String description;
  final String dateTime;
  final String phonNumber;
  final String userName;
  final String address;
  final String? price;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'images': images,
      'desription': description,
      'dateTime': dateTime,
      'phonNumber': phonNumber,
      'userName': userName,
      'address': address,
      'price': price,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
        images: map['images'] != null
            ? List<String>.from((map['images'] as List<String>))
            : null,
        title: map['title'] as String,
        description: map['description'] as String,
        dateTime: map['dateTime'] as String,
        phonNumber: map['phonNumber'] as String,
        userName: map['userName'],
        address: map['address'] as String,
        price: map['price'] != null ? map['price'] as String : null);
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String sourse) =>
      Product.fromMap(json.decode(sourse) as Map<String, dynamic>);
}
