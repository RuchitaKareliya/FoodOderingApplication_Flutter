import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:foododering_application/consts/consts.dart';
import 'package:foododering_application/widgets_common/our_button.dart';

class PaymentMethods extends StatelessWidget {
  const PaymentMethods({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      bottomNavigationBar: SizedBox(
        height: 60,
        child: ourButton(
          onPress: () {},
          color: brownColor,
          textColor: whiteColor,
          title: "Place My Order",
        ),
      ),
      appBar: AppBar(
        title: "Choose Payment Method"
            .text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
    );
  }
}
