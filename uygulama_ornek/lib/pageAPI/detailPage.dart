import 'dart:convert';
// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:uygulama_ornek/models/modelProductDetail.dart';
import 'package:http/http.dart' as http;

class detailPage extends StatefulWidget {
  final int productId;
  const detailPage({super.key, required this.productId});

  @override
  State<detailPage> createState() => _ApiPageState();
}

class _ApiPageState extends State<detailPage> {
  late Future<ProductModels> productDetailsFuture;
  @override
  void initState() {
    super.initState();
    productDetailsFuture = fetchProductDetails(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          centerTitle: true,
          title: FutureBuilder<ProductModels>(
            future: productDetailsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading...");
              } else if (snapshot.hasError) {
                return Text("Error");
              } else {
                final product = snapshot.data!;
                return Text(
                  product.title!,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                );
              }
            },
          ),
        ),
        body: FutureBuilder<ProductModels>(
          future: productDetailsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
               return Center(
              child: Column( mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'DID NOT FIND INTERNET CONNECTION',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,fontSize: 15
                    ),
                  ), SizedBox(height: 10,),
                  Icon(
                    Icons.wifi_off,
                    color: Colors.red,size: 25,
                  ),SizedBox(height: 10,),
                  ElevatedButton(style: ElevatedButton.styleFrom(elevation: 10,backgroundColor: Colors.blue[300],minimumSize: Size(130, 50) ),
                      onPressed: () {
                        setState(() {
                          productDetailsFuture = fetchProductDetails(widget.productId);
                        });
                      },
                      child: Text(
                        'RETRY',
                        style: TextStyle(
                             fontWeight: FontWeight.bold,color: Colors.white),
                      ))
                ],
              ),
            );
            } else {
              final product = snapshot.data!;
              return SingleChildScrollView(
                child: Center(
                    child: Column(children: [ 
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Product Code: ',
                            style: TextStyle(
                                color: Colors.orange,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            product.sku!,
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Text(product.brand ?? '',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 12.5),),
                  if (product.thumbnail !=
                      null) //null olup olmadığını kontrol et ona göre değer ata;
                    Container(
                        margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            border:
                                Border.all(width: 0.5, color: Colors.orange),
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: 5.0,
                                  color: Colors.grey.shade100,
                                  blurRadius: 5,
                                  offset: Offset(1.0, 1.0))
                            ]),
                        child: Image.network(product.thumbnail!)),
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        Text(
                          product.rating.toString(),
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        )
                      ]),
                  SizedBox(
                    height: 30,
                  ),
                  Divider(
                    color: Colors.grey,
                    thickness: 0.5,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              product.price.toString(),
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Icon(Icons.euro),
                          ],
                        ),
                        Column(children: [
                          Text(
                            '%${product.discountPercentage.toString()} Discount',
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.w500),
                          )
                        ]),
                        Icon(Icons.discount),
                      ],
                    ),
                    SizedBox(
                      width: 200,
                    ),
                    Text(
                      product.stock.toString(),
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(Icons.production_quantity_limits_outlined)
                  ]),
                  SizedBox(
                    height: 20,
                  ),
                  Divider(
                    color: Colors.grey,
                    thickness: 0.5,
                  ),
                  if (product.description != null)
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        product.description!,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  SizedBox(
                    height: 40,
                  ),
                  Wrap(
                      children: product.tags != null
                          ? product.tags!.map((tag) {
                              return Container(
                                width: 70,
                                height: 20,
                                margin: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    '#$tag',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 8.5,
                                    ),
                                  ),
                                ),
                              );
                            }).toList()
                          : []),
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Product Reviews',
                        style: TextStyle(
                          color: Colors.orange,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                    thickness: 0.5,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ListTile(
                      title: product.reviews != null
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: ListTile.divideTiles(
                                context: context,
                                tiles: product.reviews!.map((review) {
                                  String letter =
                                      ''; //boş bir letter tanımladık
                                  if (review.reviewerName != null) {
                                    List<String> letterName =
                                        review.reviewerName!.split(' ');
                                    if (letterName.isNotEmpty) {
                                      //eğer letterName listesi boş değilse ilk elamanını al
                                      letter = letterName[0][
                                          0]; //letterName in ilk elemanının ilk harfini tut
                                      letter += letterName[1][0];
                                    }
                                  }

                                  return ListTile(
                                    leading: CircleAvatar(
                                      radius: 40,
                                      backgroundColor: Colors.orange,
                                      child: Text(
                                        letter.toUpperCase(),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    title: Row(
                                      children: [
                                        Text(
                                          review.reviewerName!,
                                          style: TextStyle(
                                              color: Colors.orange,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Expanded(
                                          child: Text(
                                            review.date!,
                                            style: TextStyle(
                                              fontSize: 8.5,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            textAlign: TextAlign.right,
                                          ),
                                        )
                                      ],
                                    ),
                                    subtitle: Column(
                                      children: [
                                        Row(children: [
                                          Text(
                                            review.comment!,
                                            style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w500,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                          ),
                                          SizedBox(
                                            width: 30,
                                          ),
                                        ]),
                                        Row(
                                          children: [
                                            for (int i = 1; i <= 5; i++)
                                              i <= review.rating!
                                                  ? Icon(
                                                      Icons.star,
                                                      color: Colors.yellow,
                                                      size: 16,
                                                    )
                                                  : Icon(
                                                      Icons.star,
                                                      size: 16,
                                                    ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Expanded(
                                                child: Text(
                                              review.reviewerEmail!,
                                              style: TextStyle(fontSize: 8.5),
                                              textAlign: TextAlign.right,
                                            ))
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ).toList())
                          : Text('no data')),
                ])),
              );
            }
          },
        ));
  }
}

Future<ProductModels> fetchProductDetails(int id) async {
  final response =
      await http.get(Uri.parse('https://dummyjson.com/products/$id'));

  if (response.statusCode == 200) {
    return ProductModels.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load product details');
  }
}
