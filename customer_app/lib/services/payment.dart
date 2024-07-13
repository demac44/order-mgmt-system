import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart';

class StripePayments {


  Future<dynamic> cancelPayment(String intent) async {
    var response = http.post(Uri.parse('https://api.stripe.com/v1/payment_intents/$intent/cancel'), headers: {  });

    }

}