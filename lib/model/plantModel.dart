class PlantModel {
  String id;
  String title;
  String description;
  double price;
  int quantity;
  PlantModel({
    this.id = '',
    required this.title,
    required this.description,
    required this.price,
    required this.quantity,
  });
  Map<String, dynamic> toJson() => {
    'id' : id,
    'title': title,
    'description': description,
    'price': price,
    'quantity': quantity,
  };
}
