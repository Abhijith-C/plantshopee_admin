import 'package:admin_plantshopee/controller/notifications.dart';
import 'package:admin_plantshopee/firebase/database.dart';
import 'package:admin_plantshopee/model/order_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final NotificationController _notification = Get.find();
  List<OrderModel> processingOrder = [];
  List<OrderModel> cancelOrder = [];
  List<OrderModel> deliveredOrder = [];
  List<OrderModel> shippedOrder = [];
  List<OrderModel> allOrder = [];
  int totalProduct = 0;
  double totalProfit = 0;

  void getAllOrder() async {
    allOrder.clear();
    final orderCollection = await _db.collection('orders').get();
    List<OrderModel> listOrder =
        orderCollection.docs.map((e) => OrderModel.fromJson(e.data())).toList();
    for (var item in listOrder) {
      allOrder.add(item);
    }
    update();
  }

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
    getTotalProfit();
  }

  void changeStatus(OrderModel model, String currentStatus) async {
    String token = await getTokenId(model.userId!);
    final orderCollection =
        FirebaseFirestore.instance.collection('orders').doc(model.orderId);
    model.status = currentStatus;
    orderCollection.set(model.toJson()).then((value) {
      _notification.sendPushMessage(
          token, 'Your product was $currentStatus', currentStatus);
    });
    getOrders();
  }

  sortOrderCustom(DateTime days) async {
    allOrder.clear();
    final orderCollection = await _db
        .collection('orders')
        .orderBy('createdDate', descending: false)
        .startAt([days.millisecondsSinceEpoch]).get();
    List<OrderModel> listOrder =
        orderCollection.docs.map((e) => OrderModel.fromJson(e.data())).toList();
    for (var item in listOrder) {
      allOrder.add(item);
    }
    update();
  }

  sortOrder(DateTime start, DateTime end) async {
    allOrder.clear();
    final orderCollection = await _db
        .collection('orders')
        .orderBy('createdDate', descending: false)
        .startAt([start.millisecondsSinceEpoch]).endAt(
            [end.millisecondsSinceEpoch]).get();
    List<OrderModel> listOrder =
        orderCollection.docs.map((e) => OrderModel.fromJson(e.data())).toList();
    for (var item in listOrder) {
      allOrder.add(item);
    }
    update();
  }

  getTotalProduct() async {
    final product =
        await FirebaseFirestore.instance.collection('Products').get();
    totalProduct = product.docs.length;

    update();
  }

  getTotalProfit() {
    double sum = 0;
    for (var item in deliveredOrder) {
      sum = sum + item.totalPrice;
    }
    totalProfit = sum;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    getOrders();
    getTotalProduct();
  }
}
