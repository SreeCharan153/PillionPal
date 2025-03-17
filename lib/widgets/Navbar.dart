import 'package:flutter/material.dart';
import '../Screens/Home.dart';
import '../Screens/FavouriteScreen.dart';
//import 'wallet_screen.dart';
import '../Screens/Offer_Screen.dart';
//import 'profile_screen.dart';

class Navbar extends StatefulWidget {
  final int selectedIndex;
  final bool isBikeMode; // Preserve isBikeMode

  const Navbar({
    super.key,
    required this.selectedIndex,
    required this.isBikeMode,
  });

  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  void _onItemTapped(int index) {
  if (index == widget.selectedIndex) return; // Prevent unnecessary navigation

  Widget nextScreen;
  switch (index) {
    case 0:
      nextScreen = HomeScreen(isBikeMode: widget.isBikeMode);
      break;
    case 1:
      nextScreen = FavouriteScreen(isBikeMode: widget.isBikeMode, favoritePlaces: [],);
      break;
    case 2:
      // Wallet Screen (currently not implemented)
      return;
    case 3:
      nextScreen = OfferScreen(isBikeMode: widget.isBikeMode);
      break;
    case 4:
      // Profile Screen (currently not implemented)
      return;
    default:
      return;
  }

  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => nextScreen),
  );
}


  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.selectedIndex,
      onTap: _onItemTapped,
      selectedItemColor: const Color.fromRGBO(0, 137, 85, 1),
      unselectedItemColor: Colors.grey,
      items: [
        BottomNavigationBarItem(icon: const Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(
          icon: const Icon(Icons.favorite),
          label: "Favourite",
        ),
        BottomNavigationBarItem(
          icon: Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Color.fromRGBO(0, 137, 85, 1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.account_balance_wallet,
              color: Colors.white,
            ),
          ),
          label: "Wallet",
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.local_offer),
          label: "Offer",
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.person),
          label: "Profile",
        ),
      ],
    );
  }
}
