import 'dart:convert';
// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:uygulama_ornek/Pages/searchProduct.dart';
import 'package:uygulama_ornek/models/modelCategory.dart';
import 'package:http/http.dart' as http;

class ProductCategoryPage extends StatefulWidget {
  final String data;
  final Color backColor;
  final IconData iconTheme;
  const ProductCategoryPage(
      //this zorunlu değil atanmazsa da bunu ata, requiment kesinlikle atanmalı
      {super.key,
      this.data = "CATEGORY PAGE",
      this.backColor = Colors.blue,
      this.iconTheme = Icons.shopping_cart});

  @override
  State<ProductCategoryPage> createState() => _TechnicalsupportState();
}

class _TechnicalsupportState extends State<ProductCategoryPage> {
  late Future<List<CategoryModel>> categoryModelFuture;

  @override
  void initState() {
    super.initState();
    categoryModelFuture = fetchCategoryDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(children: [
          Text(widget.data),
          SizedBox(
            width: 10,
          ),
          Icon(widget.iconTheme)
        ]),
        backgroundColor: widget.backColor,
      ),
      body: FutureBuilder<List<CategoryModel>>(
        future: categoryModelFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'DID NOT FIND INTERNET CONNECTION',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Icon(
                    Icons.wifi_off,
                    color: Colors.red,
                    size: 25,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 10,
                          backgroundColor: Colors.blue[300],
                          minimumSize: Size(130, 50)),
                      onPressed: () {
                        setState(() {
                          categoryModelFuture = fetchCategoryDetails();
                        });
                      },
                      child: Text(
                        'RETRY',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ))
                ],
              ),
            );
          } else {
            final categoryList = snapshot.data!;
            return ListView.builder(
                itemCount: categoryList.length,
                itemBuilder: (context, index) {
                  final categoryValue = categoryList[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Searchproduct(
                              category: categoryValue.slug!,
                            ),
                          ));
                    },
                    child: SizedBox(
                      height: 85,
                      width: double.infinity,
                      child: Card(
                        color: Colors.blue.shade200,
                        margin: EdgeInsets.all(8),
                        child: ListTile(
                          title: Row(children: [
                            Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  categoryValue.name!,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20),
                                )),
                            Expanded(
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Icon(
                                      Icons.arrow_forward_ios_outlined,
                                      color: Colors.white,
                                      size: 35,
                                    )))
                          ]),
                        ),
                      ),
                    ),
                  );
                });
          }
        },
      ),
    );
  }
}

Future<List<CategoryModel>> fetchCategoryDetails() async {
  final response =
      await http.get(Uri.parse('https://dummyjson.com/products/categories'));
  if (response.statusCode == 200) {
    List<dynamic> jsonList = json.decode(response.body);
    return jsonList.map((json) => CategoryModel.fromJson(json)).toList();
  } else {
    throw Exception('Error Failed');
  }
}
