import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Wringdiagrams extends StatelessWidget {
  final Color backColor;
  final IconData iconTheme;
  final String data;
  const Wringdiagrams({super.key, this.backColor= Colors.brown,required this.data,this.iconTheme = Icons.add_box});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Row (children: [ Text(data),SizedBox(width: 10,),Icon(iconTheme)]),
        backgroundColor: backColor,
      ),
    );
  }
}
