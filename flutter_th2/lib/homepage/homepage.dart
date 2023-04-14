import 'package:flutter/material.dart';
import 'package:food_now/homepage/components/body.dart';
import 'package:food_now/model/utilities.dart';

class HomePage extends StatelessWidget {
  //int selectIndex = 0;
  static String routeName = '/home_sreen';

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Utilities().checkLogin(context);
    return const Body();
  }
}
