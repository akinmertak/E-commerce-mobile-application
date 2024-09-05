import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:flutter/rendering.dart';
import 'package:uygulama_ornek/Pages/loginScreen.dart';

void main() {
  runApp(Uygulamam());
}

class Uygulamam extends StatelessWidget {
  const Uygulamam({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home:  Loginscreen(),
      debugShowCheckedModeBanner: false,//debug başlık yazısını kapatma
    );
  }
}
       