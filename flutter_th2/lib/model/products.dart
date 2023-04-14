import 'package:flutter/material.dart';

// class Products {
//   int id;
//   String title, description, image;
//   double price;

//   Products(
//       {required this.id,
//       required this.title,
//       required this.description,
//       required this.image,
//       required this.price});

//   static List<Products> init() {
//     List<Products> data = [
//       Products(
//           id: 1,
//           title: 'Bread',
//           description: 'des_01',
//           image: 'pics/ic_banh_mi.png',
//           price: 8.0),
//     ];
//     return data;
//   }
// }

class Products {
  String? sId;
  String? id;
  late String title;
  late String description;
  late String image;
  late String price;

  Products(
      {this.sId,
      this.id,
      required this.title,
      required this.description,
      required this.image,
      required this.price});

  Products.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    id = json['id'];
    title = json['title'];
    description = json['description'];
    image = json['image'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['image'] = this.image;
    data['price'] = this.price;
    return data;
  }

  @override
  String toString() {
    return 'Products{name: $title, price: $price, description: $description, price: $price}';
  }
}
