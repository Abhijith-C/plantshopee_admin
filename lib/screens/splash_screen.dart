import 'package:admin_plantshopee/screens/home.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const Home(),
          ),
          (route) => false);
    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: Image.asset('assets/images/plant_shopee.png')),
      
    );
  }
}