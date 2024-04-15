import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foododering_application/consts/consts.dart';
import 'package:flutter/material.dart';

Widget detailsCard({width,String? count,String?title}) {
  return  Column(
         mainAxisAlignment: MainAxisAlignment.center,
          children: [
          count!.text.fontFamily(bold).color(darkFontGrey).size(16).white.make(),
           5.heightBox,
           title!.text.color(darkFontGrey).make(),
         ],
     ).box.white.rounded.width(width).height(80).padding(EdgeInsets.all(4)).make();
        
}