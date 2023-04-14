import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckOutCart extends StatelessWidget {
  double sum;
  CheckOutCart({required this.sum});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            onPrimary: Colors.green,
            side: BorderSide(color: Colors.green),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
            ),
            minimumSize: Size(double.infinity, 50),
          ),
          onPressed: () {},
          child: Text(
            "Sum: $sum",
            style: TextStyle(fontSize: 14.0),
          ),
        )),
        Expanded(
            child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.green,
            onPrimary: Colors.white,
            side: BorderSide(color: Colors.green),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
            ),
            minimumSize: Size(double.infinity, 50),
          ),
          onPressed: () {},
          child: Text(
            "Check out".toUpperCase(),
            style: TextStyle(fontSize: 14.0),
          ),
        ))
      ],
    );
  }
}
