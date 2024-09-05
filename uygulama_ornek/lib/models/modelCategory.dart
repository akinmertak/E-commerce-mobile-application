class CategoryModel {
  String? slug;
  String? name;
  String? url;
  CategoryModel({this.name, this.slug, this.url});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      slug: json["slug"],
      name: json["name"],
      url: json['url'],
    );
  }
  Map<String, dynamic> toJson() => {
        "slug": slug,
        "name": name,
        "url": url,
      };
}

