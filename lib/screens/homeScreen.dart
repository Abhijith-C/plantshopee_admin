import 'package:admin_plantshopee/controller/help_controller.dart';
import 'package:admin_plantshopee/controller/notifications.dart';
import 'package:admin_plantshopee/controller/order_controller.dart';
import 'package:admin_plantshopee/controller/user_controller.dart';
import 'package:admin_plantshopee/screens/manage_order.dart';
import 'package:flutter/material.dart';
import 'package:admin_plantshopee/constance/constance.dart';
import 'package:admin_plantshopee/drawer/drawer.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(NotificationController());
    Get.put(OrderController());
    Get.put(UserController());
    Get.put(HelpController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: appBarColor,
        elevation: 0,
        title: const Text(
          'Dashboard',
          style: subHeading,
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (ctx) => MyOrder()));
              },
              icon: const Icon(Icons.local_shipping_outlined))
        ],
      ),
      drawer: const CustomDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: 200,
                color: appBarColor,
              ),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, top: 25),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GetBuilder<UserController>(
                        builder: (_user) {
                          return CardBetween(
                            title: 'Total User',
                            amount: _user.allUser.length.toString(),
                          );
                        },
                      ),
                      GetBuilder<OrderController>(
                        builder: (_dash) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CardBetween(
                                title: 'Total Profit',
                                amount: '₹ ${_dash.totalProfit.toString()}',
                              ),
                              CardBetween(
                                title: 'Total Product',
                                amount: _dash.totalProduct.toString(),
                              ),
                              CardBetween(
                                title: 'Total Delivered',
                                amount: _dash.deliveredOrder.length.toString(),
                              ),
                              CardBetween(
                                title: 'Pending to Deliver',
                                amount: _dash.shippedOrder.length.toString(),
                              ),
                              CardBetween(
                                title: 'New Orders',
                                amount: _dash.processingOrder.length.toString(),
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        'New Orders',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey),
                      ),
                      kHeight18,
                      GetBuilder<OrderController>(
                        builder: (_order) {
                          if (_order.isLoading == true) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (_order.processingOrder.isEmpty) {
                            return const Center(
                                child: Text('No new orders found'));
                          } else {
                            return ListView.builder(
                                shrinkWrap: true,
                                primary: false,
                                itemCount: _order.processingOrder.length,
                                itemBuilder: ((context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Wrap(
                                      crossAxisAlignment: WrapCrossAlignment.center,
                                      alignment: WrapAlignment.center,
                                      spacing: 20,
                                      children: [
                                        const Icon(
                                          Icons.star_outline,
                                          color: Colors.grey,
                                        ),
                                        Text(
                                            _order
                                                .processingOrder[index].orderId
                                                .toString(),
                                            style: const TextStyle(
                                                color: Colors.grey,
                                                overflow:
                                                    TextOverflow.ellipsis)),
                                      ],
                                    ),
                                  );
                                }));
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardBetween extends StatelessWidget {
  String title;
  String amount;
  CardBetween({
    Key? key,
    required this.title,
    required this.amount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade100,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$title :',
              style: subHeading,
            ),
            Text(
              amount,
              style: const TextStyle(fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}
