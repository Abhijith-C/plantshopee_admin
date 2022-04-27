import 'dart:io';
import 'package:admin_plantshopee/controller/order_controller.dart';
import 'package:admin_plantshopee/model/order_model.dart';
import 'package:admin_plantshopee/model/plantModel.dart';
import 'package:admin_plantshopee/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
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

Future<List<String>> getOrderId(String id) async {
  final orderIdCollection = await FirebaseFirestore.instance
      .collection('chats')
      .doc(id)
      .collection('messages')
      .get();
  final order =
      orderIdCollection.docs.map((e) => e.data()['orderId'] as String).toList();
  return order;
}

Future<String>getToken(String id) async {
  final token =
      await FirebaseFirestore.instance.collection('users').doc(id).get();
  return token.data()!['tocken'];
}
