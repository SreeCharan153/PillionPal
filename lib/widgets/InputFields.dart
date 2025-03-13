// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputFields {
  // 🟢 Text Field Widget
  static Widget buildTextField({
    required BuildContext context,
    required String hint,
    required TextEditingController controller,
    bool isPassword = false,
    Widget? suffixIcon,
    Widget? prefixIcon,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    final theme = Theme.of(context);

    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: theme.colorScheme.surface, // Dynamic color adaptation
        contentPadding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 12,
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: theme.colorScheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: theme.colorScheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(
            color: Color.fromRGBO(0, 137, 85, 1),
            width: 2,
          ),
        ),
      ),
    );
  }

  // 🟢 Dropdown Field Widget
  static Widget buildDropdownField({
    required BuildContext context,
    required String hint,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    String? value,
  }) {
    final theme = Theme.of(context);

    return DropdownButtonFormField<String>(
      value: items.contains(value) ? value : null,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: theme.colorScheme.surface, // Theme-adaptive color
        contentPadding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: theme.colorScheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: theme.colorScheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(
            color: Color.fromRGBO(0, 137, 85, 1),
            width: 2,
          ),
        ),
      ),
      hint: Text(hint, style: TextStyle(color: theme.hintColor)),
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

  // 🟢 Phone Number Field Widget
  static Widget buildPhoneNumberField({
    required BuildContext context,
    required TextEditingController controller,
  }) {
    final theme = Theme.of(context);

    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.phone,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        hintText: "Your mobile number",
        filled: true,
        fillColor: theme.colorScheme.surface, // Dynamic adaptation
        contentPadding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 12,
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text(
                "+91",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 5),
            ],
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: theme.colorScheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: theme.colorScheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(
            color: Color.fromRGBO(0, 137, 85, 1),
            width: 2,
          ),
        ),
      ),
    );
  }
}
