import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foododering_application/consts/list.dart';
import 'package:foododering_application/Views/category_screen/item_details.dart';
import 'package:foododering_application/consts/consts.dart';
import 'package:foododering_application/services/firebase_services.dart';
import 'package:foododering_application/widgets_common/loading_indicator.dart';
import 'package:foododering_application/consts/strings.dart';
import 'package:get/get.dart';
import 'package:flutter/src/rendering/box.dart';
import 'package:flutter/src/rendering/sliver_multi_box_adaptor.dart';

class SearchScreen extends StatelessWidget {
  final String? title;
  const SearchScreen({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: title!.text.color(darkFontGrey).make(),
      ),
      body: FutureBuilder(
        future: FirestorServices.searchProducts(title),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: loadingIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return "No Product Found".text.makeCentered();
          } else {
            var data = snapshot.data!.docs;

            var filtered = data.where((element) => element['p_name']
                      .toString()
                      .toLowerCase()
                      .contains(title!.toLowerCase()),
                )
                .toList();
            //print(data[0]['p_name']);

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: filtered.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 8,
                                      crossAxisSpacing: 8,
                                      mainAxisExtent: 300),
                              itemBuilder: (context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network(
                                        filtered[index]['p_imgs'][0],
                                        width: 200,
                                        height: 200,
                                        fit: BoxFit.cover),
                                    const Spacer(),
                                    "${filtered[index]['p_name']}"
                                        .text
                                        .fontFamily(semibold)
                                        .color(darkFontGrey)
                                        .make(),
                                    10.heightBox,
                                    "${filtered[index]['p_price']}"
                                        .text
                                        .color(brownColor)
                                        .fontFamily(bold)
                                        .size(16)
                                        .make(),
                                    10.heightBox,
                                  ],
                                )
                                    .box
                                    .white
                                    .outerShadowMd
                                    .margin(const EdgeInsets.symmetric(
                                        horizontal: 4))
                                    .roundedSM
                                    .padding(const EdgeInsets.all(12))
                                    .make()
                                    .onTap(() {
                                  Get.to(() => ItemDetails(
                                        title:
                                            "${filtered[index]['p_name']}",
                                        data: [index],
                                      ));
                                });
                              }),
              // child: GridView(
              //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              //       crossAxisCount: 2,
              //       mainAxisSpacing: 8,
              //       crossAxisSpacing: 8,
              //       mainAxisExtent: 300),
              //   children: filtered.mapIndexed((currentValue, index) => Column(
              //             children: [
              //               Column(
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 children: [
              //                   Image.network(filtered[index]['p_imgs'][0],
              //                       width: 200, height: 200, fit: BoxFit.cover),
              //                   const Spacer(),
              //                   "${filtered[index]['p_name']}"
              //                       .text
              //                       .fontFamily(semibold)
              //                       .color(darkFontGrey)
              //                       .make(),
              //                   10.heightBox,
              //                   "${filtered[index]['p_price']}"
              //                       .text
              //                       .color(brownColor)
              //                       .fontFamily(bold)
              //                       .size(16)
              //                       .make(),
              //                   10.heightBox,
              //                 ],
              //               ).box
              //                   .white
              //                   .outerShadowMd
              //                   .margin(const EdgeInsets.symmetric(horizontal: 4))
              //                   .roundedSM
              //                   .padding(const EdgeInsets.all(12))
              //                   .make()
              //                   .onTap(() {
              //                 Get.to(() => ItemDetails(
              //                       title: "${filtered[index]['p_name']}",
              //                       data: filtered[index],
              //                     ));
              //               }),
              //             ],
              //           )).toList(),
              // ),
            );
          }
        },
      ),
    );
  }
}
