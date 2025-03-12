import 'package:flutter/material.dart';

class Navbar extends StatefulWidget {
  final int selectedIndex;
  Navbar({required this.selectedIndex});

  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  void _onItemTapped(int index) {
    // Add navigation logic
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.selectedIndex,
      onTap: _onItemTapped,
      selectedItemColor: Color.fromRGBO(0, 137, 85, 1),
      unselectedItemColor: Colors.grey,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favourite"),
        BottomNavigationBarItem(
          icon: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Color.fromRGBO(0, 137, 85, 1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.account_balance_wallet, color: Colors.white),
          ),
          label: "Wallet",
        ),
        BottomNavigationBarItem(icon: Icon(Icons.local_offer), label: "Offer"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
      ],
    );
  }
}
