import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_now/model/carts.dart';
import 'package:http/http.dart' as http;
import 'package:food_now/model/products.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:food_now/model/utilities.dart';

import 'package:fluttertoast/fluttertoast.dart';

class AddProductToCart extends StatefulWidget {
  Products product;
  AddProductToCart({required this.product});

  @override
  _AddProductToCartState createState() => _AddProductToCartState();
}

class _AddProductToCartState extends State<AddProductToCart> {
  var userId;

  Future getUserId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString('userId');
  }

  @override
  void InitState() {
    super.initState();
  }

  postCart(product) async {
    var userId = await getUserId();

    final response =
        await http.post(Uri.parse('http://localhost:3123/api/cart'),
            headers: {'Content-Type': 'application/json'},
            body: json.encode({
              'userId': userId,
              'product': {
                'title': product.title,
                'description': product.description,
                'image': product.image,
                'price': product.price,
              },
            }));

    if (response.statusCode == 200) {
      print('???????????');

      // saveUserData(json.decode(response.body)['_id']);
    } else {
      print('POST request failed with status: ${response.statusCode}.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
            onPressed: () {
              postCart(widget.product);
              // Cart cart = Cart();
              // cart.addProductToCart(widget.product);
              // print(cart.getCart().length.toString());
              Fluttertoast.showToast(
                msg: 'Add to cart',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16,
              );
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.green,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            child: Text("Add to cart",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white))));
  }
}
