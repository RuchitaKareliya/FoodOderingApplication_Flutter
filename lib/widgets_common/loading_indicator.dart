import 'package:foododering_application/consts/consts.dart';

Widget loadingIndicator(){
  return const CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation(brownColor),
    );

}