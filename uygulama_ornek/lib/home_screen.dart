// ignore_for_file: prefer_const_constructors

import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:uygulama_ornek/Pages/comminication.dart';
import 'package:uygulama_ornek/Pages/loginScreen.dart';
import 'package:uygulama_ornek/Pages/userInformation.dart';
import 'package:uygulama_ornek/Pages/productCard.dart';
import 'package:uygulama_ornek/Pages/aboutUs.dart';
import 'package:uygulama_ornek/Pages/productCategoryPage.dart';
import 'package:uygulama_ornek/Pages/searchProduct2(forHomePage).dart';
import 'package:uygulama_ornek/buttomNavigatorPage/buttomSearch.dart';
import 'package:uygulama_ornek/buttomNavigatorPage/buttomSettings.dart';
import 'package:uygulama_ornek/drawerpages/homePage.dart';
import 'package:uygulama_ornek/models/modelUsers.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  final UsersModel? user;
  HomeScreen({super.key, this.user});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 1; //bir değişken atadık.
  List<Widget> naviButtomlist = [
    Buttomsearch(),
    Homepage(),
    Buttomsettings(),
  ]; //liste oluşturulmalı bu liste dönecek.

  void _onItemTapped(int index) {
    // dödürülmesi gereken fonksiyon yazıldı,selectedindex sıfırdan başlayacak ve her ontap edildiğinde index değerine eşitlenip bir artacak
    setState(() {
      selectedIndex = index;
    });
    switch (index) {
      //switch ile bir if yapısı oluşturduk ve hangi durumlarda nereye gideceğini söyledik.Bu şekilde naviButtomlist[selectedİndex]yazmaya gerek kalmadı.
      case 0:
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Searchproduct2(),
            ));
        break;
      case 1:
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ));
        break;
      case 2:
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>ProductCategoryPage(),
            ));
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( backgroundColor: Color.fromARGB(255, 240, 240, 240), 
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: _onItemTapped, //tıklama fonksiyonu verildi.
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed, //düzeltme ortalama
        backgroundColor: Colors.orangeAccent,
        
        items: const [
          BottomNavigationBarItem(
              icon: Tooltip( 
                  message: 'Search',
                  child: Icon(
                    Icons.search,
                    size: 30,
                  )),
              label: ''),
          BottomNavigationBarItem(
            icon: Tooltip(
                message: 'Home',
                child: Icon(
                  Icons.home,
                  size: 30,
                )),
            label: '',
          ),
          BottomNavigationBarItem(
              icon: Tooltip(
                  message: 'Categories',
                  child: Icon(
                    Icons.shopping_cart,
                    size: 30,
                  )),
              label: '')
        ],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black54,
      ),
      appBar: AppBar(
        title: GestureDetector( 
            onTap: () => launchUrl('https://www.butkon.com/'),
            child: Text(" Shopping APP",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
          ),
       
        centerTitle: true,
         flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.orange, Colors.pinkAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight)),
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          children: [
            DrawerHeader(
              child:
               
                  containerDrawer(),
            
                
            
            ),
            myDriwerItem(Icons.facebook_rounded, 'FACEBOOK', context,
                'https://www.facebook.com/butkonasansorlift/'),
            myDriwerItem(Icons.play_circle_fill, 'YOUTUBE', context,
                'https://www.youtube.com/channel/UCdHjvnXipSOXSVGUno2ID8w'),
            myDriwerItem(Icons.business_center, 'LİNKEDLN', context,
                'https://tr.linkedin.com/company/butkonlift'),
            myDriwerItem(Icons.camera_alt_rounded, 'INSTAGRAM', context,
                'https://www.instagram.com/butkonlift/'),
            myDriwerItem(Icons.stay_current_portrait_rounded, 'TWİTTER',
                context, 'https://x.com/ButkonAsansor/'),
            myDriwerItem(
                Icons.web, 'WEB PAGE', context, 'https://www.butkon.com/'),
                SizedBox(height: 20,),
            TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Loginscreen(),
                      ));
                },
                child: const Row(
                  children: [
                    Icon(
                      Icons.logout,
                      color: Colors.black,
                      size: 22.5,
                    ), SizedBox(width: 7.5,), Text(
                      'LOG OUT',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ))
          ],
        ),
      ), //yan menü ekleme.
      body: OrientationBuilder(builder: (context, orientation) {
        return GridView.count(padding: EdgeInsets.all(16),
            crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
            childAspectRatio: 0.9,
            //orientationBuilder widgetı yan ve dikey gösterimi oranlamayı sağlar.

            children: [
             
              myContainerValues(
                Icons.search,
                context,
                Searchproduct2(
                  iconTheme: Icons.search,
                ),
                'SEARCH PRODUCT',
                Colors.orange,
              ),
              myContainerValues(
                Icons.shopping_cart,
                context,
                ProductCategoryPage(
                  data: 'CATEGORİES',
                  backColor: Colors.blue,
                  iconTheme: Icons.shopping_cart,
                ),
                'CATEGORİES',
                Colors.blue,
              ),
              myContainerValues(
                  Icons.info_rounded,
                  context,
                  Aboutus(
                    data: "HAKKIMIZDA",
                    backColor: Colors.grey,
                    iconTheme: Icons.search,
                  ),
                  'ABOUT US',
                  Colors.grey),
              myContainerValues(
                Icons.production_quantity_limits,
                context,
                ProductCart(
                  data: "PRODUCT CARD",
                  backColor: Colors.red.shade400,
                  iconTheme: Icons.production_quantity_limits,
                ),
                'PRODUCT CARD',
                Colors.red.shade400,
              ),
              myContainerValues(
                Icons.person,
                context,
                Userinformation(
                  data: "USERS INFORMATION",
                  backColor: Colors.purple,
                  iconTheme: Icons.person_add,
                  user: widget.user,
                ),
                'USERS INFORMATION',
                Colors.purple,
              ),
            
              myContainerValues(
                Icons.call,
                context,
                Comminication(
                  data: "İLETİŞİM",
                  backColor: Colors.pink,
                  iconTheme: Icons.call,
                ),
                'COMMUNICATION',
                Colors.pinkAccent,
              ),
             
             
             
            
          
                
            ]);
      }),
    );
  }

