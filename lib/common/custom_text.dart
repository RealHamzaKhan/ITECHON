import 'package:flutter/material.dart';

Widget customText({required String text,final double? size,final FontWeight? fw,final Color? color,final TextAlign? alignment}){
  return Text(text,textAlign: alignment,style: appStyle(
    size: size,
    fw: fw,
    color: color
  ),);
}

TextStyle appStyle({final double? size,final FontWeight? fw,final Color? color}){
  return TextStyle(
    fontSize: size,
    fontWeight: fw,
    color: color,
    fontFamily: 'Catamaran'
  );
}