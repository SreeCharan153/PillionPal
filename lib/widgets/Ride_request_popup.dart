import 'package:flutter/material.dart';

class RideRequestPopup extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String distance;
  final String timeAway;

  const RideRequestPopup({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.distance,
    required this.timeAway,
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
              CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(imageUrl),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
              _actionButton(Icons.call, "Call", Colors.green, Colors.white),
              _actionButton(Icons.message, "Message", Colors.white, Colors.green),
            ],
          ),
        ],
      ),
    );
  }

  Widget _actionButton(IconData icon, String text, Color bgColor, Color textColor) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.green),
        ),
        child: TextButton.icon(
          onPressed: () {},
          icon: Icon(icon, color: textColor),
          label: Text(text, style: TextStyle(color: textColor)),
        ),
      ),
    );
  }
}
