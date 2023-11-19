import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class PaymentMethodeService{

  Map<String,dynamic>? paymentIntent;
  var secretKey = "sk_test_51OE8EMCakpkmS4wZ10r9p2j0ArBzBUd4UdZloBV3op85XVIIxdy0yCvaHwA3b1ZUHxW9dR47Gk8rzI3FTSbykAve00sIO1QJFE";

  Future<void> payment()async{
    try{
      Map<String,dynamic> body = {
        "amount" : 1000,
        "currency" : "INR",
      };
      var response = await http.post(
        Uri.parse("https://api.stripe.com/v1/payment_intents"),
        headers: {
          "Authorization" : "Bearer $secretKey",
          "Content-Type" : "application/x-www-form-urlencoded",
        },
        body: body,
      );
      paymentIntent = json.decode(response.body);
    }catch(e){
      if (kDebugMode) {
        print("error please check $e");
      }
    }
    await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent!["client_secret"],
          style: ThemeMode.light,
          merchantDisplayName: "Shahab Mustafa",
        ),
    ).then((value){});

    try{
      await Stripe.instance.presentPaymentSheet().then((value){
        print("Payment Sucessfully Done");
      });
    }catch(e){
      print(e);
    }
  }
}