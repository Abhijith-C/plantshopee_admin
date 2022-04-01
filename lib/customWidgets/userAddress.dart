import 'package:flutter/material.dart';

class UserAddress extends StatelessWidget {
  const UserAddress({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Address',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            Divider(
              thickness: 2,
            ),
            Text(
              'address line one',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'address line two',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '1234567890',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '234567',
              style: TextStyle(fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}
