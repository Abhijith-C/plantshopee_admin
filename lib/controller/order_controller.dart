import 'package:admin_plantshopee/model/order_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  List<OrderModel> processingOrder = [];
  List<OrderModel> cancelOrder = [];
  List<OrderModel> deliveredOrder = [];
  List<OrderModel> shippedOrder = [];

  getOrders() async {
    processingOrder.clear();
    cancelOrder.clear();
    deliveredOrder.clear();
    shippedOrder.clear();
    final orderCollection = await _db.collection('orders').get();
    List<OrderModel> listOrder =
        orderCollection.docs.map((e) => OrderModel.fromJson(e.data())).toList();
    for (var item in listOrder) {
      if (item.status == 'processing') {
        processingOrder.add(item);
      }
      if (item.status == 'cancel') {
        cancelOrder.add(item);
      }
      if (item.status == 'delivered') {
        deliveredOrder.add(item);
      }
      if (item.status == 'shipped') {
        shippedOrder.add(item);
      }
    }
    update();
  }

  void changeStatus(OrderModel model, String currentStatus) {
    final orderCollection =
        FirebaseFirestore.instance.collection('orders').doc(model.orderId);
    model.status = currentStatus;
    orderCollection.set(model.toJson());
    getOrders();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getOrders();
  }
}
