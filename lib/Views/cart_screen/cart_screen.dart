import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foododering_application/consts/consts.dart';
import 'package:foododering_application/services/firebase_services.dart';
import 'package:foododering_application/widgets_common/loading_indicator.dart';
import 'package:foododering_application/widgets_common/our_button.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: "Shopping cart"
            .text
            .color(darkFontGrey)
            .fontFamily(semibold)
            .make(),
      ),
      body: StreamBuilder(
        stream: FirestorServices.getCart(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: loadingIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: "Cart is empty".text.color(darkFontGrey).make(),
            );
          } else {
            var data = snapshot.data!.docs;
            return Padding(
              padding: const EdgeInsets.all(0.8),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            leading: Image.network(
                              "${data[index]['img']}"
                            ),
                            title: "${data[index]['title']}".text.fontFamily(semibold).make(),
                            subtitle: "${data[index]['tprice']}".numCurrency.text.fontFamily(semibold).color(brownColor).make(),


                          );
                        }
                      ),
                      )
                      ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      "Total Price".text.fontFamily(semibold).make(),
                      "40"
                          .numCurrency
                          .text
                          .fontFamily(semibold)
                          .color(redColor)
                          .make(),
                    ],
                  )
                      .box
                      .padding(EdgeInsets.all(12))
                      .color(lightGolden)
                      .width(context.screenWidth - 60)
                      .make(),
                  10.heightBox,
                  SizedBox(
                    width: context.screenWidth - 60,
                    child: ourButton(
                      color: brownColor,
                      onPress: () {},
                      textColor: whiteColor,
                      title: "Procced to Shipping",
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
