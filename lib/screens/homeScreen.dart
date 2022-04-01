import 'package:flutter/material.dart';
import 'package:admin_plantshopee/constance/constance.dart';
import 'package:admin_plantshopee/drawer/drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        actions: [IconButton(onPressed: () {
          
        }, icon: const Icon(Icons.notifications))],
      ),
      drawer: const CustomDrawer(),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 120,
                  height: 50,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                        alignment: AlignmentDirectional.centerEnd,
                        hint: const Text(
                          'All',
                          style: subHeading,
                        ),
                        items: const [
                          DropdownMenuItem(
                            child: Text("Today"),
                            value: 1,
                          ),
                          DropdownMenuItem(
                            child: Text("This Week"),
                            value: 2,
                          ),
                          DropdownMenuItem(
                            child: Text("This Month"),
                            value: 3,
                          )
                        ],
                        onChanged: (v) {}),
                  ),
                ),
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.calendar_month)),
              ],
            ),
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
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CardBetween(
                        title: 'Profit',
                        amount: '₹ 3245632',
                      ),
                      CardBetween(
                        title: 'Product',
                        amount: '79',
                      ),
                      CardBetween(
                        title: 'Delivered',
                        amount: '749',
                      ),
                      CardBetween(
                        title: 'User',
                        amount: '179',
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
