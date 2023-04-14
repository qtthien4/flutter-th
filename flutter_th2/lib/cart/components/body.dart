import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:food_now/cart/components/checkoutcart.dart';
import 'package:food_now/model/carts.dart';
import 'package:food_now/model/products.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/utilities.dart';

class BodyCart extends StatefulWidget {
  const BodyCart({super.key});

  @override
  State<BodyCart> createState() => _BodyCartState();
}

class _BodyCartState extends State<BodyCart> {
  // List<dynamic> cartdetails = Cart().getCart();
  List<Cart> cartdetails = <Cart>[];
  double sum = 0.0;

  Future getUserId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString('userId');
  }

  @override
  void initState() {
    super.initState();
    var userId = getUserId().then(
      (value) {
        Utilities().getCart(value).then((value) {
          setState(() {
            cartdetails = value;
          });
          cartdetails.forEach((item) {
            sum = sum + num.parse(item.product.price);
          });
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Expanded(
              child: ListView.builder(
            shrinkWrap: true,
            itemCount: cartdetails.length,
            itemBuilder: (context, index) => Column(
              children: [
                GestureDetector(
                  child: CartItem(product: cartdetails[index]),
                  onTap: () {
                    setState(() {
                      cartdetails.removeAt(index);
                      sum = 0.0;
                      cartdetails.forEach((item) {
                        sum = sum + num.parse(item.product.price);
                      });
                    });
                  },
                ),
                const Divider()
              ],
            ),
          )),
          CheckOutCart(sum: sum)
        ],
      ),
    );
  }
}

class CartItem extends StatelessWidget {
  dynamic product;

  CartItem({required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFF5F5F5),
      padding: EdgeInsets.all(16),
      child: Row(children: [
        SizedBox(
          width: 100,
          height: 100,
          child: Image.asset(product.product.image),
        ),
        Expanded(child: Text(product.product.title)),
        Expanded(child: Text(product.product.price.toString())),
        const Icon(Icons.delete_outline)
      ]),
    );
  }
}
