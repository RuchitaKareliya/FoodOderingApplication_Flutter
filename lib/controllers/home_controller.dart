import 'package:foododering_application/consts/consts.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var currentNavIndex = 0.obs;

  // chat application
  var username = '';

  getUsername() async {
    var n = await firestore
        .collection(UsersCollections)
        .where('id', isEqualTo: currentUser!.uid)
        .get()
        .then((value) {
      if (value.docs.isEmpty) {
        return value.docs.single['name'];
      }
    });
    username = n;
    print(username);
  }
}
