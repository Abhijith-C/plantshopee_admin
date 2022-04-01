class PlantModel {
  String id;
  String title;
  String description;
  double price;
  int quantity;
  String? image;
  PlantModel({
    this.id = '',
    required this.title,
    required this.description,
    required this.price,
    required this.quantity,
    this.image,
  });
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'price': price,
        'quantity': quantity,
        'image': image
      };
  static PlantModel fromJson(Map<String, dynamic> json) => PlantModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: json['price'],
      quantity: json['quantity'],
      image: json['image']);
}
