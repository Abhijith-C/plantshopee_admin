import 'package:admin_plantshopee/constance/constance.dart';
import 'package:admin_plantshopee/drawer/drawer.dart';
import 'package:admin_plantshopee/screens/addProduct.dart';
import 'package:flutter/material.dart';

class ProducrScreen extends StatelessWidget {
  const ProducrScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: appBarColor,
        centerTitle: true,
        title: const Text(
          'Manage Products',
          style: subHeading,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 5, left: 15, right: 15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'All Products',
                  style: subHeading,
                ),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.green),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),

                          // side: BorderSide(color: Colors.red)
                        ))),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) =>  AddProduct()));
                    },
                    child: const Text('Add Product'))
              ],
            ),
            kHeight12,
            Expanded(
                child: ListView.separated(
                    itemBuilder: ((context, index) => ListTile(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) =>  AddProduct()));
                          },
                          leading: Image.network(
                              'https://images.pexels.com/photos/1002703/pexels-photo-1002703.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
                          title: const Text('Plant one',style: TextStyle(overflow: TextOverflow.ellipsis),),
                          subtitle: const Text('In Stock : 711'),
                          // trailing: IconButton(
                          //     onPressed: () {

                          //     },
                          //     icon: const Icon(
                          //       Icons.edit,
                          //       color: Colors.blue,
                          //     )),
                        )),
                    separatorBuilder: (ctx, index) => const Divider(),
                    itemCount: 18))
          ],
        ),
      ),
    );
  }
}
