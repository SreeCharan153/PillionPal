import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool disabled; // added

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.disabled = false, // default false
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: disabled
              ? Colors.grey // gray when disabled
              : const Color.fromRGBO(0, 137, 85, 1), // green when enabled
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: disabled ? null : onPressed, // disable button
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
