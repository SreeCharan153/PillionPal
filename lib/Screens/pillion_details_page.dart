import 'package:flutter/material.dart';
// import 'package:get/route_manager.dart';
// import 'package:pillionpal/Screens/RideTracking.dart';
import 'package:pillionpal/widgets/PrimaryButton.dart' as primary_button;
import '../widgets/Ride_request_popup.dart';

class PillionDetailsPage extends StatelessWidget {
  final String name;
  final int age;
  final String gender;
  final String pickupPoint;
  final String dropPoint;
  final String priceShare;
  final String totalDistance;
  final String imageUrl;
  final String phonenumber;

  const PillionDetailsPage({
    super.key,
    required this.name,
    required this.age,
    required this.gender,
    required this.pickupPoint,
    required this.dropPoint,
    required this.priceShare,
    required this.totalDistance,
    required this.imageUrl,
    required this.phonenumber,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(name),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Image.asset(imageUrl, height: 300)),
              const SizedBox(height: 20),

              // Pillion Details Section
              Text(
                "Pillion Details",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 10),
              _infoRow("Name", name),
              _infoRow("Age", "$age"),
              _infoRow("Gender", gender),
              _infoRow("Pickup Point", pickupPoint),
              _infoRow("Drop Point", dropPoint),
              _infoRow("Total Distance", totalDistance),
              _infoRow("Price Share", priceShare),

              const SizedBox(height: 20),

              // "Accept Ride" Button using PrimaryButton
              Center(
                child: primary_button.PrimaryButton(
                  text: "Accept Ride",
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      builder:
                          (context) => RideRequestPopup(
                            name: "John Doe",
                            imageUrl:
                                "assets/images/profile.png", // Replace with actual path
                            distance: "800m",
                            timeAway: "5 mins",
                            phoneNumber: phonenumber,
                          ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget for displaying pillion details
  Widget _infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
