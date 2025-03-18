import 'package:flutter/material.dart';

class PaymentSuccessPopup extends StatelessWidget {
  final double amount;
  final String recipient;

  const PaymentSuccessPopup({super.key, required this.amount, required this.recipient});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.black54),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            const SizedBox(height: 10),
            // Success Icon
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check, color: Colors.green, size: 50),
            ),
            const SizedBox(height: 20),
            // Title
            const Text(
              "Payment Success",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 10),
            // Amount
            const Text("Amount", style: TextStyle(fontSize: 14, color: Colors.grey)),
            Text(
              "\$${amount.toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // Divider
            const Divider(thickness: 1, color: Colors.grey),
            const SizedBox(height: 10),
            // Transaction message
            Text(
              "Your money has been successfully sent to $recipient",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
