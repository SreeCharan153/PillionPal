import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pillionpal/Screens/bike_list_page.dart';
import 'package:pillionpal/Screens/pillion_list_page.dart';
import 'package:pillionpal/widgets/PrimaryButton.dart'; // For navigation if needed
import '../api_service.dart';

void showTransportPopup(BuildContext context, bool isBikeMode, String endlocation) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return TransportPopup(isBikeMode: isBikeMode, endlocation: endlocation);
    },
  );
}

// ------------------- TransportPopup -------------------
class TransportPopup extends StatefulWidget {
  const TransportPopup({super.key, required this.isBikeMode, required this.endlocation});
  final bool isBikeMode;
  final String endlocation;

  @override
  State<TransportPopup> createState() => _TransportPopupState();
}

class _TransportPopupState extends State<TransportPopup> {
  ApiService? apiService;
  bool loading = true;

  // Controllers to capture user input
  final TextEditingController pickupController = TextEditingController();
  final TextEditingController dropController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initApiService();
  }

  void _initApiService() async {
    apiService = await ApiService.getInstance();
    setState(() {
      loading = false;
    });
  }

void nextScreen() async {
  if (loading || apiService == null) return;

  final startLocation = pickupController.text.trim();
  final endLocation = dropController.text.trim();

  if (startLocation.isEmpty || endLocation.isEmpty) {
    Get.snackbar("Error", "Please enter both pickup and drop locations");
    return;
  }

  List<Map<String, dynamic>> rideDetails = [];

  try {
    final result = await apiService!.getRideDetails(startLocation, endLocation);

    // Expect result to be a Map with key "ride_requests"
    if (result is Map<String, dynamic> && result.containsKey("ride_requests")) {
      final requests = result["ride_requests"];
      if (requests is List) {
        rideDetails = List<Map<String, dynamic>>.from(requests);
        print(rideDetails);
      }
    } else {
      Get.snackbar("Error", "Unexpected API response format");
      return;
    }
  } catch (e) {
    Get.snackbar("Error", "Failed to fetch ride details");
    return;
  }

  if (rideDetails.isEmpty) {
    Get.snackbar("Info", "No rides available for the selected route");
    return;
  }

  // Navigate to the appropriate page
  if (widget.isBikeMode) {
    Get.to(PillionListPage(rideData: rideDetails.first));
  } else {
    Get.to(BikeListPage(rideList: rideDetails));
  }
}




  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.4,
      minChildSize: 0.3,
      maxChildSize: 0.9,
      expand: false,
      builder: (context, scrollController) {
        return Material(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
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
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 20),
                  LocationField(
                    controller: pickupController,
                    icon: Icons.my_location,
                    hint: "Pickup Location",
                  ),
                  const SizedBox(height: 10),
                  LocationField(
                    controller: dropController,
                    icon: Icons.location_on,
                    hint: "Drop Location",
                  ),
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "Your Previous Location",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextButton(
                      onPressed: () {
                        pickupController.text = "Chicago";
                        dropController.text = widget.endlocation;
                      },
                      child: const Text("Chicago"),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: IntrinsicWidth(
                      child: PrimaryButton(
                        text: 'Confirm',
                        onPressed: nextScreen,
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

// ------------------- LocationField -------------------
class LocationField extends StatelessWidget {
  final IconData icon;
  final String hint;
  final TextEditingController controller;

  const LocationField({
    super.key,
    required this.icon,
    required this.hint,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.grey),
          hintText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}
