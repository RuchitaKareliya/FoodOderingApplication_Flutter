import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foododering_application/Views/home_screen/home.dart';
import 'package:foododering_application/consts/consts.dart';
import 'package:foododering_application/consts/list.dart';
import 'package:foododering_application/consts/string.dart';
import 'package:foododering_application/controllers/cart_controller.dart';
import 'package:foododering_application/widgets_common/loading_indicator.dart';
import 'package:foododering_application/widgets_common/our_button.dart';
import 'package:get/get.dart';


class PaymentMethods extends StatelessWidget {
  const PaymentMethods({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Obx( 
      () => Scaffold(
        backgroundColor: whiteColor,
        bottomNavigationBar: SizedBox(
          height: 60,
          child: controller.placingOrder.value 
          ? Center(
            child: loadingIndicator(),
          ) : ourButton(
            onPress: () async {
              controller.placeMyOrder(
                orderPaymentMethod: paymentMethods[controller.paymentIndex.value],
                totalAmount: controller.totalP.value);

                await controller.clearCart();
                VxToast.show(context, msg: "Order Placed Successfully");
                Get.off(const Home());
                

            },
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
      
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Obx(
            () => Column(
              children: List.generate(paymentMethodsImg.length, (index){
                return GestureDetector(
                  onTap: (){
                    controller.changePaymentIndex(index);
                  },
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: controller.paymentIndex.value == index ? brownColor: Colors.transparent,
                        width: 4,
                  
                      ),
                    ),
                    margin: EdgeInsets.only(bottom: 8),
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Image.asset(paymentMethodsImg[index], 
                        width: double.infinity, 
                        height: 120, 
                        colorBlendMode: controller.paymentIndex.value == index?  BlendMode.darken : BlendMode.color,
                        color: controller.paymentIndex.value == index? Colors.black.withOpacity(0.4) : Colors.transparent,
                        fit:BoxFit.cover
                      ),
                        controller.paymentIndex.value==index? Transform.scale(
                          scale: 1.3,
                          child: Checkbox(
                            activeColor: Colors.green,                      
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                            value: true, onChanged: (value) {},),
                        ): Container(),
      
                        Positioned(
                          bottom: 10,
                          right: 10,
                          child: paymentMethods[index].text.white.fontFamily(semibold).size(16).make()),
      
                        
                        ],
                      ),
                  ),
                );
              }),
              
            ),
          ),
        ),
      ),
    );
  }
}
