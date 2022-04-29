import 'package:admin_plantshopee/controller/help_controller.dart';
import 'package:admin_plantshopee/controller/notifications.dart';
import 'package:admin_plantshopee/controller/order_controller.dart';
import 'package:admin_plantshopee/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:admin_plantshopee/constance/constance.dart';
import 'package:admin_plantshopee/drawer/drawer.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final _notificationController = Get.put(NotificationController());
  @override
  Widget build(BuildContext context) {
    final _order = Get.put(OrderController());
    Get.put(UserController());
    Get.put(HelpController());
    return Scaffold(
      backgroundColor: appBarColor,
      appBar: AppBar(
        backgroundColor: appBarColor,
        elevation: 0,
        title: const Text(
          'Dashboard',
          style: subHeading,
        ),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications))
        ],
      ),
      drawer: const CustomDrawer(),
      body: SafeArea(
        child: Column(
          children: [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     SizedBox(
            //       width: 120,
            //       height: 50,
            //       child: DropdownButtonHideUnderline(
            //         child: DropdownButton(
            //             alignment: AlignmentDirectional.centerEnd,
            //             hint: const Text(
            //               'All',
            //               style: subHeading,
            //             ),
            //             items: const [
            //               DropdownMenuItem(
            //                 child: Text("Today"),
            //                 value: 1,
            //               ),
            //               DropdownMenuItem(
            //                 child: Text("This Week"),
            //                 value: 2,
            //               ),
            //               DropdownMenuItem(
            //                 child: Text("This Month"),
            //                 value: 3,
            //               )
            //             ],
            //             onChanged: (v) {}),
            //       ),
            //     ),
            //     IconButton(
            //         onPressed: () {}, icon: const Icon(Icons.calendar_month)),
            //   ],
            // ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Container(
                // height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, top: 25),
                  child: Column(
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
                            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                      Flexible(
                        child: ListView.builder(
                            itemCount: _order.processingOrder.length,
                            itemBuilder: ((context, index) {
                              return ListTile(
                                leading: const Icon(Icons.star_border),
                                title: Text(
                                    _order.processingOrder[index].orderId
                                        .toString(),
                                    style: const TextStyle(color: Colors.grey)),
                              );
                            })),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
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
      // color: Colors.grey.shade100,
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
