import 'package:flutter/material.dart';
import 'pillion_details_page.dart';
import '../widgets/pillion_card.dart';
import '../widgets/Ride_request_popup.dart';

class PillionListPage extends StatelessWidget {
  final Map<String, dynamic> rideData;

  const PillionListPage({
    super.key,
    required this.rideData,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Available Pillion to Pair",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Center(
        child: PillionCard(
          name: rideData['name'] ?? 'Unknown',
          profileImageUrl: rideData['imageUrl'] ?? 'assets/images/profile.png',
          pickupPoint: rideData['pickupPoint'] ?? 'N/A',
          dropPoint: rideData['dropPoint'] ?? 'N/A',
          priceShare: rideData['priceShare']?.toString() ?? '0',
          phonenumber: rideData['phoneNumber'] ?? 'N/A',
          onViewDetails: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PillionDetailsPage(
                  name: rideData['name'] ?? 'Unknown',
                  age: rideData['age'] ?? 0,
                  pickupPoint: rideData['pickupPoint'] ?? 'N/A',
                  dropPoint: rideData['dropPoint'] ?? 'N/A',
                  priceShare: rideData['priceShare']?.toString() ?? '0',
                  totalDistance: rideData['totalDistance'] ?? 'N/A',
                  imageUrl: rideData['imageUrl'] ?? 'assets/images/profile.png',
                  gender: rideData['gender'] ?? 'Unknown',
                  phonenumber: rideData['phoneNumber'] ?? 'N/A',
                ),
              ),
            );
          },
          onRequestRide: () {
            showModalBottomSheet(
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              builder: (context) => RideRequestPopup(
                name: rideData['name'] ?? 'Unknown',
                imageUrl: rideData['imageUrl'] ?? 'assets/images/profile.png',
                distance: rideData['distance'] ?? 'N/A',
                timeAway: rideData['timeAway'] ?? 'N/A',
                phoneNumber: rideData['phoneNumber'] ?? 'N/A',
              ),
            );
          },
        ),
      ),
    );
  }
}
