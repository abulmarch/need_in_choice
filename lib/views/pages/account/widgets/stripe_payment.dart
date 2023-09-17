import 'dart:convert';

import 'package:http/http.dart' as http;

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import '../../../../services/model/ads_models.dart';
import '../../../../services/repositories/key_information.dart';
import '../../../../services/repositories/repository_urls.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';
import '../ad_card_cubit/ad_card_cubit.dart';

class StripePremium extends StatefulWidget {
  const StripePremium({
    super.key,
    required this.amount,
    required this.adCardCubit, 
    required this.adsModel,
  });
  final int amount;
  final AdCardCubit adCardCubit;
  final AdsModel adsModel;

  @override
  State<StripePremium> createState() => _StripePremiumState();
}

class _StripePremiumState extends State<StripePremium> {
  Map<String, dynamic>? paymentIntent;
  final stripeSecretKey = StripeKey.secretKey;
  late int adId;
  late int amount;

  @override
  void initState() {
    super.initState();
    adId = widget.adsModel.id;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      decoration: const BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          //elevation: 10,
          decoration: const BoxDecoration(
              color: kWhiteColor,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 100,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20))),
                child: Center(
                    child: Text('Premium Plan',
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge!
                            .copyWith(color: kWhiteColor))),
              ),
              kHeight10,
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text('Unlock amazing features with our Premium Plan!',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: kDarkGreyColor, fontSize: 15)),
              ),
              kHeight10,
              RichText(
                text: TextSpan(
                  text: "₹",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontSize: 16, color: kPrimaryColor),
                  children: [
                    TextSpan(
                      text: '${widget.amount}/-',
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(color: kPrimaryColor),
                    ),
                  ],
                ),
              ),
              kHeight15,
              const Text('1. Upload your ad to be displayed first'),
              const Text('2. Access to exclusive content'),
              kHeight15,
              ElevatedButton(
                onPressed: () async {
                  try {
                    int amount = widget.amount*100;
                    final map = await makePayment(amount);
                    final Map? res = map as Map?;
                    final kk = await http.get(Uri.parse('https://api.stripe.com/v1/payment_intents/${res?['id']}'),headers: {
                      'Authorization': 'Bearer $stripeSecretKey'
                    });
                    Map<String, dynamic> result = jsonDecode(kk.body);
                    if (result['status'] == 'succeeded') {
                      // await http.post(Uri.parse(ApiEndpoints.convertedToPremium(widget.adId)));
                      widget.adCardCubit.convertedToPremium(widget.adsModel);
                      Navigator.pop(context);
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   const SnackBar(
                      //     duration: Duration(seconds: 2),
                      //     content: Text('Payment Success'),
                      //   ),
                      // );
                    }else{
                      throw Exception();
                    }
                  } catch (e) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        duration: Duration(seconds: 2),
                        content: Text('payment faild'),
                      ),
                    );
                    log('==========');
                  }
                },
                child: const Text('Get Premium'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future makePayment(int amount) async {
    try {
      paymentIntent = await createPaymentIntent('$amount', 'INR');
      // log('createPaymentIntent: $paymentIntent');
      var gpay = const PaymentSheetGooglePay(
          merchantCountryCode: "IND", currencyCode: "INR", testEnv: true);

      final paymentSheet = await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret: paymentIntent!['client_secret'],
                  style: ThemeMode.light,
                  merchantDisplayName: 'santhosh',
                  googlePay: gpay));
        log('paymentSheet: ${paymentSheet?.toJson()}');
      await displayPaymentSheet();
      return paymentIntent;
    } catch (e) {
      log('makePayment: $e');
    }
  }

  Future displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        log("presentPaymentSheet: ${value?.toJson()}");
      });
    } catch (e) {
      log('displayPaymentSheet: $e');
    }
  }

   createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization':
              'Bearer $stripeSecretKey',//sk_test_51Nnc7KSDpJF2TWQ4vXtkSyF9LmjItnqDSm5Bvkv5QMXiDW0rdKA21xa6m9yraEMtIbprDY6a00ySkjqz25EPhveE00CR5i03mr
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      return json.decode(response.body);
    } catch (e) {
      log('createPaymentIntent: $e');
      throw Exception(e.toString());
    }
  }
}
