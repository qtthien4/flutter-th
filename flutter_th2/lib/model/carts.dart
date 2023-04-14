class Cart {
  late Product product;
  String? sId;
  String? userId;

  Cart({required this.product, this.sId, this.userId});

  Cart.fromJson(Map<String, dynamic> json) {
    product = (json['product'] != null
        ? new Product.fromJson(json['product'])
        : null)!;
    sId = json['_id'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    data['_id'] = this.sId;
    data['userId'] = this.userId;
    return data;
  }
}

class Product {
  String? title;
  String? description;
  String? image;
  late String price;

  Product({this.title, this.description, this.image, required this.price});

  Product.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    image = json['image'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['image'] = this.image;
    data['price'] = this.price;
    return data;
  }
}
