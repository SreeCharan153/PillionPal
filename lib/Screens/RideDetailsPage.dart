import 'package:flutter/material.dart';

class RideDetailsPage extends StatelessWidget {
  final String bikeName;
  final String bikeNumber;
  final String licenseNumber;
  final String gender;

  const RideDetailsPage({super.key, required this.bikeName, required this.bikeNumber, required this.licenseNumber, required this.gender});



  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ride Details")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              _infoRow("Bike Name", bikeName),
              _infoRow("Bike Number", bikeNumber),
              _infoRow("License Number", licenseNumber),
              _infoRow("Gender", gender),
           ],
        ),
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ride Details"),
      ),
      body: const Center(
        child: Text("Ride Details Page"),
      ),
    );
  }