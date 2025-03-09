import 'package:flutter/material.dart';
import 'package:hexagon/hexagon.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  // ignore: use_super_parameters
  CustomBottomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  final List<IconData> _icons = [
    Icons.home,
    Icons.favorite,
    Icons.wallet,
    Icons.local_offer,
    Icons.person,
  ];

  final List<String> _labels = [
    "Home",
    "Favourite",
    "Wallet",
    "Offer",
    "Profile",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Hexagonal Floating Button
          Positioned(
            top: -30,
            left: MediaQuery.of(context).size.width / 2 - 35,
            child: HexagonWidget.flat(
              width: 70,
              color: Colors.green,
              child: Icon(Icons.wallet, color: Colors.white, size: 30),
            ),
          ),
          // Navigation Items
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(5, (index) {
              if (index == 2) {
                return const SizedBox(width: 70); // Space for hexagon button
              }

              return GestureDetector(
                onTap: () => onItemTapped(index),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _icons[index],
                      color:
                          selectedIndex == index ? Colors.green : Colors.grey,
                      size: 24,
                    ),
                    Text(
                      _labels[index],
                      style: TextStyle(
                        fontSize: 12,
                        color:
                            selectedIndex == index ? Colors.green : Colors.grey,
                        fontWeight:
                            selectedIndex == index
                                ? FontWeight.bold
                                : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
