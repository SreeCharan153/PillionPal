import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';
import 'package:pillionpal/Screens/complete_your_profile.dart';
import 'package:pinput/pinput.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:pillionpal/Screens/SetPasswordScreen.dart';
import '../widgets/PrimaryButton.dart';

class OTPVerificationScreen extends StatefulWidget {
  final String name;
  final String email;
  final String phone;
  final String password;
  //final String verificationId; // ✅ Added for OTP verification

  const OTPVerificationScreen({
    super.key,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
   // required this.verificationId, // ✅ Ensure it's required
  });

  @override
  _OTPVerificationScreenState createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  final TextEditingController _otpController = TextEditingController();
  bool _isVerifying = false;
  // final FirebaseAuth _auth = FirebaseAuth.instance;

  void _verifyOTP() async {
    FocusScope.of(context).unfocus();
    setState(() => _isVerifying = true);
    void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: color),
    );
  }


    String enteredOTP = _otpController.text.trim();

    if (enteredOTP.length != 6) {
      _showSnackBar("OTP must be 6 digits!", Colors.orange);
      setState(() => _isVerifying = false);
      return;
    }
    if(enteredOTP == '100100'){
      setState(() => _isVerifying = false);
      Get.to(() => CompleteProfile());
    }
    else{
      _showSnackBar("Invalid OTP! Please try again.", Colors.red);
      setState(() => _isVerifying = false);
      return;
    }

    // try {
    //   PhoneAuthCredential credential = PhoneAuthProvider.credential(
    //     verificationId: widget.verificationId,
    //     smsCode: enteredOTP,
    //   );

    //   await _auth.signInWithCredential(credential);
    //   Get.to(() => CompleteProfile());
    // } catch (e) {
    //   _showSnackBar("Invalid OTP! Please try again.", Colors.red);
    // }

    
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
                const Text("Enter your OTP code", style: TextStyle(color: Colors.grey)),
                SizedBox(height: size.height * 0.03),

                Pinput(
                  controller: _otpController,
                  length: 6,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(6)],
                  onCompleted: (pin) {
                    Future.delayed(const Duration(milliseconds: 300), () {
                      _verifyOTP();
                    });
                  },
                ),

                SizedBox(height: size.height * 0.03),

                _isVerifying ? const CircularProgressIndicator() : PrimaryButton(text: "Verify", onPressed: _verifyOTP),

                SizedBox(height: size.height * 0.05),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
