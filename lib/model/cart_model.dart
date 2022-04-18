class CartModel {
  String productId;
  int quantity;
  double price;
  CartModel({
    required this.productId,
    required this.quantity,
    required this.price,
  });

  Map<String, dynamic> toJson() =>
      {'productId': productId, 'quantity': quantity, 'price' : price};

  static CartModel fromJson(Map<String, dynamic> json) =>
      CartModel(productId: json['productId'], quantity: json['quantity'], price: json['price']);
}
