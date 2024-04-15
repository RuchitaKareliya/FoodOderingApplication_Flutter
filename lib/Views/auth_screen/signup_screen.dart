import 'package:flutter/material.dart';
import 'package:foododering_application/Views/home_screen/home.dart';
import 'package:foododering_application/consts/consts.dart';
import 'package:foododering_application/controllers/auth_controller.dart';
import 'package:foododering_application/widgets_common/applogo_widget.dart';
import 'package:foododering_application/widgets_common/bg_widget.dart';
import 'package:foododering_application/widgets_common/custom_textfield.dart';
import 'package:foododering_application/widgets_common/our_button.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool? isCheck = false;
  var controller = Get.put(AuthController());
  var logger = Logger();

  //text controller
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordRetypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            (context.screenHeight * 0.1).heightBox,
            applogoWidget(),
            10.heightBox,
            "Join the $appname".text.fontFamily(bold).white.size(18).make(),
            15.heightBox,
            Obx(()=> Column(
                children: [
                  customTextField(
                      hint: nameHint,
                      title: name,
                      controller: nameController,
                      isPass: false),
                  customTextField(
                      hint: emailHint,
                      title: email,
                      controller: emailController,
                      isPass: false),
                  customTextField(
                      hint: passwordHint,
                      title: password,
                      controller: passwordController,
                      isPass: true),
                  customTextField(
                      hint: passwordHint,
                      title: retypePassword,
                      controller: passwordRetypeController,
                      isPass: true),
                  // Align(
                  //     alignment: Alignment.centerRight,
                  //     child: TextButton(
                  //         onPressed: () {}, child: forgetPass.text.make())),
                  //5.heightBox,
                  //ourButton().box.width(context.screenWidth -50).make(),
                  Row(
                    children: [
                      Checkbox(
                        checkColor: brownColor,
                        value: isCheck,
                        onChanged: (newValue) {
                          setState(() {
                            isCheck = newValue;
                          });
                        },
                      ),
                      10.widthBox,
                      Expanded(
                        child: RichText(
                            text: const TextSpan(
                          children: [
                            TextSpan(
                                text: "I agree to the",
                                style: TextStyle(
                                  fontFamily: regular,
                                  color: fontGrey,
                                )),
                            TextSpan(
                                text: termAndCond,
                                style: TextStyle(
                                  fontFamily: regular,
                                  color: brownColor,
                                )),
                            TextSpan(
                                text: "&",
                                style: TextStyle(
                                  fontFamily: regular,
                                  color: fontGrey,
                                )),
                            TextSpan(
                                text: privacyPolicy,
                                style: TextStyle(
                                  fontFamily: regular,
                                  color: brownColor,
                                ))
                          ],
                        )),
                      ),
                    ],
                  ),
                  5.heightBox,
                  controller.isloading.value?const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(brownColor),
                  ): ourButton(
                    color: isCheck == true ? lightGrey : brownColor,
                    title: signup,
                    textColor: whiteColor,
                    onPress: () async {
                      if (isCheck != false) {
                        controller.isloading(true);
                        //print("hello");
                        //logger.log(Level.info, "Checkbox is checked");
                        try {
                          await controller
                              .signupMethod(
                                  context: context,
                                  email: emailController.text,
                                  password: passwordController.text)
                              .then((value) {
                            return controller.storeUserData(
                                email: emailController.text,
                                password: passwordController.text,
                                name: nameController.text);
                          }).then((value) {
                            VxToast.show(context, msg: loggidin);
                            Get.offAll(() => const Home());
                          });
                        } catch (e) {
                          //print("hello23");
                          //logger.log(Level.info, e);
                          auth.signOut();
                          VxToast.show(context, msg: e.toString());
                          controller.isloading(false); 
                        }
                      }
                    },
                  ).box.width(context.screenWidth - 50).make(),
                  10.heightBox,
                  //wrapping into gesture detector of velocity X
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      alreadyHaveAccount.text.color(fontGrey).make(),
                      login.text.color(brownColor).make().onTap(() {
                        Get.back();
                      }),
                    ],
                  ),
                ],
              )
                  .box
                  .white
                  .rounded
                  .padding(const EdgeInsets.all(16))
                  .width(context.screenWidth - 70)
                  .shadowSm
                  .make(),
            ),
          ],
        ),
      ),
    ));
  }
}
