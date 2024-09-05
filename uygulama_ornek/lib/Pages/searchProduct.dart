// ignore_for_file: prefer_const_constructors
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:uygulama_ornek/pageAPI/detailPage.dart';
import 'package:uygulama_ornek/models/modelProduct.dart';

class Searchproduct extends StatefulWidget {
  final Color backColor;

  final String category;
  final IconData iconTheme;
  const Searchproduct({
    super.key,
    this.backColor = Colors.blue,
    this.iconTheme = Icons.search,
    required this.category,
  });

  @override
  State<Searchproduct> createState() => _SearchproductState();
}

class _SearchproductState extends State<Searchproduct> {
  Future<ListProduct>? productFuture;
  List<Products> allProduct = [];
  List<Products> filterProduct = [];
  
  @override
  void initState() {
    super.initState();
    productFuture = fetchProducts(widget.category);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: widget.backColor,
          title: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(children: [
              Expanded(
                  child: TextField(
               
                decoration: InputDecoration(
                    hintText: widget.category, border: InputBorder.none),
              )),
             
            Icon(Icons.search,color: Colors.black,)
            ]),
          ),
        ),
        body: OrientationBuilder(
          builder: (context, orientation) {
            return FutureBuilder<ListProduct>(
              future: productFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  //Verilerin çekilmesi beklenirken yükleme ekranı gelsin.
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'DID NOT FIND INTERNET CONNECTION',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
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
                                fixedSize: Size(130, 50),
                                elevation: 10,
                                backgroundColor: Colors.blue[300]),
                            onPressed: () {
                              setState(() {
                                productFuture = fetchProducts(widget.category);
                              });
                            },
                            child: Text(
                              'RETRY',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ))
                      ],
                    ),
                  );
                } else {
                  var products = snapshot.data!.products;
                  return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            orientation == Orientation.portrait ? 2 : 4,
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final Products = products[index];

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      detailPage(productId: Products.id),
                                ));
                          },
                          child: Align(
                            alignment: Alignment.center,
                            child: Container(
                              width: 200,
                              height: 200,
                              margin: EdgeInsets.all(4.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
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
                                ],
                                color: Colors.white,
                              ),
                              child: Column(children: [
                                Container(
                                  height: 30,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.blue[200],
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(8),
                                          topRight: Radius.circular(8))),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      Products.category,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 36,
                                  //width: double.infinity,
                                  color: Colors.blue.shade300,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: FittedBox(
                                      alignment: Alignment.center,
                                      child: Text(
                                        Products.title,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Container(
                                      height: 60,
                                      width: 70,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  Products.thumbnail),
                                              fit: BoxFit.cover)),
                                    )),
                                SizedBox(
                                  height: 5,
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(8),
                                            child: Row(
                                              children: [
                                                Text(
                                                  Products.price.toString(),
                                                  style: TextStyle(
                                                    fontSize: 12.3,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Icon(
                                                  Icons.euro,
                                                  size: 12.3,
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(8),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons
                                                      .production_quantity_limits,
                                                  size: 12.3,
                                                ),
                                                Text(
                                                  Products.stock.toString(),
                                                  style:
                                                      TextStyle(fontSize: 12.3),
                                                ),
                                              ],
                                            ),
                                          )
                                        ]),
                                  ),
                                )
                              ]),
                            ),
                          ),
                        );
                      });
                }
              },
            );
          },
        ));
  }
}

Future<ListProduct> fetchProducts(String category) async {
  final response = await http
      .get(Uri.parse('https://dummyjson.com/products/category/$category'));
  if (response.statusCode == 200) {
    return ListProduct.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Unexpected error occured!');
  }
}
