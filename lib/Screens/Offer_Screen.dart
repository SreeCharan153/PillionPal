import 'package:flutter/material.dart';
import '../widgets/CouponCard.dart';
import '../widgets/navbar.dart';
import '../widgets/MenuDrawer.dart'; // ✅ Import MenuDrawer

class OfferScreen extends StatefulWidget {
  final bool isBikeMode;

  const OfferScreen({Key? key, required this.isBikeMode}) : super(key: key);

  @override
  _OfferScreenState createState() => _OfferScreenState();
}

class _OfferScreenState extends State<OfferScreen> with SingleTickerProviderStateMixin {
  late AnimationController _menuController;

  @override
  void initState() {
    super.initState();
    _menuController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _menuController.dispose();
    super.dispose();
  }

  void _toggleMenu() {
    if (_menuController.isCompleted) {
      _menuController.reverse();
    } else {
      _menuController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> offers = [
      {"discount": "15% off", "event": "Black Friday"},
      {"discount": "5% off", "event": "Christmas"}, // Fixed spelling
      {"discount": "15% off", "event": "Happy New Year"},
      {"discount": "15% off", "event": "Black Friday"},
      {"discount": "5% off", "event": "Christmas"}, // Fixed spelling
      {"discount": "15% off", "event": "Happy New Year"},
    ];

    return Scaffold(
      body: Stack(
        children: [
          // ✅ Main Content (Offer List)
          Scaffold(
            appBar: AppBar(
              title: const Text("Offers"),
              centerTitle: true,
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.menu), // ✅ Menu Button
                onPressed: _toggleMenu,
              ),
            ),
            body: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: offers.length,
              itemBuilder: (context, index) {
                return CouponCard(
                  discountText: offers[index]["discount"]!,
                  offerType: offers[index]["event"]!,
                  onCollect: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("${offers[index]["discount"]} collected!")),
                    );
                  },
                );
              },
            ),
            bottomNavigationBar: Navbar(
              selectedIndex: 3, // Active tab index (Offer)
              isBikeMode: widget.isBikeMode,
            ),
          ),

          // ✅ Sliding MenuDrawer
          MenuDrawer(animationController: _menuController, isBikeMode: widget.isBikeMode),
        ],
      ),
    );
  }
}
