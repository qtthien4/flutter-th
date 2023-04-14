import 'package:flutter/material.dart';
import 'package:food_now/homepage/components/fragment/home_fragment_categories.dart';
import 'package:food_now/homepage/components/fragment/home_fragment_product.dart';
import 'package:food_now/model/products.dart';

class HomeDetail extends StatelessWidget {
  const HomeDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [CategoriesStore(), ProductPopular()],
      ),
    );
  }
}
