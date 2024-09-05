import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Facebook extends StatelessWidget {
  const Facebook({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
       Positioned(//geri tuşunu sol üste yerleştirdik.
        top: 16.0,
        left: 16.0,
         child: IconButton(
          onPressed: () {
            Navigator.pop(
              context,
            );
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 30,
          ),
               ),
       ),
      Center(
        child: Text('FACEBOOK'),
      ),
    ]));
  }
}
