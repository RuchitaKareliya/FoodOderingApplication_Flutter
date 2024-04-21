import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foododering_application/Views/orders_screen/components/order_place_details.dart';
import 'package:foododering_application/Views/orders_screen/components/order_status.dart';
import 'package:foododering_application/consts/consts.dart';
import 'package:foododering_application/consts/consts.dart';
import 'package:foododering_application/consts/consts.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart' as intl;

class OrdersDetails extends StatelessWidget {
  final dynamic data;
  const OrdersDetails({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Orders Details"
            .text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Column(
                children: [
                  orderStatus(
                      color: redColor,
                      icon: Icons.done,
                      title: "Placed",
                      showDone: data['order_placed']),
                  orderStatus(
                      color: Colors.blue,
                      icon: Icons.thumb_up,
                      title: "Confired",
                      showDone: data['order_confirmed']),
                  orderStatus(
                      color: Colors.yellow,
                      icon: Icons.local_shipping,
                      title: "On Delivery",
                      showDone: data['order_on_delivered']),
                  orderStatus(
                      color: Colors.purple,
                      icon: Icons.done_all_rounded,
                      title: "Delivered",
                      showDone: data['order_delivered']),
                  const Divider(),
                  10.heightBox,
                  Column(
                    children: [
                      orderPlaceDetails(
                        d1: data['order_by'],
                        d2: data['shipping_method'],
                        title1: "Order By",
                        title2: "Shipping Method",
                      ),
                      orderPlaceDetails(
                        d1: intl.DateFormat()
                            .add_yMd()
                            .format((data['order_date'].toDate())),
                        d2: data['payment_method'],
                        title1: "Order Date",
                        title2: "Payment Method",
                      ),
                      orderPlaceDetails(
                        d1: "Unpaid",
                        d2: "Order Placed",
                        title1: "Payment Status",
                        title2: "Delivery Status",
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                "Shipping Address"
                                    .text
                                    .fontFamily(semibold)
                                    .make(),
                                "${data['order_by_name']}"
                                    .text
                                    .fontFamily(semibold)
                                    .make(),
                                "${data['order_by_email']}"
                                    .text
                                    .fontFamily(semibold)
                                    .make(),
                                "${data['order_by_address']}"
                                    .text
                                    .fontFamily(semibold)
                                    .make(),
                                "${data['order_by_city']}"
                                    .text
                                    .fontFamily(semibold)
                                    .make(),
                                "${data['order_by_state']}"
                                    .text
                                    .fontFamily(semibold)
                                    .make(),
                                "${data['order_by_phone']}"
                                    .text
                                    .fontFamily(semibold)
                                    .make(),
                                "${data['order_by_postalcode']}"
                                    .text
                                    .fontFamily(semibold)
                                    .make(),
                              ],
                            ),
                            SizedBox(
                              width: 110,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  "Total Amount"
                                      .text
                                      .fontFamily(semibold)
                                      .make(),
                                  "${data['total_amount']}"
                                      .text
                                      .fontFamily(semibold)
                                      .make(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ).box.outerShadowLg.white.make(),
                  Divider(),
                  10.heightBox,
                  "Ordered Product"
                      .text
                      .size(16)
                      .color(darkFontGrey)
                      .fontFamily(semibold)
                      .makeCentered(),
                  10.heightBox,
                  ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: List.generate(data['orders'].length, (index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        orderPlaceDetails(
                            title1: data['orders'][index]['title'],
                            title2: data['orders'][index]['tprice'],

                            d1: "${data['orders'][index]['qty']}",
                            // d2: "Refundable"),
                            // Container(
                            //   width: 30,
                            //   height: 10,
                            //   color: Colors(data['orders'][index]['color']),
                              
                            ),
                            const Divider(),
                      ]);
                    }).toList(),

                    
                  ).box.outerShadowMd.white.margin(const EdgeInsets.only(bottom: 4)).make(),
                  // 20.heightBox,
                  // Row(
                  //   children: [
                  //     "SUB TOTAL ". text.size(16).fontFamily(semibold).color(darkFontGrey).make(),
                      
                  //   ],
                  // )
                    
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
