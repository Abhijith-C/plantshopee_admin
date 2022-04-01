import 'package:flutter/material.dart';

import 'package:admin_plantshopee/constance/constance.dart';
import 'package:admin_plantshopee/screens/orderScreen/orderDetails.dart';

class OrderScreen extends StatelessWidget {
  String title;
  String appBarTitle;
  OrderScreen({
    Key? key,
    required this.title,
    required this.appBarTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: AppBar(
          backgroundColor: appBarColor,
          centerTitle: true,
          title: Text(
            appBarTitle,
            style: subHeading,
          )),
      body: ListView.separated(
          itemBuilder: ((context, index) => ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 18),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => const OrderDetails()));
                },
                leading: Image.network(
                    'https://images.pexels.com/photos/1002703/pexels-photo-1002703.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
                title: const Text(
                  'Plant one',
                  style: TextStyle(overflow: TextOverflow.ellipsis),
                ),
                trailing: Text(
                  '711',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                // subtitle: Text(
                //   '$title : 711',
                //   style: TextStyle(color: Colors.blue),
                // ),
                // trailing: IconButton(
                //     onPressed: () {},
                //     icon: const Icon(
                //       Icons.calendar_month,
                //     )),
              )),
          separatorBuilder: (ctx, index) => const Divider(),
          itemCount: 18),
    );
  }
}
