import 'package:admin_plantshopee/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
 final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<UserModel> allUser = [];

  getAllUser() async {
    allUser.clear();
    final userCollection = await _firestore.collection('users').get();
    List<UserModel> users =
        userCollection.docs.map((e) => UserModel.formJson(e.data())).toList();
    allUser.addAll(users);
    update();
  }

  @override
  void onInit() {
    super.onInit();
    getAllUser();
  }
}
