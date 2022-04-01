import 'package:admin_plantshopee/constance/constance.dart';
import 'package:admin_plantshopee/screens/userProfileScreen.dart';
import 'package:flutter/material.dart';

class ManageUsersScreen extends StatelessWidget {
  const ManageUsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
     
      appBar: AppBar(
        backgroundColor: appBarColor,
        centerTitle: true,
        title: const Text(
          'Manage Users',
          style: subHeading,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
            itemBuilder: ((context, index) => ListTile(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => const UserProfileScreen()));
                  },
                  leading: const CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                        'https://i.insider.com/5dcc135ce94e86714253af21?width=1000&format=jpeg&auto=webp'),
                  ),
                  title: const Text('User one'),
                  subtitle: const Text('User ID : 1234567890'),
                  trailing: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.block,
                        color: btnRed,
                      )),
                )),
            separatorBuilder: (ctx, index) => const Divider(),
            itemCount: 20),
      ),
    );
  }
}
