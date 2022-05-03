import 'package:admin_plantshopee/constance/constance.dart';
import 'package:admin_plantshopee/screens/chat_screen.dart';
import 'package:flutter/material.dart';
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
      appBar: AppBar(title: const Text('Order Id'),centerTitle: true, backgroundColor: appBarColor),
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
                      leading: const Icon(Icons.report,size: 40,),
                      title: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(orderId)),
                    );
                  });
            }
          }),
    );
  }
}
