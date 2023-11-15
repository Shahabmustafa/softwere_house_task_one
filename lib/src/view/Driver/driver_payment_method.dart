


import 'package:flutter/material.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:uber_app/src/share/app_text_field.dart';
import 'package:uber_app/src/share/custom_button.dart';
import 'package:uber_app/src/style/app_color.dart';
import 'package:uber_app/src/style/social_media_button.dart';

class DriverPaymentMethode extends StatefulWidget {
  const DriverPaymentMethode({Key? key}) : super(key: key);

  @override
  State<DriverPaymentMethode> createState() => _DriverPaymentMethodeState();
}

class _DriverPaymentMethodeState extends State<DriverPaymentMethode> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Methode"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           SocialMediaButton(
             height: height * 0.07,
             width: width * 1,
             title: "paypal",
             imageUrl: "paypal.png",
             onTap: (){
               Navigator.of(context).push(
                 MaterialPageRoute(
                   builder: (BuildContext context) => UsePaypal(
                       sandboxMode: true,
                       clientId:
                       "AW1TdvpSGbIM5iP4HJNI5TyTmwpY9Gv9dYw8_8yW5lYIbCqf326vrkrp0ce9TAqjEGMHiV3OqJM_aRT0",
                       secretKey:
                       "EHHtTDjnmTZATYBPiGzZC_AZUfMpMAzj2VZUeqlFUrRJA_C0pQNCxDccB5qoRQSEdcOnnKQhycuOWdP9",
                       returnURL: "https://samplesite.com/return",
                       cancelURL: "https://samplesite.com/cancel",
                       transactions: const [
                         {
                           "amount": {
                             "total": '10.12',
                             "currency": "USD",
                             "details": {
                               "subtotal": '10.12',
                               "shipping": '0',
                               "shipping_discount": 0
                             }
                           },
                           "description":
                           "The payment transaction description.",
                           // "payment_options": {
                           //   "allowed_payment_method":
                           //       "INSTANT_FUNDING_SOURCE"
                           // },
                           "item_list": {
                             "items": [
                               {
                                 "name": "A demo product",
                                 "quantity": 1,
                                 "price": '10.12',
                                 "currency": "USD"
                               }
                             ],

                             // shipping address is not required though
                             "shipping_address": {
                               "recipient_name": "Jane Foster",
                               "line1": "Travis County",
                               "line2": "",
                               "city": "Austin",
                               "country_code": "US",
                               "postal_code": "73301",
                               "phone": "+00000000",
                               "state": "Texas"
                             },
                           }
                         }
                       ],
                       note: "Contact us for any questions on your order.",
                       onSuccess: (Map params) async {
                         print("onSuccess: $params");
                       },
                       onError: (error) {
                         print("onError: $error");
                       },
                       onCancel: (params) {
                         print('cancelled: $params');
                       }),
                 ),
               );
             },
           ),
           SizedBox(
             height: height * 0.02,
           ),
           SocialMediaButton(
             height: height * 0.07,
             width: width * 1,
             title: "Stripe",
             imageUrl: "stripe.png",
             onTap: (){

             },
           ),
          ],
        ),
      ),
    );
  }
}