import 'package:flutter/material.dart';
import 'package:pillionpal/widgets/PrimaryButton.dart';
import 'package:pillionpal/widgets/SecondaryButton.dart';

class BikeCard extends StatelessWidget {
  final String bikeName;
  final String imageUrl;
  final String transmission;
  final String seats;
  final String fair;
  final String distance;
  final String timeAway;
  final VoidCallback onViewDetails;
  final VoidCallback onRideNow;

  const BikeCard({
    super.key,
    required this.bikeName,
    required this.imageUrl,
    required this.transmission,
    required this.seats,
    required this.fair,
    required this.distance,
    required this.timeAway,
    required this.onViewDetails,
    required this.onRideNow,
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
        color: theme.colorScheme.surfaceVariant.withOpacity(
          0.2,
        ), // Theme-aware background
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.colorScheme.primary),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bike Name & Image in a Row
          Row(
            children: [
              // Bike Name
              Expanded(
                child: Text(
                  bikeName,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ),
              // Bike Image
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  imageUrl,
                  width: 100,
                  height: 60,
                  fit: BoxFit.cover, // Ensures proper scaling
                ),
              ),
            ],
          ),

          const SizedBox(height: 6),

          // Bike Details
          Text(
            "$transmission  |  $seats seat  |  $fair",
            style: TextStyle(fontSize: 14, color: secondaryTextColor),
          ),

          const SizedBox(height: 6),

          // Distance & Time
          Row(
            children: [
              Icon(
                Icons.location_on,
                size: 16,
                color: theme.colorScheme.primary,
              ),
              Text(
                " $distance ($timeAway away)",
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
                child: PrimaryButton(text: "Ride Now", onPressed: onRideNow),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
