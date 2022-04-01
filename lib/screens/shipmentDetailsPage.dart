import 'package:admin_plantshopee/constance/constance.dart';
import 'package:admin_plantshopee/screens/orderScreen/orderDetails.dart';
import 'package:flutter/material.dart';

class ShipmentDetailsScreen extends StatelessWidget {
  const ShipmentDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        centerTitle: true,
        title: Text('Shipment Details'),
      ),
      
      body: OrderDetails(),
    );
  }
}
