import 'package:admin_plantshopee/constance/constance.dart';
import 'package:admin_plantshopee/orderDetails/viewOrderDetails.dart';
import 'package:flutter/material.dart';


class MyOrder extends StatelessWidget {
  const MyOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
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
            tabs: [
              Tab(
                text: 'Delivered',
              ),
              Tab(
                text: 'Processing',
              ),
              Tab(
                text: 'Canceled',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ListView.builder(
                itemBuilder: ((context, index) => OrderInfo(
                      status: 'Delivered',
                      color: Colors.black,
                    )),
                itemCount: 10),
            ListView.builder(
                itemBuilder: ((context, index) => OrderInfo(
                      status: 'Processing',
                      color: Colors.blue,
                    )),
                itemCount: 10),
            ListView.builder(
                itemBuilder: ((context, index) => OrderInfo(
                      status: 'Canceled',
                      color: Colors.red,
                    )),
                itemCount: 10),
          ],
        ),
      ),
    );
  }
}

class OrderInfo extends StatelessWidget {
  String status;
  Color color;
  OrderInfo({
    Key? key,
    required this.status,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: bgCard,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Order No : 1234567890'),
                  Text(
                    '20/03/2020',
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Divider(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Quantity : 03'),
                  Text('Total Amount : ₹ 799')
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 100,
                    height: 40,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color(0xFF242424))),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => ViewOrderDetails(
                                    status: status,
                                    color: color,
                                  )));
                        },
                        child: const Text('Detail')),
                  ),
                  Text(
                    status,
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
