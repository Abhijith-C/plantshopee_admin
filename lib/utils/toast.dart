import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

toast(BuildContext context,String msg,{bool status = true}) {
FToast  fToast = FToast();
    fToast.init(context);

  fToast.showToast(
        child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.greenAccent,
        ),
        child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
           const SizedBox(
             height: 16,
             width: 16,
             child: CircularProgressIndicator(color: Colors.black,)),
           const SizedBox(
            width: 12.0,
            ),
            Text(msg),
        ],
        )),
        gravity: (status == true) ? ToastGravity.BOTTOM : ToastGravity.TOP,
        toastDuration:const Duration(seconds: 2),
    );
}
