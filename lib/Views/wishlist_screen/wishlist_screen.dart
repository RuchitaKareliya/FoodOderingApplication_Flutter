import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:foododering_application/consts/consts.dart';
import 'package:foododering_application/services/firebase_services.dart';
import 'package:foododering_application/widgets_common/loading_indicator.dart';
import 'package:get/get.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "My Wishlist".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
          stream: FirestorServices.getwishlists(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: loadingIndicator(),
              );
            } else if (!snapshot.data!.docs.isNotEmpty) {
              return "No Wishlist yet!".text.color(darkFontGrey).make();
              
            }else{
              return Container();
            }
          }),
    );
  }
}
