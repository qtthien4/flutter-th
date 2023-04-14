import 'dart:convert';
import 'dart:io';
import 'dart:js';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_now/model/carts.dart';
import 'package:food_now/signin/signin_page.dart';
import 'package:http/http.dart' as http;
import 'products.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:quiver/strings.dart';

class Utilities {
  static List<Products> data = [];

  // static String validateEmail(String value){
  //   if(value.isEmpty){
  //     return 'Please enter your email';
  //   }
  //   Pattern pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
  //   RegExp regex = new RegExp(pattern);
  // }
  String url = "http://localhost:3123/api/foods";

  static List<Products> parseProducts(String res) {
    var list = json.decode(res)['food'] as List<dynamic>;
    List<Products> products = list.map((e) => Products.fromJson(e)).toList();
    return products;
  }

  Future<List<Products>> getProducts() async {
    var res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      return compute(parseProducts, res.body);
    } else if (res.statusCode == 404) {
      throw Exception('N0T_FOUND');
    } else {
      throw Exception("CAN'T GET");
    }
  }

  static List<Cart> parseCart(String res) {
    var list = json.decode(res) as List<dynamic>;
    List<Cart> cart = list.map((e) => Cart.fromJson(e)).toList();
    return cart;
  }

  Future<List<Cart>> getCart(userId) async {
    var res = await http
        .get(Uri.parse('http://localhost:3123/api/cart?userId=$userId'));

    if (res.statusCode == 200) {
      return compute(parseCart, res.body);
    } else if (res.statusCode == 404) {
      throw Exception('N0T_FOUND');
    } else {
      throw Exception("CAN'T GET");
    }
  }

  checkLogin(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final check = sharedPreferences.getString('userId');

    if (check == null) {
      Navigator.pushNamedAndRemoveUntil(
          context, SignInPage.routeName, (Route<dynamic> route) => false);
    } else {
      return check;
    }
  }

  static String validatePassword(String value) {
    if (value.isEmpty) {
      return 'Please enter password';
    }
    if (value.length < 8) {
      return 'Password should be more than 8 characters';
    }
    return 'Password suitable';
  }

  static String confirmPassword(String value1, String value2) {
    if (!equalsIgnoreCase(value1, value2)) {
      return 'Confirm password invalid';
    }
    return 'Confirm success';
  }
}
