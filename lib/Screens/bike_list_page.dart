// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import '../widgets/bike_card.dart';

class BikeListPage extends StatelessWidget {
  const BikeListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Available Bikes for Ride",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        // Ensures scrolling
        child: Column(
          children: [
            BikeCard(
              bikeName: "TVS Apache RTR 160",
              imageUrl:
                  "assets/images/Biles/bike_1.png", // Replace with a valid image URL
              transmission: "Manual",
              seats: "1",
              fuelType: "Petrol",
              distance: "800m",
              timeAway: "5 mins",
              onViewDetails: () {
                print("View Details Clicked");
              },
              onRideNow: () {
                print("Ride Now Clicked");
              },
            ),
            BikeCard(
              bikeName: "Yamaha R15",
              imageUrl:
                  "assets/images/Biles/bike_2.png", // Replace with a valid image URL
              transmission: "Manual",
              seats: "1",
              fuelType: "Petrol",
              distance: "800m",
              timeAway: "5 mins",
              onViewDetails: () {
                print("View Details Clicked");
              },
              onRideNow: () {
                print("Ride Now Clicked");
              },
            ),
            BikeCard(
              bikeName: "Honda CB Hornet",
              imageUrl:
                  "assets/images/Biles/bike_3.png", // Replace with a valid image URL
              transmission: "Manual",
              seats: "1",
              fuelType: "Petrol",
              distance: "800m",
              timeAway: "5 mins",
              onViewDetails: () {
                print("View Details Clicked");
              },
              onRideNow: () {
                print("Ride Now Clicked");
              },
            ),
          ],
        ),
      ),
    );
  }
}
