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
        title:
            "My Wishlist".text.color(darkFontGrey).fontFamily(semibold).make(),
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
            } else {
              var data = snapshot.data!.docs;
              return Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: Image.network(
                        "${data[index]['p_imgs'][0]}",
                        width: 80,
                        fit: BoxFit.cover,
                      ),
                      title: "${data[index]['p_name']}"
                          .text
                          .fontFamily(semibold)
                          .make(),
                      subtitle: "${data[index]['p_price']}"
                          .numCurrency
                          .text
                          .fontFamily(semibold)
                          .color(brownColor)
                          .make(),
                      trailing: Icon(
                        Icons.favorite,
                        color: redColor,
                      ).onTap(() {
                        firestore.collection(productsCollections).doc(data[index].id).set({
                          'p_wishlist': FieldValue.arrayRemove([currentUser!.uid])
                        }, SetOptions(merge: true));

                        
                      }),
                    );
                  },
                ),
              );
            }
          }),
    );
  }
}
