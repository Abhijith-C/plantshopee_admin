import 'package:flutter/material.dart';

import 'package:admin_plantshopee/constance/constance.dart';
import 'package:admin_plantshopee/customWidgets/customRow.dart';
import 'package:admin_plantshopee/customWidgets/userAddress.dart';
import 'package:admin_plantshopee/model/user_model.dart';

class UserProfileScreen extends StatelessWidget {
  UserModel user;
  UserProfileScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: appBarColor,
        centerTitle: true,
        title: const Text(
          'User Profile',
          style: subHeading,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 4, right: 4, top: 20, bottom: 10),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: CircleAvatar(
                  radius: size.width * 0.26,
                  backgroundImage: (user.image != null)
                      ? NetworkImage(user.image!)
                      : const AssetImage('assets/images/profile.png')
                          as ImageProvider),
            ),
            kHeight18,
            Card(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Column(
                  children: [
                    CustomRow(title: 'Name', content: user.username),
                    const Divider(),
                    CustomRow(title: 'ID', content: user.userId!),
                    const Divider(),
                    CustomRow(title: 'Mobile Number', content: user.mobileNumber),
                    const Divider(),
                    CustomRow(title: 'Email ID', content: user.email)
                  ],
                ),
              ),
            ),
            // kHeight12,
            // UserAddress(),
            kHeight18,
            Expanded(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: size.width * 0.36,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                 const Color.fromARGB(255, 23, 147, 168)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),

                                // side: BorderSide(color: Colors.red)
                              ))),
                          onPressed: () {
                            // Navigator.of(context).push(MaterialPageRoute(
                            //     builder: (ctx) => const ProducrScreen()));
                          },
                          child: const Text('Message')),
                    ),
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
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Block')),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
