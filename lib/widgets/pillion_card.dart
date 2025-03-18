import 'package:flutter/material.dart';
import 'package:pillionpal/widgets/PrimaryButton.dart';
import 'package:pillionpal/widgets/SecondaryButton.dart';

class PillionCard extends StatelessWidget {
  final String name;
  final String profileImageUrl;
  final String pickupPoint;
  final String dropPoint;
  final String priceShare;
  final VoidCallback onViewDetails;
  final VoidCallback onRequestRide;

  const PillionCard({
    super.key,
    required this.name,
    required this.profileImageUrl,
    required this.pickupPoint,
    required this.dropPoint,
    required this.priceShare,
    required this.onViewDetails,
    required this.onRequestRide,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor =
        theme.brightness == Brightness.dark ? Colors.white : Colors.black87;
    final secondaryTextColor =
        theme.brightness == Brightness.dark
            ? Colors.grey[400]
            : Colors.grey[700];

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.colorScheme.primary),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Name & Profile Image in a Row
          Row(
            children: [
              // Name
              Expanded(
                child: Text(
                  name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ),
              // Profile Image
              ClipRRect(
                borderRadius: BorderRadius.circular(30), // Circular Image
                child: Image.asset(
                  profileImageUrl,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Pickup Point
          Row(
            children: [
              Icon(Icons.location_on, size: 18, color: theme.colorScheme.primary),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  "Pickup: $pickupPoint",
                  style: TextStyle(fontSize: 14, color: secondaryTextColor),
                ),
              ),
            ],
          ),

          const SizedBox(height: 6),

          // Drop Point
          Row(
            children: [
              Icon(Icons.location_pin, size: 18, color: theme.colorScheme.primary),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  "Drop: $dropPoint",
                  style: TextStyle(fontSize: 14, color: secondaryTextColor),
                ),
              ),
            ],
          ),

          const SizedBox(height: 6),

          // Price Share
          Row(
            children: [
              Icon(Icons.attach_money, size: 18, color: theme.colorScheme.primary),
              const SizedBox(width: 6),
              Text(
                "Price Share: $priceShare",
                style: TextStyle(fontSize: 14, color: secondaryTextColor),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Buttons Row
          Row(
            children: [
              Expanded(
                child: SecondaryButton(
                  text: "View Details",
                  onPressed: onViewDetails,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: PrimaryButton(text: "Request Ride", onPressed: onRequestRide),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
