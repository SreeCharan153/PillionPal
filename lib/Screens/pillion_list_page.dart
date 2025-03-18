import 'package:flutter/material.dart';
import 'pillion_details_page.dart';
import '../widgets/pillion_card.dart';
import '../widgets/Ride_request_popup.dart';

class PillionListPage extends StatelessWidget {
  const PillionListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Available Pillions to pair",
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            PillionCard(
              name: 'John Doe',
              profileImageUrl: 'assets/images/profile.png',
              pickupPoint: 'Maddilapalem',
              dropPoint: 'Dakamarri',
              priceShare: '50',
              onViewDetails: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => PillionDetailsPage(
                          name: 'John Doe',
                          age: 25,
                          pickupPoint: 'Maddilapalem',
                          dropPoint: 'Dakamarri',
                          priceShare: '50',
                          totalDistance: '40 KM',
                          imageUrl: "assets/images/profile.png",
                          gender: "Male",
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
                  builder:
                      (context) => const RideRequestPopup(
                        name: "John Doe",
                        imageUrl:
                            "assets/images/profile.png", // Replace with actual path
                        distance: "800m",
                        timeAway: "5 mins",
                      ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
