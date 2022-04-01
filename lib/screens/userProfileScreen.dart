import 'package:admin_plantshopee/constance/constance.dart';
import 'package:admin_plantshopee/customWidgets/customRow.dart';
import 'package:admin_plantshopee/customWidgets/userAddress.dart';
import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

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
        padding: const EdgeInsets.only(left: 4,right: 4,top: 20,bottom: 10),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: CircleAvatar(
                radius: size.width * 0.26,
                backgroundImage: const NetworkImage(
                    'https://i.insider.com/5dcc135ce94e86714253af21?width=1000&format=jpeg&auto=webp'),
              ),
            ),
            kHeight18,
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                child: Column(
                  children: [
                   CustomRow(title: 'Name', content: 'John'),
                   const Divider(),
                    CustomRow(title: 'ID', content: '1234567890'),
                    const Divider(),
                    CustomRow(title: 'Mobile Number', content: '0987654321'),
                     const Divider(),
                    CustomRow(title: 'Email ID', content: 'john@gmail.com')
                  ],
                ),
              ),
            ),
            kHeight12,
            UserAddress(),
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
                              backgroundColor:
                                  MaterialStateProperty.all(Color.fromARGB(255, 23, 147, 168)),
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


