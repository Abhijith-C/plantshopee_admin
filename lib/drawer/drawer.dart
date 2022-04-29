import 'package:admin_plantshopee/constance/constance.dart';
import 'package:admin_plantshopee/screens/help_screen.dart';
import 'package:admin_plantshopee/screens/homeScreen.dart';
import 'package:admin_plantshopee/screens/manageUsersScreen.dart';
import 'package:admin_plantshopee/screens/orderDetails/manage_order.dart';

import 'package:admin_plantshopee/screens/productScreen.dart';
import 'package:admin_plantshopee/screens/salesReportScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              padding: const EdgeInsets.only(top: 20),
              decoration: const BoxDecoration(color: appBarColor),
              child: Column(
                children: const [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                        'https://images.pexels.com/photos/1002703/pexels-photo-1002703.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'PlantShopee',
                    style: TextStyle(color: Colors.white),
                  ),
                  //  Text(
                  //     'plant_shopee',
                  //     style: TextStyle(
                  //         fontWeight: FontWeight.w300, color: Colors.white),
                  //   )
                ],
              )),
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text('Dashboard'),
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (ctx) =>  HomeScreen()),
                  (route) => false);
            },
          ),
          ListTile(
            leading: const Icon(Icons.scale),
            title: const Text('Sales Report'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) =>  SalesReportScreen()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.inventory),
            title: const Text('Manage Products'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) =>  ProducrScreen()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.account_box),
            title: const Text('Manage Users'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) =>  ManageUsersScreen()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.article),
            title: const Text('Manage Orders'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (ctx) => MyOrder()
                      //  OrderScreen(
                      //       title: 'To Confirm',
                      //       appBarTitle: 'All Orders',
                      //     )
                      ));
            },
          ),
          // ListTile(
          //   leading: const Icon(Icons.local_shipping),
          //   title: const Text('Shipment Details'),
          //   onTap: () {
          //     Navigator.pop(context);
          //     // Navigator.of(context).push(MaterialPageRoute(
          //     //     builder: (ctx) => OrderScreen(
          //     //           title: 'Shipped',
          //     //           appBarTitle: 'Shipment Details',
          //     //         )));
          //   },
          // ),
          // ListTile(
          //   leading: const Icon(Icons.notification_add),
          //   title: const Text('Send Notificatons'),
          //   onTap: () {
          //     Navigator.pop(context);
          //     // Navigator.of(context)
          //     //     .push(MaterialPageRoute(builder: (ctx) => const MyOrder()));
          //   },
          // ),
          ListTile(
            leading: const Icon(Icons.help_center),
            title: const Text('Help Center'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (ctx) => HelpScreen()));
            },
          ),
          const Divider(
            thickness: 1,
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context);
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip),
            title: const Text('Privacy Policy'),
            onTap: () {
              Navigator.pop(context);
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              Navigator.pop(context);
              FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
    );
  }
}
