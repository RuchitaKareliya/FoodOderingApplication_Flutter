import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foododering_application/consts/consts.dart';
import 'package:foododering_application/controllers/home_controller.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  var totalP = 0.obs;

  //text controller for shipping details

  var addressController = TextEditingController();
  var cityController = TextEditingController();
  var stateController = TextEditingController();
  var postalcodeController = TextEditingController();
  var phoneController = TextEditingController();

  var paymentIndex = 0.obs;

  late dynamic productSnapshot;

  var products = [];

  var placingOrder = false.obs;

  calculate(data) {
    totalP.value = 0;
    for (var i = 0; i < data.length; i++) {
      totalP = totalP + int.parse(data[i]['tprice'].toString());
    }
  }

  changePaymentIndex(index) {
    paymentIndex.value = index;
  }

  placeMyOrder({required orderPaymentMethod, required totalAmount}) async {
    placingOrder(true);
    await getProductDetails();
    await firestore.collection(ordersCollections).doc().set({
      'order_by': currentUser!.uid,
      'order_by_name': Get.find<HomeController>()!.username,
      'order_by_email': currentUser!.email,
      'order_by_address': addressController.text,
      'order_by_state': stateController.text,
      'order_by_city': cityController.text,
      'order_by_phone': phoneController.text,
      'order_by_postalcode': postalcodeController.text,
      'shipping_method': "Home Delivery",
      'payment_method': orderPaymentMethod,
      'order_date': DateTime.now(),
      'order_placed': true,
      //'order_code': currentUser!.toString(),
      'order_confirmed': false,
      'order_delivered': false,
      'order_on_delivered': false,
      'total_amount': totalAmount,
      'orders': FieldValue.arrayUnion(products)
    });
    placingOrder(false);
  }

  getProductDetails() {
    products.clear();
    for (var i = 0; i < productSnapshot.length; i++) {
      products.add({
        'img': productSnapshot[i]['img'],
        'vender_id': productSnapshot[i]['vender_id'],
        'tprice': productSnapshot[i]['tprice'],
        'qty': productSnapshot[i]['qty'],
        'title': productSnapshot[i]['title'],
      });
    }
    // print(products);
  }

  clearCart() {
    for (var i = 0; i < productSnapshot.length; i++) {
      firestore.collection(cartCollections).doc(productSnapshot[i].id).delete();
    }
  }
}
