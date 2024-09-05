import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Comminication extends StatelessWidget {
  final Color backColor;
  final IconData iconTheme;
  final String data;
  const Comminication({super.key, this.backColor= Colors.brown,required this.data,this.iconTheme = Icons.add_box});

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(appBar: AppBar(
        title:Row (children: [ Text(data),SizedBox(width: 10,),Icon(iconTheme)]),
        backgroundColor: backColor,
      ),

      body:  Center( child: Column( mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
        children: [Align( child: Text("COMMINICATION NUMBER: +905554479465",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),))
        ,Text("E-MAIL: shoppingapp@gmail.com ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)],
      ),),
    ); 
  }
}