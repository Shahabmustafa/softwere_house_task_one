import 'dart:convert';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:uber_app/src/style/app_color.dart';
import 'package:uber_app/src/style/social_media_button.dart';
import 'package:http/http.dart' as http;

class PassengerPaymentMethode extends StatefulWidget {
  const PassengerPaymentMethode({Key? key}) : super(key: key);

  @override
  State<PassengerPaymentMethode> createState() => _PassengerPaymentMethodeState();
}

class _PassengerPaymentMethodeState extends State<PassengerPaymentMethode> {
  static final auth = FirebaseAuth.instance.currentUser!.uid;

  Stream documentSnapshot = FirebaseFirestore.instance
      .collection("Passenger")
      .doc(auth).snapshots();

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
            Expanded(
              child: StreamBuilder(
                stream: documentSnapshot,
                builder: (context,snapshot){
                  if(snapshot.hasData){
                    Map<String, dynamic> data = snapshot.data.data() as Map<String, dynamic>;
                    return Container(
                      height: height * 0.1,
                      width: width * 1,
                      decoration: BoxDecoration(
                        color: AppColor.greyColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Text(
                              "Current Balance",
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: height * 0.04,
                            ),
                            Text(
                              "PKR ${data["payment"]}",
                              style: TextStyle(
                                fontSize: 30,
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }else{
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
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
                makePayment();
              },
            ),
          ],
        ),
      ),
    );
  }
  Map<String,dynamic>? paymentIntent;

  var secretKey = "sk_test_51OE8EMCakpkmS4wZ10r9p2j0ArBzBUd4UdZloBV3op85XVIIxdy0yCvaHwA3b1ZUHxW9dR47Gk8rzI3FTSbykAve00sIO1QJFE";

  createPaymentIntent(String amount, String currency) async {
    try {

      // TODO: Request body
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      // TODO: POST request to stripe
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer ' + secretKey, //SecretKey used here
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      log('Payment Intent Body->>> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      // ignore: avoid_print
      log('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final calculatedAmout = (int.parse(amount)) * 1000;
    return calculatedAmout.toString();
  }

  displayPaymentSheet(BuildContext context) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        showDialog(
          context: context,
          builder: (_) => const AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Icon(
                        Icons.check_circle,
                        color: Colors.green,
                      ),
                    ),
                    Text("Payment Successfull"),
                  ],
                ),
              ],
            ),
          ),
        );

        // TODO: update payment intent to null
        paymentIntent = null;
      }).onError((error, stackTrace) {
        String ss = "exception 2 :$error";
        String s2 = "reason :$stackTrace";
      });
    } on StripeException catch (e) {
      print('Error is:---> $e');
      String ss = "exception 3 :$e";
    } catch (e) {
      log('$e');
    }
  }

  Future<void> makePayment() async {
    try {

      // TODO: Create Payment intent
      paymentIntent = await createPaymentIntent('10', 'INR');

      // TODO: Initialte Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent!['client_secret'],
          applePay: null,
          googlePay: null,
          style: ThemeMode.light,
          merchantDisplayName: 'Shahab Mustafa',
        ),
      )
          .then((value) {
        log("Success");
      });

      // TODO: now finally display payment sheeet
      displayPaymentSheet(context); // Payment Sheet
    } catch (e, s) {
      String ss = "exception 1 :$e";
      String s2 = "reason :$s";
      log("exception 1:$e");
    }
  }
}