import 'package:admin_plantshopee/constance/constance.dart';
import 'package:flutter/material.dart';



class ViewOrderDetails extends StatelessWidget {
  String status;
  Color color;
  ViewOrderDetails({
    Key? key,
    required this.status,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Order Details',
            style: subHeading,
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Order ID : 1234567890'),
              kHeight18,
              const Divider(),
              ListTile(
                contentPadding: const EdgeInsets.only(left: 10),
                leading: Image.network(
                    'https://cdn.pixabay.com/photo/2015/04/19/08/33/flower-729512__340.jpg'),
                title: const Text('Plant one'),
                subtitle: Text(
                  status,
                  style: TextStyle(color: color),
                ),
              ),
              kHeight18,
              // const AmountContainer(),
              // kHeight18,
              // const Align(
              //   alignment: Alignment.topLeft,
              //   child: const Text(
              //     'Shipped Address',
              //   ),
              // ),
              // kHeight18,
              // const ShippingAddress(),
              // kHeight18,
              SizedBox(
                width: size.width,
                height: 45,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigator.of(context).pop();
                  },
                  child: const Text(
                    "Cancel Order",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                    const Color.fromARGB(255, 255, 102, 92),
                  )),
                ),
              ),
              kHeight18,
              SizedBox(
                width: size.width,
                height: 45,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigator.of(context).pushReplacement(MaterialPageRoute(
                    //     builder: (ctx) => const CheckoutPage()));
                  },
                  child: const Text(
                    "Need Help ?",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black)),
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
