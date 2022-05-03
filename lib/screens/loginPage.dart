import 'package:admin_plantshopee/constance/constance.dart';
import 'package:admin_plantshopee/screens/homeScreen.dart';
import 'package:admin_plantshopee/utils/snackbar.dart';
import 'package:admin_plantshopee/utils/toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: size.height * 0.1, left: size.width * 0.07),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Hello",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Admin.",
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF00FF47)),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            SizedBox(
              width: size.width,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Login",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: size.height * 0.06,
                    ),
                    Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.email),
                                  hintText: 'Enter the Email',
                                  filled: true,
                                  fillColor: Colors.grey.shade300,
                                  border: const OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10)))),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter email Id';
                                }
                                return null;
                              },
                            ),
                            kHeight18,
                            TextFormField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.key),
                                  hintText: 'Enter the Password',
                                  filled: true,
                                  fillColor: Colors.grey.shade300,
                                  border: const OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10)))),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter password';
                                }
                                return null;
                              },
                            ),
                          ],
                        )),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: size.width,
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            if (_passwordController.text.trim() == 'Admin123') {
                              String res = await logIn();
                              toast(context, res);
                            } else {
                              toast(context,
                                  'Please check you username or password',status: false);
                            }
                          }
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(themeColor)),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      )),
    );
  }

  Future<String> logIn() async {
    String? token = await FirebaseMessaging.instance.getToken();
    String resp = 'Please Wait';
    try {
      FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim())
          .then((value) {
        FirebaseFirestore.instance
            .collection('admin')
            .doc('admin')
            .set({'token': token});
        resp = 'Loged In Successfuly';
      });
    } on FirebaseAuthException catch (err) {
      if (err.code == 'invalid-email') {
        resp = 'Invalid email or password';
      }
      if (err.code == 'user-not-found') {
        resp = 'User not found';
      }
      if (err.code == 'invalid-email') {
        resp = 'Invalid emial address';
      }
    }
    return resp;
  }
}
