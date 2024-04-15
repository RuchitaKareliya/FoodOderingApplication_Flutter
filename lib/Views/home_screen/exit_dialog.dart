import 'package:flutter/services.dart';
import 'package:foododering_application/consts/consts.dart';
import 'package:foododering_application/widgets_common/our_button.dart';


Widget exitDialog(context)
{
  return Dialog(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        "Conform".text.fontFamily(bold).size(18).color(darkFontGrey).make(),
        Divider(),
        10.heightBox,
        "Are you sure you want to exit?".text.size(18).color(darkFontGrey).make(),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ourButton(color: brownColor,onPress: (){
              SystemNavigator.pop();
            },textColor: whiteColor,title: "Yes"),
            ourButton(color: brownColor,onPress: (){
              Navigator.pop(context);
            },textColor: whiteColor,title: "No"),],)
      ],
    )
    .box
    .color(lightGrey).padding(const EdgeInsets.all(12)).rounded
    .make(),
  );
}