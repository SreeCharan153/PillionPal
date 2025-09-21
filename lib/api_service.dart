import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String baseUrl = "http://10.0.2.2:8000"; // Android emulator localhost

  /// Login user and store JWT token
Future<bool> login(String username, String password) async {
  final url = Uri.parse('$baseUrl/auth/login');
  final response = await http.post(
    url,
    headers: {
      "Content-Type": "application/x-www-form-urlencoded",
    },
    body: {
      "username": username,
      "password": password,
    },
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);

    // Correct key from your backend response
    String? token = data['access_token'];
    if (token == null || token.isEmpty) {
      print("Login response missing access_token: ${response.body}");
      return false;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    await prefs.setBool('isLoggedIn', true);

    return true;
  } else {
    print("Login failed: ${response.body}");
    return false;
  }
}
//Signup users
Future<bool> signup(String name, String email, String phone, String password,String gender) async {
  final url = Uri.parse('$baseUrl/auth/signup');
  final response = await http.post(
    url,
    headers: {
      "Content-Type": "application/x-www-form-urlencoded",
    },
    body: {
      "name": name,
      "email": email,
      "phone": phone,
      "password": password,
      "gender": gender,
    },
  );

  if (response.statusCode == 200) {
    return true;
  } else {
    print("Signup failed: ${response.body}");
    return false;
  }
}

  /// Fetch ride details
  Future<Map<String, dynamic>> getRideDetails(int rideId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('jwtToken');

      if (token == null) {
        throw Exception("User not logged in");
      }

      final url = Uri.parse('$baseUrl/rides/$rideId');
      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        final error = jsonDecode(response.body)['detail'] ?? "Failed to fetch ride";
        throw Exception(error);
      }
    } catch (e) {
      print("Get ride details error: $e");
      return {"error": e.toString()};
    }
  }

  // Register rider with bike details
Future<Map<String, dynamic>> registerRider({
  required String bikeName,
  required String model,
  required String mileage,
}) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');

  final url = Uri.parse('$baseUrl/rider/register');
  final response = await http.post(
    url,
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    },
    body: jsonEncode({
      "bike_name": bikeName,
      "model": model,
      "mileage": mileage,
    }),
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception("Failed to register rider: ${response.body}");
  }
}

  /// Get saved JWT token
  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwtToken');
  }

  /// Logout user
  static Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwtToken');
    await prefs.setBool('isLoggedIn', false);
  }

}

// Register rider with bike details
Future<Map<String, dynamic>> registerRider({
  required String bikeName,
  required String model,
  required String mileage,
}) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');

  final url = Uri.parse('$base64Url/rider/register');
  final response = await http.post(
    url,
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    },
    body: jsonEncode({
      "bike_name": bikeName,
      "model": model,
      "mileage": mileage,
    }),
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception("Failed to register rider: ${response.body}");
  }
}