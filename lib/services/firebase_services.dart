import 'package:flutter/foundation.dart';
import 'package:foododering_application/consts/consts.dart';
import 'package:get/get.dart';

//get user data
class FirestorServices{
  static getUser(uid){
    return firestore.collection(UsersCollections).where('id',isEqualTo: uid).snapshots();
  }
// get product according  to  category
  static getProducts(category){
    return firestore.collection(productsCollections).where('p_category',isEqualTo: category).snapshots();
    

  }
// get cart
  static getCart(uid){
    return firestore.collection(cartCollections).where('added_by',isEqualTo: uid).snapshots();
  }


  // delete documen
  static deleteDocument(docId){
    return firestore.collection(cartCollections).doc(docId).delete();
  }


  static getAllOrders(){
    return firestore.collection(ordersCollections).where('order_by',isEqualTo: currentUser!.uid).snapshots();
  }

  static getwishlists(){
    return firestore.collection(productsCollections).where('p_wishlist',arrayContains: currentUser!.uid).snapshots();
  }

  
}