import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputFields {
  static Widget buildTextField({
    required String hint,
    TextEditingController? controller,
    bool isPassword = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  static Widget buildDropdownField({
    required String hint,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
      ),
      hint: Text(hint),
      items:
          items.map((String item) {
            return DropdownMenuItem<String>(value: item, child: Text(item));
          }).toList(),
      onChanged: onChanged,
    );
  }

  static Widget buildPhoneNumberField({
    required TextEditingController controller,
  }) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.phone,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        hintText: "Your mobile number",
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Padding(
          padding: EdgeInsets.all(12.0),
          child: Text("+91", style: TextStyle(fontSize: 16)),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
