import 'dart:io';
import 'package:admin_plantshopee/model/plantModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

Future<void> addProduct(PlantModel plant, FilePickerResult image) async {
  final productDB = FirebaseFirestore.instance.collection('Products').doc();
  plant.id = productDB.id;
  plant.image = await imageUpload(image);
  productDB.set(plant.toJson());
}

Future<String?> imageUpload(FilePickerResult image) async {
  final FirebaseStorage storage = FirebaseStorage.instance;
  final path = image.files.single.path;
  final fileName = image.files.single.name;
  File file = File(path!);
  try {
    final ref = storage.ref('productImages/$fileName');
    final link = await ref.putFile(file).whenComplete(() => null);
    String imageUrl = await link.ref.getDownloadURL();
    return imageUrl;
  } on FirebaseException catch (e) {
    print(e);
  }
}

Future<void> deleteProduct(String ref, String id) async {
  final productDB = FirebaseFirestore.instance.collection('Products').doc(id);
  deleteImage(ref).whenComplete(() => productDB.delete());
}

Future<void> deleteImage(String ref) async {
  final FirebaseStorage storage = FirebaseStorage.instance;
  storage.refFromURL(ref).delete();
}

Future<void> updateProduct(PlantModel plant, FilePickerResult? image) async {
  final productDB =
     FirebaseFirestore.instance.collection('Products').doc(plant.id);
  if (image != null) {
    await deleteImage(plant.image!).whenComplete(() async {
      plant.image = await imageUpload(image);
    });
  }
  await productDB.update(plant.toJson());
}
