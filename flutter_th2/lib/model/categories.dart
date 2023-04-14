import 'package:flutter/material.dart';

class Categories {
  int id;
  String title;
  String image;

  Categories({required this.id, required this.title, required this.image});

  static List<Categories> init() {
    List<Categories> data = [
      Categories(id: 1, title: 'HighLand', image: "pics/ic_highland.png"),
      Categories(id: 2, title: 'CircleK', image: "pics/ic_circlek.png"),
      Categories(id: 3, title: '711', image: "pics/ic_seveneleven.png"),
      Categories(id: 4, title: 'MiniStop', image: "pics/ic_ministop.png")
    ];
    return data;
  }
}
