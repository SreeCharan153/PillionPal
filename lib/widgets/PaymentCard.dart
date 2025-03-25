import 'package:flutter/material.dart';

class PaymentMethodCard extends StatelessWidget {
  final String method; // "UPI" or "Cash"
  final VoidCallback onTap; // Action on tap

  const PaymentMethodCard({
    super.key,
    required this.method,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    bool isUPI = method == "UPI";
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(234, 247, 236, 1), // Light greenish tint
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color.fromRGBO(0, 137, 85, 1), width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  isUPI ? Icons.qr_code : Icons.money,
                  color: Colors.black,
                  size: 28,
                ),
                const SizedBox(width: 10),
                Text(
                  isUPI ? "UPI Payment" : "Cash Payment",
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
