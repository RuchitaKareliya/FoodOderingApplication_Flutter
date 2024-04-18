import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foododering_application/consts/consts.dart';
import 'package:foododering_application/consts/images.dart';
import 'package:foododering_application/controllers/profile_controller.dart';
import 'package:foododering_application/widgets_common/bg_widget.dart';
import 'package:foododering_application/widgets_common/custom_textfield.dart';
import 'package:foododering_application/widgets_common/our_button.dart';
import 'package:foododering_application/consts/colors.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditProfileScreen extends StatelessWidget {
  final dynamic data;

  const EditProfileScreen({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();

    //controller.nameController.text = data['name'];

    return bgWidget(
      child: Scaffold(
          appBar: AppBar(),
          body: Obx(
            () => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //if data image url and conroller is empty
                data['imageUrl'] == '' && controller.profileImgPath.isEmpty
                    ? Image.asset(imgProfile2, width: 100, fit: BoxFit.cover)
                        .box
                        .roundedFull
                        .clip(Clip.antiAlias)
                        .make()
                    // if is data is not but conroller path is empty
                    : data['imageUrl'] != '' &&
                            controller.profileImgPath.isEmpty
                        ? Image.network(
                            data['imageUrl'],
                            width: 100,
                            fit: BoxFit.cover,
                          ).box.roundedFull.clip(Clip.antiAlias).make()
                        // if both are empty
                        : Image.file(
                            File(controller.profileImgPath.value),
                            width: 100,
                            fit: BoxFit.cover,
                          ).box.roundedFull.clip(Clip.antiAlias).make(),
                10.heightBox,
                ourButton(
                    color: Color.fromRGBO(183, 104, 58, 1),
                    onPress: () {
                      //Get.find<ProfileController>().changeImage(context);
                      controller.changeImage(context);
                    },
                    textColor: whiteColor,
                    title: "Change"),
                const Divider(),
                20.heightBox,
                customTextField(
                    controller: controller.nameController,
                    hint: nameHint,
                    title: name,
                    isPass: false),
                10.heightBox,
                customTextField(
                    controller: controller.oldpassController,
                    hint: passwordHint,
                    title: oldpass,
                    isPass: true),
                10.heightBox,
                customTextField(
                    controller: controller.newpassController,
                    hint: passwordHint,
                    title: newpass,
                    isPass: true),
                20.heightBox,
                controller.isloading.value
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(brownColor),
                      )
                    : SizedBox(
                        width: context.screenWidth - 60,
                        child: ourButton(
                            color: brownColor,
                            onPress: () async {
                              controller.isloading(true);

                              //if image is not selecte

                              if (controller.profileImgPath.value.isNotEmpty) {
                                await controller.uploadProfileImage();
                              } else {
                                controller.profileImageLink = data['imageUrl'];
                              }

                              //id old password mactch database
                              if (data['password'] == controller.oldpassController.text) {
                                await controller.changeAuthPassword(
                                  email: data['email'],
                                  password: controller.oldpassController.text,
                                  newpassword: controller.newpassController.text
                                );
                                await controller.updateProfile(
                                    imgUrl: controller.profileImageLink,
                                    name: controller.nameController.text,
                                    password: controller.newpassController.text);
                                VxToast.show(context, msg: "Updated");
                              }else{
                                VxToast.show(context, msg: "wrong Old password");
                                controller.isloading(false);
                              }
                            },
                            textColor: whiteColor,
                            title: "Save")),
              ],
            )
                .box
                .white
                .shadowSm
                .padding(const EdgeInsets.all(16))
                .margin(const EdgeInsets.only(top: 50, left: 12, right: 12))
                .rounded
                .make(),
          )),
    );
  }
}
