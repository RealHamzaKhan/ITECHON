import 'package:flutter/material.dart';

Widget authBackground({required Widget child}){
  return Scaffold(
    body: Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.black,
        image: DecorationImage(image: AssetImage("assets/images/auth_background.png"),fit: BoxFit.fill),
      ),
      child: child,
    ),
  );
}