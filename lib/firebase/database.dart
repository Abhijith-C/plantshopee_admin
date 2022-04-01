import 'dart:io';
import 'package:admin_plantshopee/model/plantModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

Future<void> addProduct(PlantModel plant, FilePickerResult image) async {
  final productDB = FirebaseFirestore.instance.collection('Products').doc();
  final FirebaseStorage storage = FirebaseStorage.instance;
  final path = image.files.single.path;
  final fileName = image.files.single.name;
  plant.id = productDB.id;
  File file = File(path!);
  try {
    final ref = storage.ref('tes/$fileName');
    final link = await ref.putFile(file).whenComplete(() => null);
    String imageUrl = await link.ref.getDownloadURL();
    plant.image = imageUrl;
  } on FirebaseException catch (e) {
    print(e);
  }
  productDB.set(plant.toJson());
}

Future<void> deleteProduct(String ref, String id) async {
  final FirebaseStorage storage = FirebaseStorage.instance;
  final productDB = FirebaseFirestore.instance.collection('Products').doc(id);
  productDB.delete();
  storage.refFromURL(ref).delete();
}

Future<void> updateProduct(PlantModel plant,  String title,
    String description, String price, String quantity) async {
      final FirebaseStorage storage = FirebaseStorage.instance;
  final productDB = FirebaseFirestore.instance.collection('Products').doc(plant.id);
  plant.title = title;
  plant.description = description;
  plant.price = double.parse(price);
  plant.quantity = int.parse(quantity);
  productDB.update(plant.toJson());
}
