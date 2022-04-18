import 'package:admin_plantshopee/constance/constance.dart';
import 'package:admin_plantshopee/controller/order_controller.dart';
import 'package:admin_plantshopee/firebase/database.dart';
import 'package:admin_plantshopee/model/order_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyOrder extends StatelessWidget {
  MyOrder({Key? key}) : super(key: key);
  final OrderController _orderController = Get.find();

  @override
  Widget build(BuildContext context) {
    _orderController.getOrders();
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'My Orders',
            style: subHeading,
          ),
          bottom: const TabBar(
            indicatorColor: Colors.black,
            labelColor: Colors.black,
            isScrollable: true,
            tabs: [
              Tab(
                text: 'Processing',
              ),
              Tab(
                text: 'Shipped',
              ),
              Tab(
                text: 'Delivered',
              ),
              Tab(
                text: 'Canceled',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            GetBuilder<OrderController>(
              builder: (controller) {
                if (controller.processingOrder.isEmpty) {
                  return const Center(
                    child: Text('No Order Found'),
                  );
                } else {
                  return ListView.builder(
                      itemBuilder: (context, index) {
                        final order = controller.processingOrder[index];
                        return OrderInfo(
                          order: order,
                          color: Colors.blue,
                        );
                      },
                      itemCount: controller.processingOrder.length);
                }
              },
            ),
            GetBuilder<OrderController>(
              builder: (controller) {
                if (controller.shippedOrder.isEmpty) {
                  return const Center(
                    child: Text('No Order Found'),
                  );
                } else {
                  return ListView.builder(
                      itemBuilder: (context, index) {
                        final order = controller.shippedOrder[index];
                        return OrderInfo(
                          order: order,
                          color: Color.fromARGB(255, 223, 202, 14),
                        );
                      },
                      itemCount: controller.shippedOrder.length);
                }
              },
            ),
            GetBuilder<OrderController>(
              builder: (controller) {
                if (controller.deliveredOrder.isEmpty) {
                  return const Center(
                    child: Text('No Order Found'),
                  );
                } else {
                  return ListView.builder(
                      itemBuilder: (context, index) {
                        final order = controller.deliveredOrder[index];
                        return OrderInfo(
                          order: order,
                          color: Colors.green,
                        );
                      },
                      itemCount: controller.deliveredOrder.length);
                }
              },
            ),
            GetBuilder<OrderController>(
              builder: (controller) {
                if (controller.cancelOrder.isEmpty) {
                  return const Center(
                    child: Text('No Order Found'),
                  );
                } else {
                  return ListView.builder(
                      itemBuilder: (context, index) {
                        final order = controller.cancelOrder[index];
                        return OrderInfo(
                          order: order,
                          color: Colors.red,
                        );
                      },
                      itemCount: controller.cancelOrder.length);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class OrderInfo extends StatelessWidget {
  OrderModel order;
  Color color;
  OrderInfo({Key? key, required this.order, required this.color})
      : super(key: key);
  final OrderController _orderController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:8.0),
      child: Card(
        color: bgCard,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    'Order No : ${order.orderId}',
                    overflow: TextOverflow.ellipsis,
                  )),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Ordered Date : ${order.createdDate}',
                style: const TextStyle(
                    color: Colors.grey, overflow: TextOverflow.ellipsis),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Divider(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Quantity : ${order.cartModel.quantity}'),
                  Text(
                      'Total Amount : ₹ ${(order.cartModel.quantity) * (order.cartModel.price)}')
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  (order.status != 'cancel')
                      ? DropdownButton<String>(
                          hint: Text(order.status),
                          items: <String>['shipped', 'delivered']
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (value) {
                            _orderController.changeStatus(order, value!);
                            print(value);
                          },
                        )
                      : SizedBox(),
                  Text(
                    order.status,
                    style: TextStyle(color: color),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
