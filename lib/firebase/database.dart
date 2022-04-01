import 'package:admin_plantshopee/model/plantModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void addProduct(PlantModel plant) {
  final productDB = FirebaseFirestore.instance.collection('Products').doc();
  plant.id = productDB.id;
  // print(plant.toJson());
  productDB.set(plant.toJson());
}
