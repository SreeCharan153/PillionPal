import 'package:flutter/material.dart';

class BikeDetailsPage extends StatelessWidget {
  final String bikeName;
  final String imageUrl;
  final String maxPower;
  final String fair;
  final String maxSpeed;
  final String acceleration;
  final String riderName;
  final String gender;
  final String bikeNo;
  final String licenceNo;

  const BikeDetailsPage({
    super.key,
    required this.bikeName,
    required this.imageUrl,
    required this.maxPower,
    required this.fair,
    required this.maxSpeed,
    required this.acceleration,
    required this.riderName,
    required this.gender,
    required this.bikeNo,
    required this.licenceNo,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(bikeName, style: const TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(imageUrl, height: 400),
              ),
              const SizedBox(height: 20),
              Text("Specifications", style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _specificationBox("Max. power", maxPower),
                  _specificationBox("Fair", fair),
                  _specificationBox("Max. speed", maxSpeed),
                  _specificationBox("0-60 mph", acceleration),
                ],
              ),
              const SizedBox(height: 20),
              Text("Rider & Bike Details", style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 10),
              _infoRow("Name", riderName),
              _infoRow("Gender", gender),
              _infoRow("Bike No", bikeNo),
              _infoRow("Licence No", licenceNo),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(0, 137, 85, 1),
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                  child: const Text("Ride Now", style: TextStyle(color: Colors.white, fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _specificationBox(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

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
