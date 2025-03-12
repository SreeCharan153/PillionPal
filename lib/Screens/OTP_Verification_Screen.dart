import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';
import 'package:pillionpal/Screens/SetPasswordScreen.dart';
import '../widgets/PrimaryButton.dart';

class OTPVerificationScreen extends StatefulWidget {
  const OTPVerificationScreen({super.key});

  @override
  _OTPVerificationScreenState createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  final TextEditingController _otpController = TextEditingController();
  final String _correctOTP = "123456"; // Replace with backend OTP validation
  bool _isVerifying = false; // State for loading indicator

  void _verifyOTP() {
    FocusScope.of(context).unfocus(); // Close keyboard
    setState(() => _isVerifying = true); // Show loading

    String enteredOTP = _otpController.text.trim(); // Remove spaces


    Future.delayed(const Duration(milliseconds: 800), () {
      if (enteredOTP.length != 6) {
        _showSnackBar("OTP must be 6 digits!", Colors.orange);
      } else if (enteredOTP == _correctOTP) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SetPasswordScreen()),
        );
      } else {
        _showSnackBar("Invalid OTP! Please try again.", Colors.red);
      }

      setState(() => _isVerifying = false); // Hide loading
    });
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: color),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          reverse: true,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: size.height * 0.1),

                Text(
                  "Phone Verification",
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

                // OTP Input Field
                Pinput(
                  controller: _otpController,
                  length: 6,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(6),
                  ],
                  defaultPinTheme: PinTheme(
                    width: 50,
                    height: 50,
                    textStyle: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  focusedPinTheme: PinTheme(
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color.fromRGBO(0, 137, 85, 1)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onCompleted: (pin) {
                    Future.delayed(const Duration(milliseconds: 300), () {
                      _verifyOTP(); // Auto-verify when 6 digits are entered
                    });
                  },
                ),

                SizedBox(height: size.height * 0.03),

                // Resend Code Option
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Didn’t receive code?"),
                    TextButton(
                      onPressed: () => _showSnackBar(
                        "OTP has been resent!",
                        const Color.fromRGBO(0, 137, 85, 1),
                      ),
                      child: const Text(
                        "Resend again",
                        style: TextStyle(
                          color: Color.fromRGBO(0, 137, 85, 1),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: size.height * 0.04),

                // Verify Button with Loading Indicator
                _isVerifying
                    ? const CircularProgressIndicator()
                    : PrimaryButton(text: "Verify", onPressed: _verifyOTP),

                SizedBox(height: size.height * 0.05),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
