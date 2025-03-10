import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import '../widgets/PrimaryButton.dart'; // Importing PrimaryButton component

class OTPVerificationScreen extends StatelessWidget {
  const OTPVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Phone verification",
              style: TextStyle(
                fontSize: size.width * 0.06,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: size.height * 0.01),
            const Text(
              "Enter your OTP code",
              style: TextStyle(color: Colors.grey),
            ),

            SizedBox(height: size.height * 0.03),

            // OTP Input
            Pinput(
              length: 4,
              keyboardType: TextInputType.number,
              defaultPinTheme: PinTheme(
                width: size.width * 0.15,
                height: size.width * 0.15,
                textStyle: TextStyle(
                  fontSize: size.width * 0.05,
                  fontWeight: FontWeight.bold,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            SizedBox(height: size.height * 0.03),

            // Resend Code
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Didn’t receive code?"),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Resend again",
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: size.height * 0.04),

            // Verify Button using PrimaryButton
            PrimaryButton(
              text: "Verify",
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
