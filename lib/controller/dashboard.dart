// import 'package:admin_plantshopee/controller/order_controller.dart';
// import 'package:admin_plantshopee/controller/user_controller.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:get/get.dart';

// class DashboardController extends GetxController {
//   final OrderController _order = Get.find();
//   final UserController _user = Get.find();
//   double totalProfit = 0;
//   int totalProduct = 0;
//   int totalProductDelivered = 0;
//   int totalUser = 0;
//   int pendingToDeliver = 0;
//   getTotalProduct() async {
//     final product =
//         await FirebaseFirestore.instance.collection('Products').get();
//     totalProduct = product.docs.length;

//     update();
//   }

//   dash() {
//     totalProductDelivered = _order.deliveredOrder.length;
//     totalUser = _user.allUser.length;
//     pendingToDeliver = _order.shippedOrder.length;
//     profit();
//     getTotalProduct();
//   }

//   profit() {
//     double total = 0;
//     _order.deliveredOrder.map((e) {
//       total += e.totalPrice;
//     });
//     totalProfit = total;
//     update();
//   }

//   @override
//   void onInit() {
//     // TODO: implement onInit
//     super.onInit();

//     dash();
//   }
// }
