import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static ApiService? _instance;
  String? token;

  // Private constructor
  ApiService._internal();

  /// Async singleton initializer
  static Future<ApiService> getInstance() async {
    if (_instance == null) {
      _instance = ApiService._internal();
      await _instance!._init();
    }
    return _instance!;
  }

  /// Load token from SharedPreferences
  Future<void> _init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('jwtToken');
  }

  static const String baseUrl = "http://10.0.2.2:8000";

  /// LOGIN
  Future<bool> login(String username, String password) async {
    final url = Uri.parse('$baseUrl/auth/login');
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/x-www-form-urlencoded"},
      body: {"username": username, "password": password},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      token = data['access_token'];

      if (token == null || token!.isEmpty) return false;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwtToken', token!);
      await prefs.setBool('isLoggedIn', true);

      return true;
    }
    return false;
  }

  /// GET RIDE DETAILS
  Future<Map<String, dynamic>> getRideDetails(int rideId) async {
    if (token == null) await _init();
    if (token == null) return {"error": "User not logged in"};

    try {
      final url = Uri.parse('$baseUrl/rides/$rideId');
      final response = await http.get(
        url,
        headers: {"Authorization": "Bearer $token"},
      );

      if (response.statusCode == 200) return jsonDecode(response.body);

      final error = jsonDecode(response.body)['detail'] ?? "Failed to fetch ride";
      return {"error": error};
    } catch (e) {
      return {"error": e.toString()};
    }
  }

  /// REGISTER RIDER
  Future<Map<String, dynamic>> registerRider({
    required String bikeName,
    required String model,
    required String mileage,
  }) async {
    if (token == null) await _init();
    if (token == null) return {"error": "User not logged in"};

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

    if (response.statusCode == 200) return jsonDecode(response.body);
    return {"error": response.body};
  }

  /// CHANGE PASSWORD
  Future<Map<String, dynamic>> changePassword(
    String oldPassword,
    String newPassword,
    String confirmPassword,
  ) async {
    if (token == null) await _init();
    if (token == null) return {"state": false, "message": "User not logged in"};

    try {
      final url = Uri.parse('$baseUrl/auth/change_password');
      final response = await http
          .put(
            url,
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer $token",
            },
            body: jsonEncode({
              "old_password": oldPassword,
              "new_password": newPassword,
              "confirm_password": confirmPassword,
            }),
          )
          .timeout(const Duration(seconds: 30));

      final data = jsonDecode(response.body);
      return {
        "state": data["state"] ?? (response.statusCode == 200),
        "message": data["message"] ??
            data["error"] ??
            (response.statusCode == 200
                ? "Password changed successfully"
                : "Failed to change password"),
      };
    } on TimeoutException {
      return {"state": false, "message": "Request timed out. Please try again."};
    } catch (e) {
      return {"state": false, "message": "An error occurred: $e"};
    }
  }

  /// LOGOUT
  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwtToken');
    await prefs.setBool('isLoggedIn', false);
    token = null;
  }

/// DELETE ACCOUNT
  Future<String> deleteAccount() async {
    if (token == null) await _init();
    if (token == null) return "User not logged in";

    try {
      final url = Uri.parse('$baseUrl/auth/delete_account');
      final response = await http.delete(
        url,
        headers: {"Authorization": "Bearer $token"},
      );

      if (response.statusCode == 200) {
        token = null;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.remove('jwtToken');
        await prefs.setBool('isLoggedIn', false);
        return "Account deleted successfully";
      } else {
        final data = jsonDecode(response.body);
        return data['message'] ?? "Failed to delete account";
      }
    } catch (e) {
      return "Error: $e";
    }
  }
}