//Methodların çıkarıldığı yerler.
  Widget containerDrawer() => GestureDetector(
        onTap: () => launchUrl('https://www.butkon.com/'),
        child: Align (alignment: Alignment.topCenter,
          child: Container(
            //açılan menünün üst kısmına ana başlık atma kısa yolu
            height: 150,
            width: 200,
            decoration:  BoxDecoration(
                color: Colors.white,
                image: DecorationImage( fit: BoxFit.cover,
                  image: AssetImage('assets/images/app.png',),
                )),
          ),
        ),
      );

  Widget myDriwerItem(
          IconData icon, String title, BuildContext context, String url) =>
      ListTile(
        //parametre belirlendi değişlik gösteren yerler yazılıp fonksiyonu çağırdığımda benden bunları isteyecek.
        leading: Icon(
          icon,
          color: Colors.black,
        ),
        title: Text(title),
        onTap: () async {
          launchUrl(url);
        },
      );
}

Widget myContainerValues(
  IconData iconSym,
  BuildContext context,
  Widget contnvgtr,
  String title,
  Color clr,
) =>
    GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => contnvgtr,
            ));
      },
      child: Container( 
        margin: EdgeInsets.all(
            8), //margin kutunun dışıyla arasındaki boşlukları düzenler padding ise içerden.
        
        height: 400,
        width: 100,decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: clr,
  ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconSym,
              color: Colors.white,
              size: 40,
            ),
            Text(
              textAlign: TextAlign.center, //textleri her şekilde ortalar.
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
void launchUrl(String url) async {
  //asenkron çalışma fonksiyonun çalışmasının uzun süreceğini ve bu sürede başka fonksiyon çalışabilecceğini belirtir.
  final Uri uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrlString(
        url); //await bu fonksiyonu asenkron olarak çalıştır ve bitince diğerine geç.
  } else {
    throw 'Belirtilen siteye geçiş sağlanamadi. $url';
  }
}
