import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_now/signup/signup_page.dart';
import 'package:food_now/homepage/homepage.dart';

import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  bool _value = false;

  var email, password;

  @override
  void initState() {
    super.initState();
  }

  fetchLogin(email, password) async {
    final response = await http.post(
        Uri.parse('http://localhost:3123/api/v1/users/login'),
        body: {"email": email, "password": password});

    if (response.statusCode == 200) {
      print('POST request successful!');
      saveUserData(json.decode(response.body)['_id']);
      Navigator.pushNamedAndRemoveUntil(
          context, HomePage.routeName, (Route<dynamic> route) => false);
    } else {
      print('POST request failed with status: ${response.statusCode}.');
    }
  }

  static Future<bool> saveUserData(value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setString('userId', value);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(8),
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Text('Food Now',
                        style: TextStyle(
                            fontSize: 32,
                            color: Colors.green,
                            fontWeight: FontWeight.bold)),
                    Text(
                        'Sign in with your email and password \nor continue with social media',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.green,
                        )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextFormField(
                        onChanged: (val) {
                          setState(() {
                            email = val;
                          });
                        },
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Username',
                            prefixIcon: Icon(Icons.mail_outline)),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        onChanged: (val) {
                          setState(() {
                            password = val;
                          });
                        },
                        keyboardType: TextInputType.number,
                        obscureText: true,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Password',
                            prefixIcon: Icon(Icons.lock_outline_rounded)),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: _value ?? true,
                            onChanged: (value) {
                              print(_value.toString());
                              setState(() {
                                _value = value!;
                              });
                            },
                          ),
                          const Text(
                            "Remember me",
                            style: TextStyle(color: Colors.green, fontSize: 16),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          onPressed: () {
                            fetchLogin(email, password);
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            backgroundColor: Colors.green,
                          ),
                          child: const Text(
                            'Continue',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account? ",
                            style: TextStyle(color: Colors.green, fontSize: 14),
                          ),
                          GestureDetector(
                            onTap: () async {
                              final result = await Navigator.pushNamed(
                                  context, SignUpPage.routeName);
                            },
                            child: const Text(
                              "Sign up",
                              style: TextStyle(
                                  color: Colors.redAccent, fontSize: 14),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
