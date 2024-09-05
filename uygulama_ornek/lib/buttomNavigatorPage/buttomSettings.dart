import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uygulama_ornek/home_screen.dart';


class Buttomsettings extends StatelessWidget {
  const Buttomsettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Positioned(  top: 16, left: 16,
            child: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>HomeScreen()
                  ));
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 30,
            )),
      ),
      Center(
        child: Text(
          'Ayarlar butonuna hoş geldiniz.',
          style: TextStyle(fontSize: 10),
        ),
      ),
    ]));
  }
}
