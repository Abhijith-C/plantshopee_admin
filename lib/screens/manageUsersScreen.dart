import 'package:admin_plantshopee/constance/constance.dart';
import 'package:admin_plantshopee/controller/user_controller.dart';
import 'package:admin_plantshopee/screens/userProfileScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManageUsersScreen extends StatelessWidget {
  ManageUsersScreen({Key? key}) : super(key: key);
  final UserController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    _controller.getAllUser();
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
          child: GetBuilder<UserController>(builder: (controller) {
            if (controller.allUser.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.separated(
                  itemBuilder: ((context, index) {
                    final user = controller.allUser[index];
                    return ListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => const UserProfileScreen()));
                      },
                      leading: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.white,
                          backgroundImage: (user.image != null)
                              ? NetworkImage(user.image!)
                              : const AssetImage('assets/images/profile.png')
                                  as ImageProvider),
                      title: Text(user.username),
                      subtitle: Text(
                        user.userId!,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.block,
                            color: btnRed,
                          )),
                    );
                  }),
                  separatorBuilder: (ctx, index) => const Divider(),
                  itemCount: controller.allUser.length);
            }
          })),
    );
  }
}
