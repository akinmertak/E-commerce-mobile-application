
import 'package:flutter/material.dart';
import 'package:uygulama_ornek/models/modelUsers.dart';
// ignore_for_file: prefer_const_constructors

class Userinformation extends StatelessWidget {
  final String data;

  final UsersModel? user;
  final Color backColor;
  final IconData iconTheme; //mecbur gelecek ana ekranda istenecek.
  const Userinformation(
      {super.key,
      required this.iconTheme,
      this.backColor = Colors.lime,
      this.data = 'Satiş temsilcileri butonu',
      this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(children: [
          Text(data),
          SizedBox(
            width: 10,
          ),
          Icon(iconTheme)
        ]),
        backgroundColor: backColor,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      user!.firstName!,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      user!.lastName!,
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Text(
                        'ID: ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      )),
                  Text(
                    user!.id!.toString(),
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
                  )
                ],
              ),
              Container(
                  height: 200,
                  width: 200,
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 0.2, color: Colors.black)),
                  child: ClipOval(
                      child: Image.network(
                    user!.image!,
                    fit: BoxFit.cover,
                  ))),
              SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Text(
                          'USERNAME: ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        )),
                    Text(
                      user!.username!,
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey,
                thickness: 0.5,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Text(
                          'GENDER: ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        )),
                    Text(
                      user!.gender!,
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
                    )
                  ],
                ),
              ),
              Divider(
                color: Colors.grey,
                thickness: 0.5,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Text(
                          'MAIL ADRESS:  ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        )),
                    Text(
                      user!.email!,
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
                    )
                  ],
                ),
              ),
              Divider(
                color: Colors.grey,
                thickness: 0.5,
              ),
        ExpansionTile(title: Text('TOKEN: ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
        children: [Text(user!.token!,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400),)],),
           Divider(color: Colors.grey,thickness: 0.5,),
          ExpansionTile(title: Text('REFRESH TOKEN: ',style: TextStyle(fontWeight: FontWeight.bold,fontSize:15 ),),
         children: [Text(user!.refreshToken!,style: TextStyle(fontWeight: FontWeight.w400,fontSize: 15),)], )],
          ),
        ),
      ),
    );
  }
}
