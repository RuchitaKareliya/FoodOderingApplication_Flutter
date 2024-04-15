import 'package:foododering_application/consts/consts.dart';

Widget customTextField({String? title,String? hint, TextEditingController? controller,isPass}){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children:[
        title!.text.color(brownColor).fontFamily(semibold).size(16).make(),
        5.heightBox,
        TextFormField(
          obscureText: isPass,
          controller: controller,
          decoration:InputDecoration(
            hintStyle: const TextStyle(
              fontFamily: semibold,
              color: textfieldGrey,
            ),
            hintText: hint,
            isDense: true,
            fillColor: lightGrey,
            filled: true,
            border:InputBorder.none,
            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: brownColor)),
          ),
        ),
        5.heightBox,
    ],
  );
}