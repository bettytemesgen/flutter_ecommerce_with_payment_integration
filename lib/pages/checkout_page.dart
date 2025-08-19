import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

// Your existing PaymentService class remains the same
class PaymentService {
  final String backendUrl =
      'http://your-server-ip:3000/initiate-payment'; // ✅ Make sure this is your actual backend URL

  Future<void> initiatePayment({
    required String transactionId,
    required double amount,
    required String reason,
    required String successRedirectUrl,
    required String failureRedirectUrl,
    required String notifyUrl,
    String? phoneNumber,
    String? cancelRedirectUrl,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(backendUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'id': transactionId,
          'amount': amount,
          'paymentReason': reason,
          'successRedirectUrl': successRedirectUrl,
          'failureRedirectUrl': failureRedirectUrl,
          'notifyUrl': notifyUrl,
          'phoneNumber': phoneNumber,
          'cancelRedirectUrl': cancelRedirectUrl,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final String paymentUrl = data['paymentUrl'];

        final uri = Uri.parse(paymentUrl);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri);
        } else {
          throw 'Could not launch $paymentUrl';
        }
      } else {
        final error = jsonDecode(response.body)['error'];
        throw Exception('Backend error: $error');
      }
    } catch (e) {
      print('Payment initiation failed: $e');
      rethrow;
    }
  }
}

// Corrected PaymentScreen widget
class PaymentScreen extends StatelessWidget {
  // Assuming totalAmount is passed to this widget or retrieved from state management
  final double totalAmount;
  final String orderId; // You'll need a unique transaction ID for each payment

  const PaymentScreen({
    Key? key,
    required this.totalAmount,
    required this.orderId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Santimpay Payment')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // ✅ Create an instance of PaymentService
            final paymentService = PaymentService();

            // ✅ Call initiatePayment on the instance and provide all required parameters
            paymentService.initiatePayment(
              transactionId: orderId, // Use a unique order ID
              amount: totalAmount,
              reason: "Purchase from Cart",
              phoneNumber: "0910015422", // Optional, if you have it
              successRedirectUrl:
                  'https://your-ecommerce.com/payment-success', // ✅ Replace with your actual success URL
              failureRedirectUrl:
                  'https://your-ecommerce.com/payment-failure', // ✅ Replace with your actual failure URL
              notifyUrl:
                  'https://your-backend.com/santimpay-webhook', // ✅ Replace with your actual notification URL
              // cancelRedirectUrl: '', // Optional
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
          child: const Text(
            "Pay with SantimPay",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
