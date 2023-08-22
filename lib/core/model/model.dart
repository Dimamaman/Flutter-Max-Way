
class Category {
  String id;
  Description title;
  List<Product> products;

  Category._({
    required this.id,
    required this.title,
    required this.products,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category._(
        id: json['id'] ?? '',
        title: Description.fromJson(json['title'] ?? {}),
        products: ((json['products'] ?? []) as List).map((e) => Product.fromJson(e)).toList()
    );
  }

  factory Category.empty({String id = '', String title = '', List<Product> products = const []}) => Category._(
      id: id,
      title: Description._(uz: title),
      products: products
  );
}

class Description {
  String uz;

  Description._({
    required this.uz,
  });

  factory Description.fromJson(Map<String,dynamic> json) {
    return Description._(
      uz: json['uz'] ?? '',
    );
  }
}

class Product {
  String id;
  int price;
  String currency;
  String image;
  Description title;
  Description description;

  Product._({
    required this.id,
    required this.price,
    required this.currency,
    required this.image,
    required this.title,
    required this.description,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product._(
      id: json['id'] ?? '',
      price: json['out_price'] ?? 1,
      currency: json['currency'] ?? '',
      image: json['image'] ?? '',
      title: Description.fromJson(json['title'] ?? {}),
      description: Description.fromJson(json['description'] ?? {}),
    );
  }

  factory Product.empty() => Product._(
    id: '',
    price: 0,
    currency: '',
    image: '',
    title: Description._(uz: ''),
    description: Description._(uz: ''),
  );

}