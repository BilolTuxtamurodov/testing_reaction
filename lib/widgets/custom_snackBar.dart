import 'package:flutter/material.dart';

void showSnackBar (BuildContext context, String message, [Color? backgroundColor, Color? iconColor]) {
  var snackBar = SnackBar(
    content: Text(message,),
    duration: Duration(seconds: 3),
    showCloseIcon: true,
    backgroundColor: backgroundColor??Colors.grey,
    closeIconColor: iconColor??Colors.white,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}