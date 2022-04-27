import 'package:admin_plantshopee/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:admin_plantshopee/controller/help_controller.dart';
import 'package:admin_plantshopee/firebase/database.dart';

class ComplaintScreen extends StatelessWidget {
  String id;
  ComplaintScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Complaints')),
      body: FutureBuilder<List<String>>(
          future: getOrderId(id),
          builder: (contex, snap) {
            if (snap.data == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                  itemCount: snap.data!.length,
                  itemBuilder: (ctx, index) {
                    String orderId = snap.data![index];
                    return ListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => ChatScreen(
                                  userId: id,
                                  id: orderId,
                                )));
                      },
                      leading: Icon(Icons.account_box),
                      title: Text(orderId),
                    );
                  });
            }
          }),
    );
  }
}