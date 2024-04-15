import 'package:flutter/foundation.dart';
import 'package:foododering_application/consts/consts.dart';

//get user data
class FirestorServices{
  static getUser(uid){
    return firestore.collection(UsersCollections).where('id',isEqualTo: uid).snapshots();
  }

  static getProducts(category){
    return firestore.collection(productsCollections).where('p_category',isEqualTo: category).snapshots();
    

  }

  static getCart(uid){
    return firestore.collection(cartCollections).where('uid',isEqualTo: uid).snapshots();
  }
}