// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputFields {
  // 🔥 Common Input Field with Outline
  static Widget buildTextField({
    required String hint,
    TextEditingController? controller,
    bool isPassword = false,
    Widget? suffixIcon,
    Widget? prefixIcon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: hint,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 12,
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.grey), // 🔥 Added Outline
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.grey), // Default border
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(
            color: Color.fromRGBO(0, 137, 85, 1), // 🔥 Matching Theme
            width: 2,
          ),
        ),
      ),
    );
  }

  // 🔥 Dropdown Field with Outline
  static Widget buildDropdownField({
    required String hint,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: hint,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.grey), // 🔥 Added Outline
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.grey), // Default border
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(
            color: Color.fromRGBO(0, 137, 85, 1), // 🔥 Matching Theme
            width: 2,
          ),
        ),
      ),
      hint: Text(hint, style: const TextStyle(color: Colors.grey)),
      items:
          items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item, style: const TextStyle(fontSize: 16)),
            );
          }).toList(),
      onChanged: onChanged,
    );
  }

  // 🔥 Phone Number Field with Outline
  static Widget buildPhoneNumberField({
    required TextEditingController controller,
  }) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.phone,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        labelText: "Your mobile number",
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 12,
        ),
        prefixIcon: const Padding(
          padding: EdgeInsets.all(12.0),
          child: Text(
            "+91",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.grey), // 🔥 Added Outline
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.grey), // Default border
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(
            color: Color.fromRGBO(0, 137, 85, 1), // 🔥 Matching Theme
            width: 2,
          ),
        ),
      ),
    );
  }
}
