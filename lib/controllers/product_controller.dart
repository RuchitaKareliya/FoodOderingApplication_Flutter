import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:foododering_application/Models/category_model.dart';
import 'package:foododering_application/consts/consts.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  var quantity = 0.obs;
  var totalPrice = 0.obs; 
  var subcat = [];

  var isFav = false.obs;

  getSubCategoies(title) async {
    subcat.clear();
    var data = await rootBundle.loadString("lib/services/category_model.json");
    var decoded = categoryModelFromJson(data);
    var s =
        decoded.categories.where((element) => element.name == title).toList();

    for (var e in s[0].subcategory) {
      subcat.add(e);
    }
  }

    increaseQuantity(totalQuantity) {
      if (quantity.value < totalQuantity) {
        quantity.value++;
      }
    }

    decreaseQuantity() {
      if (quantity.value > 0) {
        quantity.value--;
      }
    }

  calculateTotalPrice(price){
   totalPrice.value= price*quantity.value;


  }
  addToCart({
    title, img,sellername, qty, tprice, context
    }) async {
    await firestore.collection(cartCollections).doc().set({
      'title':title,
      'sellername':sellername,
      'img':img,
      //'color':color,
      'qty':qty,
      'tprice':tprice,
      'added_by':currentUser!.uid
    }).catchError((error){
      VxToast.show(context, msg: error.toString());
    }).then((value) {

    });
  }

  resetValues(){
    totalPrice.value=0;
    quantity.value = 0;
  }

  addToWishlist(docId,context) async{
    await firestore.collection(productsCollections).doc(docId).set({
      'p_wishlist':FieldValue.arrayUnion([currentUser!.uid])
    },SetOptions(merge: true));

        isFav(false);
        VxToast.show(context, msg: "Added to Wishlist");
  }

  removeFromWishlist(docId,context) async{
    await firestore.collection(productsCollections).doc(docId).set({
      'p_wishlist':FieldValue.arrayRemove([currentUser!.uid])
    },SetOptions(merge: true));

    isFav(false);
    VxToast.show(context, msg: "Removed from wishlist");
  }

  checkIffav(data)async{
    if(data['p_wishlist'].contains(currentUser!.uid)){
      isFav.value = true;

    }else{
      isFav.value = false;
    }

  }
}
