import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pillionpal/Screens/ProfileScreen.dart';
import 'package:pillionpal/Screens/login_screen.dart';
import 'package:pillionpal/Screens/RideDetailsPage.dart';
import 'package:pillionpal/Screens/onbording1.dart';
import 'package:pillionpal/Screens/RoleSelectionPage.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Check if the user is logged in
  bool isLoggedIn = await checkLoginStatus();

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        dividerColor: Colors.transparent,
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Colors.black,
        ),
      ),
      themeMode: ThemeMode.system,
      initialRoute: isLoggedIn ? '/roleSelection' : '/onboarding',
      getPages: [
  GetPage(name: '/onboarding', page: () => const OnboardingScreen()),
  GetPage(name: '/login', page: () => const LoginPage()),
  GetPage(name: '/roleSelection', page: () => const RoleSelectionPage()),
  GetPage(
    name: '/rideDetails',
    page: () => RideDetailsPage(
      bikeName: '',
      bikeNumber: '',
      licenseNumber: '',
      gender: '',
    ),
  ),
  GetPage(
    name: '/profile',
    page: () => ProfileScreen(isBikeMode: true),
  ),
],
    );
  }
}

// Function to check if the user is logged in
Future<bool> checkLoginStatus() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isLoggedIn') ?? false; // Default to false
}
