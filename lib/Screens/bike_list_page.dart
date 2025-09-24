import 'package:flutter/material.dart';
import 'bike_details_page.dart';
import '../widgets/bike_card.dart';
import 'Home.dart';
import 'package:get/route_manager.dart';

class BikeListPage extends StatelessWidget {
  final List<Map<String, dynamic>> rideList;

  const BikeListPage({
    super.key,
    required this.rideList,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Available Bikes for Ride",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: rideList.length,
        itemBuilder: (context, index) {
          final rideData = rideList[index];

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
            child: BikeCard(
              bikeName: rideData['bikeName'] ?? "Unknown Bike",
              imageUrl: rideData['imageUrl'] ?? "assets/images/Biles/bike_1.png",
              transmission: rideData['transmission'] ?? "Manual",
              seats: rideData['seats']?.toString() ?? "1",
              fair: "₹${rideData['fare']?.toString() ?? "0"}",
              distance: "N/A",
              timeAway: "N/A",
              onViewDetails: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BikeDetailsPage(
                      bikeName: rideData['bikeName'] ?? "Unknown Bike",
                      imageUrl: rideData['imageUrl'] ?? "assets/images/Biles/bike_1.png",
                      maxPower: rideData['maxPower']?.toString() ?? "N/A",
                      fair: "₹${rideData['fare']?.toString() ?? "0"}",
                      maxSpeed: rideData['maxSpeed']?.toString() ?? "N/A",
                      acceleration: rideData['acceleration']?.toString() ?? "N/A",
                      riderName: rideData['rider_id'] ?? "Unknown",
                      gender: rideData['gender'] ?? "Unknown",
                      bikeNo: rideData['bikeNo'] ?? "N/A",
                      licenceNo: rideData['licenceNo'] ?? "N/A",
                    ),
                  ),
                );
              },
              onRideNow: () {
                Get.offAll(
                  HomeScreen(isBikeMode: false),
                  arguments: {"showPopup": true},
                );
              },
            ),
          );
        },
      ),
    );
  }
}
