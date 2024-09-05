class Products {
  late int id;
  late String title;
  late String description;
  late String category;
  late double price;
  late int stock;
  late String thumbnail;
  
  
  
  Products(this.id, this.title, this.description, this.category, this.price,
      this.stock,this.thumbnail);
  

  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
      json['id'] as int,
      json['title'] as String,
      json['description'] as String ,
      json['category'] as String,
      (json['price'] as num).toDouble(),
      json['stock'] as int  ,
      json['thumbnail'] as String   ,             //API dan gelen veriyi Dart nesnesine dönüştürmmek için bir model sınıfı oluşturuyoruz.

    );
  }
}
class ListProduct {
  final List<Products> products;

  ListProduct({required this.products});

  factory ListProduct.fromJson(Map<String, dynamic> json) {   //olusşturduğumuz products classını liste şekline getiriyoruz.
    var list = json['products'] as List;
    List<Products> productsList = list.map((i) => Products.fromJson(i)).toList();//Products da tanımladığımız json verilerini listeye dönüştürüyoruz
     //iterable olduğu için listeye çevirdik.
    return ListProduct(products: productsList);
  }
}
