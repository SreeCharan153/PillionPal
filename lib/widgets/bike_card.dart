import 'package:flutter/material.dart';
import 'package:pillionpal/widgets/PrimaryButton.dart';
import 'package:pillionpal/widgets/SecondaryButton.dart';

class BikeCard extends StatelessWidget {
  final String bikeName;
  final String imageUrl;
  final String transmission;
  final String seats;
  final String fuelType;
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
    required this.fuelType,
    required this.distance,
    required this.timeAway,
    required this.onViewDetails,
    required this.onRideNow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green),
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
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              // Bike Image
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  imageUrl,
                  width: 120,
                  height: 60,
                  //fit: BoxFit.cover,
                ),
              ),
            ],
          ),

          const SizedBox(height: 4),

          // Bike Details
          Text(
            "$transmission  |  $seats seat  |  $fuelType",
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),

          const SizedBox(height: 4),

          // Distance & Time
          Row(
            children: [
              const Icon(Icons.location_on, size: 16, color: Colors.grey),
              Text(
                " $distance ($timeAway away)",
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),

          const SizedBox(height: 10),

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
