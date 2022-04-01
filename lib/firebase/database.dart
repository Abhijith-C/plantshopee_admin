import 'dart:io';
import 'package:admin_plantshopee/model/plantModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

Future<void>addProduct(PlantModel plant, FilePickerResult image) async {
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
      // print('...........$imageUrl');
    } on FirebaseException catch (e) {
      print(e);
    }
 

  // print(plant.toJson());
  productDB.set(plant.toJson());
}
