import 'package:flutter/material.dart';

import 'package:pillionpal/Screens/bike_list_page.dart';
// import 'package:pillionpal/Screens/login_screen.dart';
import 'package:get/get.dart';
import 'package:pillionpal/Screens/pillion_list_page.dart';
import 'package:pillionpal/widgets/PrimaryButton.dart'; // For navigation if needed

void showTransportPopup(BuildContext context, bool isBikeMode) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return TransportPopup(isBikeMode: isBikeMode);
    },
  );
}

class TransportPopup extends StatelessWidget {
  const TransportPopup({super.key, required this.isBikeMode});
  final bool isBikeMode;
  void NextScreen() {
    if (isBikeMode) {
      Get.to(PillionListPage());
    } else {
      Get.to(BikeListPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.4, // Initial height (40% of the screen)
      minChildSize: 0.3, // Minimum height
      maxChildSize: 0.9, // Maximum height
      expand: false, // Prevents it from covering full screen immediately
      builder: (context, scrollController) {
        return Material(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          child: SingleChildScrollView(
            controller: scrollController, // Enables scrolling within the sheet
            child: Padding(
              padding:
                  MediaQuery.of(context).viewInsets, // Adjusts for keyboard
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 50,
                      height: 5,
                      margin: const EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Center(
                    child: Text(
                      "Select Address",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const LocationField(
                    icon: Icons.my_location,
                    hint: "Pickup Location",
                  ),
                  const SizedBox(height: 10),
                  const LocationField(
                    icon: Icons.location_on,
                    hint: "Drop Location",
                  ),
                  const SizedBox(height: 20),

                  // Previous Location Section
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "Your Previous Location",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextButton(
                      onPressed: () {
                        // Handle selection of previous location
                      },
                      child: const Text("Chicago"),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Confirm Button
                  Center(
                    child: IntrinsicWidth(
                      child: PrimaryButton(
                        text: 'Confirm',
                        onPressed: () => {NextScreen()},
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class LocationField extends StatelessWidget {
  final IconData icon;
  final String hint;

  const LocationField({super.key, required this.icon, required this.hint});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.grey),
          hintText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}
