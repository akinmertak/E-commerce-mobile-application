import 'dart:convert';
// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uygulama_ornek/pageAPI/detailPage.dart';
import 'package:uygulama_ornek/models/modelProduct.dart';

class Searchproduct2 extends StatefulWidget {
  final Color backColor;
  final IconData iconTheme;
  const Searchproduct2({
    super.key,
    this.backColor = Colors.blue,
    this.iconTheme = Icons.search,
  });

  @override
  State<Searchproduct2> createState() => _SearchproductState();
}

class _SearchproductState extends State<Searchproduct2> {
  Future<ListProduct>? productFuture;
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    productFuture = fetchProducts2();
  }

  void searchFunc(String search) {
    setState(() {
      searchQuery = search;
    });
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
                    hintText: 'SEARCH PRODUCT', border: InputBorder.none),
                onChanged: (value) {
                  searchFunc(value);
                },
              ),
            ),
            Icon(Icons.search, color: Colors.black),
          ]),
        ),
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return FutureBuilder<ListProduct>(
            future: productFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
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
                              elevation: 10,
                              backgroundColor: Colors.blue[300],
                              minimumSize: Size(130, 50)),
                          onPressed: () {
                            setState(() {
                              productFuture = fetchProducts2();
                            });
                          },
                          child: Text(
                            'RETRY',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ))
                    ],
                  ),
                );
              } else {
                var products = snapshot.data!.products;
                var filteredProducts = products
                    .where((product) => product.title //koşul tutar product içindeki titleların herbiri eğer searchQuary(girilen metin) içeriyorsa
                        .toLowerCase()
                        .contains(searchQuery.toLowerCase()))
                    .toList();

                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                        orientation == Orientation.portrait ? 2 : 4,
                  ),
                  itemCount: filteredProducts.length,
                  itemBuilder: (context, index) {
                    final product = filteredProducts[index];

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  detailPage(productId: product.id),
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
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade400,
                                  offset: Offset(2.0, 2.0),
                                  blurRadius: 7,
                                  spreadRadius: 0.2)
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
                                  product.category,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ),
                            ),
                            Container(
                              height: 36,
                              color: Colors.blue.shade300,
                              child: Align(
                                alignment: Alignment.center,
                                child: FittedBox(
                                  alignment: Alignment.center,
                                  child: Text(
                                    product.title,
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
                                              product.thumbnail),
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
                                              product.price.toString(),
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
                                              product.stock.toString(),
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
                  },
                );
              }
            },
          );
        },
      ),
    );
  }
}

Future<ListProduct> fetchProducts2() async {
  final response = await http.get(Uri.parse('https://dummyjson.com/products/'));
  if (response.statusCode == 200) {
    return ListProduct.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Unexpected error occurred!');
  }
}



