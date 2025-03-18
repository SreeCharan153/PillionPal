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
      initialChildSize: 0.4, // Initial height of the sheet (40% of screen)
      minChildSize: 0.3, // Minimum height when dragged down
      maxChildSize: 0.9, // Maximum height when dragged up
      expand: false, // Prevents it from taking full screen immediately
      builder: (context, scrollController) {
        return Material(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          child: SingleChildScrollView(
            controller: scrollController, // Enables scrolling within the sheet
            child: Padding(
              padding: MediaQuery.of(context).viewInsets, // Adjust for keyboard
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
                      "Select address",
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
                  const Text('Your Previous Location'),
                  TextButton(
                    onPressed: () {
                      // Handle previous locations
                    },
                    child: TextButton(
                      onPressed: () => {},
                      child: const Text("Chicago"),
                    ),
                  ),

                  Center(
                    child: IntrinsicWidth(
                      child: PrimaryButton(
                        text: 'Confirm',
                        onPressed: () => {NextScreen()},
                      ),
                    ),
                  ),

                  // Extra space for better scrolling
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

  const LocationField({Key? key, required this.icon, required this.hint})
    : super(key: key);

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
