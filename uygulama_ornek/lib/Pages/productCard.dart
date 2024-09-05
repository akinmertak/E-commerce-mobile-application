import 'dart:convert';
// ignore_for_file: prefer_const_constructors
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:uygulama_ornek/models/modelCardDetail.dart';

class ProductCart extends StatefulWidget {
  final String data;
  final Color backColor;
  final IconData iconTheme;
  const ProductCart({
    super.key,
    this.data = 'Barkodunuzu tarayiniz.',
    required this.backColor,
    this.iconTheme = Icons.ac_unit,
  });

  @override
  State<ProductCart> createState() => _ProductCartState();
}

class _ProductCartState extends State<ProductCart> {
  
  late Future<ModelCardDetail> modelCardDetailFuture;
  int selected = -1;
  @override
  void initState() {
    super.initState();
    modelCardDetailFuture = fetchmodelCardDetail();
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
      body: FutureBuilder<ModelCardDetail>(
        future: modelCardDetailFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
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
                          modelCardDetailFuture = fetchmodelCardDetail();
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
            final cart = snapshot.data!.carts!;
            return ListView.builder(
              itemCount: cart.length,
              itemBuilder: (context, index) {
                final cartValue = cart[index];
                return Card(
                  color: Colors.red.shade200,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: ExpansionTile(
                        key: Key(index.toString()),
                      initiallyExpanded:  index == selected,
                        onExpansionChanged: (newState) {
                          setState(() {
                            selected = newState
                                ? index
                                : -1; //eğer yeni bir durum gellmişse yeni indexe güncelle gelmezse aynı selected kal
                          });
                        },
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'ID: ${cartValue.id!.toString()}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 10),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 15),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.topCenter,
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        'Total Price: ${cartValue.total!.toString()}',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Align(
                                      alignment: Alignment.topRight,
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          'Total Quantity: ${cartValue.totalQuantity}',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10),
                                        ),
                                      )),
                                )
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.bottomLeft,
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        'Total Discounted: ${cartValue.discountedTotal}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 10),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 15),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Text(
                                      'User ID: ${cartValue.userId}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 10),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Text(
                                      'Total Products: ${cartValue.totalProducts}',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        children: [
                          ...cartValue.products!.map((productCart) {
                            return ListTile( 
                                leading: Image.network(productCart.thumbnail!),
                                title: Text(
                                  productCart.title!,
                                  style: TextStyle(color: Colors.white),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Price: ${productCart.price}',
                                      style: TextStyle(color: Colors.white60),
                                    ),
                                    Text(
                                      'Quantity: ${productCart.quantity}',
                                      style: TextStyle(color: Colors.white60),
                                    ),
                                    Text(
                                      'Total: ${productCart.total}',
                                      style: TextStyle(color: Colors.white60),
                                    ),
                                    Text(
                                      'Discount Percentage: ${productCart.discountPercentage} %',
                                      style: TextStyle(color: Colors.white60),
                                    ),
                                    Text(
                                      'Discounted Total: ${productCart.discountedTotal}',
                                      style: TextStyle(color: Colors.white60),
                                    ),
                                    Divider(
                                      color: Colors.black,
                                      thickness: 0.5,
                                    )
                                  ],
                                ));
                          })
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

Future<ModelCardDetail> fetchmodelCardDetail() async {
  final response = await http.get(Uri.parse('https://dummyjson.com/carts'));

  if (response.statusCode == 200) {
    return ModelCardDetail.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load product details');
  }
}
