class ModelCardDetail {
  List<Cart>? carts;
  int? limit;
  int? total;
  int? skip;

  
  ModelCardDetail({this.carts, this.limit, this.skip, this.total});

  factory ModelCardDetail.fromJson(Map<String, dynamic> json) =>
      ModelCardDetail(
        carts: json["carts"] == null
            ? []
            : List<Cart>.from(json["carts"]!.map((x) => Cart.fromJson(x))),
        total: json["total"],
        limit: json["limit"],
        skip: json["skip"],
      );

  Map<String, dynamic> toJson() => {
        "carts": carts == null
            ? []
            : List<dynamic>.from(carts!.map((x) => x.toJson())),
        "total": total,
        "skip": skip,
        "limit": limit,
      };
}

class Cart {
  int? id;
  List<Product>? products;
  double? total;
  double? discountedTotal;
  int? userId;
  int? totalProducts;
  int? totalQuantity;

  Cart(
      {this.id,
      this.products,
      this.total,
      this.discountedTotal,
      this.userId,
      this.totalProducts,
      this.totalQuantity});

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
      id: json["id"],
      products: json["products"] == null
          ? []
          : List<Product>.from(
              json["products"]!.map((x) => Product.fromJson(x))),
      total: json["total"]?.toDouble(),
      discountedTotal: json["discountedTotal"]?.toDouble(),
      userId: json["userId"],
      totalProducts: json["totalProducts"],
      totalQuantity: json["totalQuantity"]);
  Map<String, dynamic> toJson() => {
        "id": id,
        "products": products == null
            ? []
            : List<dynamic>.from(products!.map((x) => x.toJson())),
        "total": total,
        "discountedTotal": discountedTotal,
        "userId": userId,
        "totalProducts": totalProducts,
        "totalQuantity": totalQuantity,
      };
}

class Product {
  int? id;
  String? title;
  double? price;
  int? quantity;
  double? total;
  double? discountPercentage;
  double? discountedTotal;
  String? thumbnail;

  Product(
      {this.id,
      this.title,
      this.price,
      this.quantity,
      this.total,
      this.discountPercentage,
      this.discountedTotal,
      this.thumbnail});

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        title: json["title"],
        price: json["price"]?.toDouble(),
        quantity: json["quantity"],
        total: json["total"]?.toDouble(),
        discountPercentage: json["discountPercentage"]?.toDouble(),
        discountedTotal: json["discountedTotal"]?.toDouble(),
        thumbnail: json["thumbnail"],
      );
  Map<String, dynamic> toJson() => {
    "id":id,
    "title":title,
    "price":price,
    "quantity":quantity,
    "total":total,
    "discountPercentage":discountPercentage,
    "discountedTotal":discountedTotal
  };
}
