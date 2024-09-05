// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:uygulama_ornek/home_screen.dart';
import 'package:uygulama_ornek/models/modelUsers.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LogState();
}

class _LogState extends State<Loginscreen> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/background.jpg'),
        fit: BoxFit.cover,colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.darken))),
          child: Center(
                    child: Column(
                      children: [
                        SizedBox(
          height: 80,
                        ),
                        Text(
          'WELCOME BACK',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 30),
                        ),
                        Text(
          'SIGN IN',
          style: TextStyle(
              color: Colors.white.withOpacity(0.8), fontSize: 12.5),
                        ),
                        Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          height: 400,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 60,
              ),
           textFieldWidget('Username', _userNameController, Icons.person),
           textFieldWidget('Password', _passwordController, Icons.lock),
              GestureDetector(
                onTap: () {
                  login();
                },
                child: Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(16),
                   boxShadow: const [
                        BoxShadow(
                      color: Color.fromRGBO(14, 30, 37, 0.12),
                      blurRadius: 4,
                      spreadRadius: 0,
                      offset: Offset(
                         0,
                         2,
                      ),
           ),
                    BoxShadow(
                      color: Color.fromRGBO(14, 30, 37, 0.32),
                      blurRadius: 16,
                      spreadRadius: 0,
                      offset: Offset(
                         0,
                         2,
                      ),
           ),
           
                    ]
                      ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "LOG IN",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () {
                      print('Forgot your password.');
                    },
                    child: Text(
                      'Forgot Password? ',
                      style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    )),
              )
            ],
          ),
                        ),
                      ],
                    ),
          ),
        ));
  }

  Future login() async {
    final String username = _userNameController.text;
    final String password = _passwordController.text;

    final response =
        await http.post(Uri.parse('https://dummyjson.com/auth/login'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, dynamic>{
              'username': username,
              'password': password,
              'expiresInMins': 30,
            }));
    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);
      UsersModel user = UsersModel.fromJson(responseJson);
      print(response.body);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'LOG IN SUCCESSFUL',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          backgroundColor: Colors.green,
        ));
        // widget ile build context arasında bağlantı kurar eğer doğru ise döner.
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(
                user: user,
              ),
            ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'INVALID LOG IN',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.red,
      ));
    }
  }
}
 Widget textFieldWidget(String hinTextTitle,TextEditingController controllerTEXT,IconData iconTheme) => TextField(
      controller: controllerTEXT,
      decoration: InputDecoration(
          hintText: hinTextTitle,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none),
          fillColor: Colors.white.withOpacity(0.7),
          filled: true,
          prefixIcon: Icon(iconTheme)),
    );
