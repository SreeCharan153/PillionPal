import 'package:flutter/material.dart';
import 'package:pillionpal/Screens/RideTracking.dart';
import 'bike_details_page.dart';
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
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BikeCard(
              bikeName: "TVS Apache RTR 160",
              imageUrl: "assets/images/Biles/bike_1.png",
              transmission: "Manual",
              seats: "1",
              fair: "₹100",
              distance: "800m",
              timeAway: "5 mins",
              onViewDetails: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => BikeDetailsPage(
                          bikeName: "TVS Apache RTR 160",
                          imageUrl: "assets/images/Biles/bike_1.png",
                          maxPower: "2500hp",
                          fair: "₹100",
                          maxSpeed: "230kph",
                          acceleration: "2.5 sec",
                          riderName: "Sergio Ramasis",
                          gender: "Male",
                          bikeNo: "AP 13 AH XXXX",
                          licenceNo: "DL14 20110012345",
                        ),
                  ),
                );
              },
              onRideNow: () {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const RideTrackingScreen()),
              );
              },
            ),
          ],
        ),
      ),
    );
  }
}
