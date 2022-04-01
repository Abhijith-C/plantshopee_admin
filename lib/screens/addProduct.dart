import 'package:admin_plantshopee/constance/constance.dart';
import 'package:admin_plantshopee/firebase/database.dart';
import 'package:admin_plantshopee/model/plantModel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class AddProduct extends StatelessWidget {
  PlantModel? data;
  AddProduct({Key? key, this.data}) : super(key: key);
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final quantityController = TextEditingController();

  FilePickerResult? image;

  @override
  Widget build(BuildContext context) {
    if (data != null) {
      titleController.text = data!.title;
      descriptionController.text = data!.description;
      priceController.text = data!.price.toString();
      quantityController.text = data!.quantity.toString();
    }
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        centerTitle: true,
        title: const Text(
          'Add Product',
          style: subHeading,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                  hintText: 'Title',
                  filled: true,
                  fillColor: Colors.grey.shade300,
                  border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
            ),
            kHeight18,
            TextField(
                controller: descriptionController,
                maxLines: 8,
                decoration: InputDecoration(
                  hintText: "Description",
                  filled: true,
                  fillColor: Colors.grey.shade300,
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 14.0, horizontal: 18.0),
                  border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                )),
            kHeight18,
            TextFormField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: 'Price',
                  filled: true,
                  fillColor: Colors.grey.shade300,
                  border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
            ),
            kHeight18,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: size.width * 0.44,
                  child: TextFormField(
                    controller: quantityController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 14.0, horizontal: 18.0),
                        hintText: 'Quantity',
                        filled: true,
                        fillColor: Colors.grey.shade300,
                        border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                  ),
                ),
                SizedBox(
                  width: size.width * 0.3,
                  height: 40,
                  child: ElevatedButton(
                      onPressed: () async {
                        image = await FilePicker.platform.pickFiles(
                            allowMultiple: false, type: FileType.image);
                        if (image == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('No file selected')));
                        }

                        // storage.uploadFile(path!, fileName).then((value) => print('done'));
                      },
                      child: const Text('Add Image')),
                )
              ],
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: size.width * 0.36,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(btnRed),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),

                                  // side: BorderSide(color: Colors.red)
                                ))),
                            onPressed: () async {
                              if (data == null) {
                                Navigator.of(context).pop();
                              } else {
                                Navigator.of(context).pop();
                                await deleteProduct(data!.image!, data!.id);
                              }
                            },
                            child: data != null
                                ? const Text('Delete')
                                : const Text('Cancel')),
                      ),
                      SizedBox(
                        width: size.width * 0.36,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.green),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),

                                  // side: BorderSide(color: Colors.red)
                                ))),
                            onPressed: () async {
                              if (data == null) {
                                Navigator.of(context).pop();
                                await addToPlantModel(context);
                              } else {
                                Navigator.of(context).pop();
                                await updateProduct(
                                    data!,
                                    titleController.text.trim(),
                                    descriptionController.text.trim(),
                                    priceController.text.trim(),
                                    quantityController.text.trim());
                              }
                            },
                            child: data != null
                                ? const Text('Update')
                                : const Text('Add Product')),
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

  addToPlantModel(BuildContext context) async {
    final title = titleController.text.trim();
    final description = descriptionController.text.trim();
    final price = priceController.text.trim();
    final quantity = quantityController.text.trim();
    // final imageName = image!.files.single.name;

    final plant = PlantModel(
      title: title,
      description: description,
      price: double.parse(price),
      quantity: int.parse(quantity),
    );
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product Adding Please wait')));
    await addProduct(plant, image!);
    Navigator.pop(context);
  }

  // pickImage() async {
  //   try {
  //     final ImagePicker _picker = ImagePicker();
  //     final image = await _picker.pickImage(source: ImageSource.gallery);
  //     if (image == null) return;
  //     final imageTemp = File(image.path);
  //     this.image = imageTemp;
  //   } on PlatformException catch (e) {
  //     print(e);
  //   }
  //   print(this.image);
  // }
}
