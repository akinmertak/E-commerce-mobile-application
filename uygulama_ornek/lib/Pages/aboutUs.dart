import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:uygulama_ornek/models/modelPosts.dart';

// ignore_for_file: prefer_const_constructors

class Aboutus extends StatefulWidget {
  final Color backColor;
  final IconData iconTheme;
  final String data;
  const Aboutus(
      {super.key,
      this.backColor = Colors.brown,
      required this.data,
      this.iconTheme = Icons.add_box});

  @override
  State<Aboutus> createState() => _AboutusState();
}

class _AboutusState extends State<Aboutus> {
  late Future<Modelposts> postDetailsFuture;
  String searchQuary = "";

  @override
  void initState() {
    super.initState();
    postDetailsFuture = fetchModelDetails();
  }

  void searchFunc(String search) {
    setState(() {
      searchQuary = search;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search...",
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.white70),
                ),
                style: TextStyle(color: Colors.white),
                onChanged: (value) {
                  searchFunc(value);
                },
              ),
            ),
            Icon(widget.iconTheme),
          ]),
          backgroundColor: widget.backColor,
        ),
        body: OrientationBuilder(builder: (context, orientation) {
          return FutureBuilder<Modelposts>(
            future: postDetailsFuture,
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
                              postDetailsFuture = fetchModelDetails();
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
                var posts = snapshot.data!.posts!;
                var filteredPost = posts.where((post) {
                  final searchLower = searchQuary.toLowerCase();
                  return post.title!.toLowerCase().contains(searchLower) ||
                      post.body!.toLowerCase().contains(searchLower);
                }).toList();

                return ListView.builder(
                  itemCount: filteredPost.length,
                  itemBuilder: (context, index) {
                    var post = filteredPost[index];

                    return Padding(
                      padding: EdgeInsets.all(8),
                      child: SizedBox(
                        height: 250,
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.blue, width: 0.5),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withOpacity(0.2),
                                spreadRadius: 3,
                                blurRadius: 6,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Text(
                                  post.title!,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    post.body!,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 12.5,
                                        fontWeight: FontWeight.w500),
                                  )),
                              Wrap(
                                  children: post.tags != null
                                      ? post.tags!.map((tag) {
                                          return Container(
                                            width: 60,
                                            height: 18,
                                            margin: EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius:
                                                  BorderRadius.circular(8),
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(left: 8),
                                          child: Icon(
                                            Icons.thumb_up_alt,
                                            size: 20,
                                            color: Colors.blue,
                                          )),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        post.reactions!.likes.toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.thumb_down_alt,
                                        color: Colors.red,
                                        size: 20,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        post.reactions!.dislikes.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.remove_red_eye,
                                        size: 20,
                                        color: Colors.green,
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(right: 8),
                                          child: Text(
                                            post.views.toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ))
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            },
          );
        }));
  }
}

Future<Modelposts> fetchModelDetails() async {
  final response = await http.get(Uri.parse('https://dummyjson.com/posts'));

  if (response.statusCode == 200) {
    return Modelposts.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load product details');
  }
}
