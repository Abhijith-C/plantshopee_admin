import 'package:admin_plantshopee/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HelpController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<UserModel> user = [];
  List<String> userId = [];
  List<String> orderId = [];
  bool isLoading = true;
  
  getUserId() async {
    isLoading = true;
    user.clear();
    orderId.clear();
    userId.clear();
    final complaintsCollection = await _firestore.collection('chats').get();
    List<String> id = complaintsCollection.docs
        .map((e) => e.data()['userId'] as String)
        .toList();
    userId.addAll(id);
    for (var item in id) {
      user.add(await getUser(item));
      // orderId.add(await getOrderId(item));
    }
    isLoading = false;
    update();
  }

  Future<UserModel> getUser(String id) async {
    UserModel userCollection = await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .get()
        .then((value) => UserModel.formJson(value.data()!));
    // user.add(userCollection);
    return userCollection;
  }

  @override
  void onInit() {
    super.onInit();
    getUserId();
  }
}
