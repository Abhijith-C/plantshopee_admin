import 'package:admin_plantshopee/constance/constance.dart';
import 'package:admin_plantshopee/model/plantModel.dart';
import 'package:admin_plantshopee/screens/addProduct.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProducrScreen extends StatelessWidget {
  ProducrScreen({Key? key}) : super(key: key);

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
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (ctx) => AddProduct()));
                    },
                    child: const Text('Add Product'))
              ],
            ),
            kHeight12,
            Expanded(
                child: StreamBuilder<List<PlantModel>>(
                    stream: readPlants(),
                    builder: (context, snapshot) {
                      print(snapshot);
                      if (snapshot.data!.isNotEmpty || snapshot.data == null) {
                        final plant = snapshot.data;
                        return ListView.separated(
                            itemBuilder: ((context, index) => ListTile(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (ctx) => AddProduct(
                                                  data: plant![index],
                                                )));
                                  },
                                  leading: Image.network(
                                    plant![index].image!,
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                  ),
                                  title: Text(
                                    plant[index].title,
                                    style: const TextStyle(
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                  subtitle: Text(
                                      'In Stock : ${plant[index].quantity}'),
                                  // trailing: IconButton(
                                  //     onPressed: () {

                                  //     },
                                  //     icon: const Icon(
                                  //       Icons.edit,
                                  //       color: Colors.blue,
                                  //     )),
                                )),
                            separatorBuilder: (ctx, index) => const Divider(),
                            itemCount: plant!.length);
                      } else {
                        return const Center(
                          child: Text('No Products Fount', style: TextStyle(fontSize: 20,color: Colors.red,fontWeight: FontWeight.bold),),
                        );
                      }
                    }))
          ],
        ),
      ),
    );
  }

  Stream<List<PlantModel>> readPlants() => FirebaseFirestore.instance
      .collection('Products')
      .snapshots()
      .map((event) =>
          event.docs.map((doc) => PlantModel.fromJson(doc.data())).toList());
}
