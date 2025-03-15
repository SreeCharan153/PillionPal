import 'package:flutter/material.dart';
import '../widgets/PrimaryButton.dart'; // Import PrimaryButton

class CouponCard extends StatelessWidget {
  final String discountText;
  final String offerType;
  final VoidCallback onCollect;

  const CouponCard({
    Key? key,
    required this.discountText,
    required this.offerType,
    required this.onCollect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8), // Adds spacing between cards
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color.fromRGBO(0, 137, 85, 1), width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Discount Text Section
          Expanded(  // Ensures text does not shrink
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  discountText,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  offerType,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          // Collect Button with fixed size
          SizedBox(
            width: 100,  // Increased width to prevent text breaking
            height: 40,
            child: PrimaryButton(
              text: "Collect",
              onPressed: onCollect,
            ),
          ),
        ],
      ),
    );
  }
}
