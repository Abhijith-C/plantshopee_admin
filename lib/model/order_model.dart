import 'package:admin_plantshopee/model/address_model.dart';
import 'package:admin_plantshopee/model/cart_model.dart';

class OrderModel {
  String? userId;
  String? orderId;
  DateTime createdDate;
  CartModel cartModel;
  AddressModel address;
  String status;
  double totalPrice;
  String payment;
  OrderModel({
    this.userId,
    this.orderId,
    required this.createdDate,
    required this.cartModel,
    required this.address,
    required this.status,
    required this.totalPrice,
    required this.payment,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'orderId': orderId,
      'createdDate': createdDate.millisecondsSinceEpoch,
      'address': address.toJson(),
      'status': status,
      'payment': payment,
      'totalPrice': totalPrice,
      'cartModel': cartModel.toJson()
    };
  }

  static OrderModel fromJson(Map<String, dynamic> map) {
    return OrderModel(
        userId: map['userId'],
        orderId: map['orderId'],
        createdDate:DateTime.fromMillisecondsSinceEpoch(map['createdDate']),
        address: AddressModel.fromJson(map['address']),
        status: map['status'] ?? '',
        totalPrice: map['totalPrice'] ?? '',
        cartModel: CartModel.fromJson(map['cartModel']),
        payment: map['payment'] ?? '');
  }
}
