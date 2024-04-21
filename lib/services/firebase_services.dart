import 'package:flutter/foundation.dart';
import 'package:foododering_application/consts/consts.dart';
import 'package:get/get.dart';

//get user data
class FirestorServices {
  static getUser(uid) {
    return firestore
        .collection(UsersCollections)
        .where('id', isEqualTo: uid)
        .snapshots();
  }

// get product according  to  category
  static getProducts(category) {
    return firestore
        .collection(productsCollections)
        .where('p_category', isEqualTo: category)
        .snapshots();
  }

  static getSubCatergoryProducts(title){
    return firestore
        .collection(productsCollections)
        .where('p_subcategory', isEqualTo: title)
        .snapshots();
  }

// get cart
  static getCart(uid) {
    return firestore
        .collection(cartCollections)
        .where('added_by', isEqualTo: uid)
        .snapshots();
  }

  // delete documen
  static deleteDocument(docId) {
    return firestore.collection(cartCollections).doc(docId).delete();
  }

  static getAllOrders() {
    return firestore
        .collection(ordersCollections)
        .where('order_by', isEqualTo: currentUser!.uid)
        .snapshots();
  }

  static getwishlists() {
    return firestore
        .collection(productsCollections)
        .where('p_wishlist', arrayContains: currentUser!.uid)
        .snapshots();
  }

  static getCounts() async {
    var res = await Future.wait([
      firestore
          .collection(cartCollections)
          .where('added_by', isEqualTo: currentUser!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      }),
      firestore
          .collection(productsCollections)
          .where('p_wishlist', arrayContains: currentUser!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      }),
      firestore
          .collection(ordersCollections)
          .where('order_by', isEqualTo: currentUser!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      }),
    ]);
    return res;
  }

  static allproducts() {
    return firestore.collection(productsCollections).snapshots();
  }

  //get feature products method
  static getFeatureProducts() {
    return firestore.collection(productsCollections).where('isFeatured',isEqualTo: true).get();
  }


  static searchProducts(title){
    return firestore.collection(productsCollections).get();
  }
}
