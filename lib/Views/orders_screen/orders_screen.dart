import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:foododering_application/Views/orders_screen/orders_details.dart';
import 'package:foododering_application/consts/consts.dart';
import 'package:foododering_application/services/firebase_services.dart';
import 'package:foododering_application/widgets_common/loading_indicator.dart';
import 'package:get/get.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "My Order".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
          stream: FirestorServices.getAllOrders(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: loadingIndicator(),
              );
            } else if (!snapshot.data!.docs.isNotEmpty) {
              return "No orders yet!".text.color(darkFontGrey).make();
              
            }else{
              var data = snapshot.data!.docs;
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context , int index){
                  return ListTile(
                    leading: "${index+1}".text.fontFamily(bold).color(darkFontGrey).make(),
                    title: data[index]['order_by'].toString().text.color(brownColor).fontFamily(semibold).make(),
                    subtitle: data[index]['total_amount'].toString().numCurrency.text.fontFamily(bold).make(),

                    trailing: IconButton(onPressed: () {
                      Get.to(() => OrdersDetails(data: data[index],),);
                    }, icon: Icon(Icons.arrow_forward_ios_rounded, color: darkFontGrey),),
                  );
                },
              );
            }
          }),
    );
  }
}
