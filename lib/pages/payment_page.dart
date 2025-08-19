// Importing Flutter's material design package
import 'package:flutter/material.dart';

// Importing HTTP package to make API requests
import 'package:http/http.dart' as http;

// Importing Dart's built-in JSON encoder/decoder
import 'dart:convert';

// Importing package to open payment URL in browser
import 'package:url_launcher/url_launcher.dart';

// A stateful widget for handling payment logic
class PaymentPage extends StatefulWidget {
  final double amount; // Store the amount for payment

  // Constructor that requires amount parameter
  const PaymentPage({Key? key, required this.amount}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

// State class for PaymentPage
class _PaymentPageState extends State<PaymentPage> {
  bool _isLoading = true; // Boolean to track loading state

  @override
  void initState() {
    super.initState();
    startPayment(); // Start payment process immediately when the page loads
  }

  // Function to start the payment process
  Future<void> startPayment() async {
    // Creating a JSON payload with payment details
    final requestBody = json.encode({
      "id": DateTime.now().millisecondsSinceEpoch
          .toString(), // Unique ID for transaction
      "amount": widget.amount, // Amount from constructor
      "paymentReason": "Order #12345", // Reason for payment
      "successRedirectUrl":
          "https://santimpay.com", // Redirect if payment is successful
      "failureRedirectUrl":
          "https://santimpay.com", // Redirect if payment fails
      "notifyUrl":
          "https://webhook.site/1483ed3c-fa07-4db6-864b-2c5abc95ad25", // Notification URL for payment status
      "cancelRedirectUrl":
          "https://santimpay.com", // Redirect if payment is cancelled
      "phoneNumber": "+251910015422", // Phone number for payment
    });

    try {
      // Sending POST request to payment initiation API
      final response = await http.post(
        Uri.parse(
          "http://localhost:3000/initiate-payment",
        ), // Local server endpoint
        headers: {"Content-Type": "application/json"}, // JSON header
        body: requestBody, // Request payload
      );

      // If request is successful
      if (response.statusCode == 200) {
        final data = json.decode(response.body); // Parse JSON response
        final paymentUrl = data['paymentUrl']; // Extract payment URL
        print("Payment URL: $paymentUrl"); // Debug print

        // Check if the payment URL can be launched
        if (await canLaunch(paymentUrl)) {
          // Open the payment URL in browser
          await launch(paymentUrl, forceSafariVC: false, forceWebView: false);
        } else {
          throw 'Could not launch $paymentUrl'; // Error if URL can't open
        }
      } else {
        // If API request fails
        print("Error: ${response.body}");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Payment initiation failed")),
        );
      }
    } catch (e) {
      // Catch any errors during payment process
      print("Exception: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error occurred during payment")),
      );
    } finally {
      // Stop loading state after process finishes
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App bar title
      appBar: AppBar(title: const Text("Processing Payment...")),
      body: Center(
        // Show loading spinner if still processing, else show text
        child: _isLoading
            ? const CircularProgressIndicator()
            : const Text("Redirecting to payment..."),
      ),
    );
  }
}
