import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pillionpal/widgets/SecondaryButton.dart';
import 'package:pillionpal/widgets/PaymentCard.dart';
import 'package:pillionpal/widgets/PrimaryButton.dart';
import 'package:pillionpal/widgets/maps.dart';
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

class RideTrackingScreen extends StatelessWidget {
  const RideTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Use MapBox widget here
          const Positioned.fill(
            child: MapBox(),
          ),
          // Bottom Sheet
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Your Rider is coming in 3:35",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),

                  // Rider Info
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage("https://randomuser.me/api/portraits/men/1.jpg"),
                      ),
                      const SizedBox(width: 12),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Sergio Ramasis",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Row(
                              children: [
                                const Icon(Icons.location_on, size: 16),
                                const SizedBox(width: 4),
                                Text("800m (5 mins away)", style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(Icons.star, size: 16),
                                const SizedBox(width: 4),
                                Text("4.9 (531 reviews)", style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.motorcycle, size: 40),
                    ],
                  ),
                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Payment method", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      const Text("\$220.00", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 10),

                  PaymentMethodCard(
                    method: "UPI",
                    onTap: () {
                      Get.snackbar("Payment Selected", "UPI Payment chosen");
                    },
                  ),
                  const SizedBox(height: 10),
                  PaymentMethodCard(
                    method: "Cash",
                    onTap: () {
                      Get.snackbar("Payment Selected", "Cash Payment chosen");
                    },
                  ),
                  const SizedBox(height: 20),

                  Row(
                    children: [
                      Expanded(
                        child: SecondaryButton(
                          text: "Call",
                          onPressed: () {
                            const phoneNumber = "1234567890"; // Replace with actual phone number
                            CallHelper.makeCall(phoneNumber);
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: PrimaryButton(
                          text: "Message",
                          onPressed: () {
                            Get.snackbar("Messaging", "Opening chat...");
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  PrimaryButton(
                    text: "Continue to Pay",
                    onPressed: () {
                      Get.snackbar("Proceeding", "Redirecting to payment...");
                    },
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
