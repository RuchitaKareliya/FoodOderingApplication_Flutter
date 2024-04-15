import'package:foododering_application/consts/consts.dart';
import 'package:flutter/material.dart';

Widget bgWidget({Widget? child}){
  return Container(
    decoration: const BoxDecoration(color: Color.fromRGBO(183, 104, 58, 1)),
    //decoration: const BoxDecoration(color: Color.fromRGBO(49, 49, 149, 1)),
    //decoration: const BoxDecoration(image:DecorationImage(image: AssetImage(imgBackground),fit: BoxFit.fill)),
    child:child,

  );
}