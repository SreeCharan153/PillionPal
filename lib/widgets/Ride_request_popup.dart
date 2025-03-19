import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:pillionpal/widgets/PrimaryButton.dart';
import 'package:pillionpal/widgets/SecondaryButton.dart';
import 'package:url_launcher/url_launcher.dart';

class CallHelper {
  static Future<void> makeCall(String phoneNumber) async {
    final Uri callUri = Uri(scheme: 'tel', path: phoneNumber);

    if (await canLaunchUrl(callUri)) {
      await launchUrl(callUri);
    } else {
      Get.snackbar(
        "Error",
        "Could not launch call",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}

class RideRequestPopup extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String distance;
  final String timeAway;
  final String phoneNumber;

  const RideRequestPopup({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.distance,
    required this.timeAway,
    required this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Your companion is $distance",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              CircleAvatar(radius: 30, backgroundImage: AssetImage(imageUrl)),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "$distance ($timeAway away)",
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: PrimaryButton(
                  /*icon: Icons.call,*/ text: "Call",
                  onPressed: () {
                    CallHelper.makeCall(phoneNumber);
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: SecondaryButton(
                  /*icon: Icons.message,*/ text: "Message",
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
