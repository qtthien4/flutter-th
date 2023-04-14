import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../homepage/homepage.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  var email, password, re_password;

  fetchRegister(email, password) async {
    final response = await http.post(
        Uri.parse('http://localhost:3123/api/v1/users/register'),
        body: {"email": email, "password": password});

    if (response.statusCode == 200) {
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
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            emailTextFormField(),
            const SizedBox(
              height: 30,
            ),
            passwordTextFormField(),
            const SizedBox(
              height: 30,
            ),
            confirmTextFormField(),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () {
                  // if(_formKey.currentState.validate()){
                  //   Navigator.pop(context, User(username:email.text, password:confirm.text));

                  if (password != re_password) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("re_password incorrect"),
                    ));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("register success"),
                    ));
                    fetchRegister(email, password);
                  }
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
            //SizedBox(height: 30,),
          ],
        ),
      ),
    );
  }

  TextFormField emailTextFormField() {
    return TextFormField(
      // controller: email,
      // validator: Utilities.validateEmail,
      keyboardType: TextInputType.emailAddress,
      onChanged: (value) {
        setState(() {
          email = value;
        });
      },
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Enter your email',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.email_outlined),
      ),
      onSaved: (value) {
        setState(() => email.text = value!);
      },
    );
  }

  TextFormField passwordTextFormField() {
    return TextFormField(
      // controller: password,
      // validator: (passwordKey) {
      //  return Utilities.validatePassword(passwordKey);
      // },
      obscureText: true,
      onChanged: (value) {
        setState(() {
          password = value;
        });
      },
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Enter your password',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.lock_outline),
      ),
    );
  }

  TextFormField confirmTextFormField() {
    return TextFormField(
      // controller: confirm,
      // validator: (confirmPassword) {
      //  var pass = _passKey.currentState.value;
      //  return Utilities.confirmPassword(confirmPassword, pass);
      // },
      obscureText: true,
      keyboardType: TextInputType.number,
      onChanged: (value) {
        setState(() {
          re_password = value;
        });
      },
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Re-enter your password',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.lock_outline),
      ),
    );
  }
}
