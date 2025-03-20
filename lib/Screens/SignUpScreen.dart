// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:pillionpal/Screens/OTP_Verification_Screen.dart';
import 'package:pillionpal/Screens/login_screen.dart';
import '../widgets/InputFields.dart';
import '../widgets/PrimaryButton.dart';
import '../widgets/CustomButtons.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  String? selectedGender;
  bool agreeToTerms = false;
  bool isLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _signUp() async {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String phone = phoneController.text.trim();

    // Validate fields
    if (name.isEmpty || email.isEmpty || phone.isEmpty || selectedGender == null) {
      _showSnackbar("All fields are required", Colors.red);
      return;
    }

    if (phone.length != 10) {
      _showSnackbar("Phone number must be 10 digits", Colors.red);
      return;
    }

    if (!agreeToTerms) {
      _showSnackbar("You must agree to the Terms & Conditions", Colors.red);
      return;
    }

    setState(() => isLoading = true);

    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: "+91$phone",
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
         _showSnackbar("Error: ${e.toString()}", Colors.red);
        },
        codeSent: (String verificationId, int? resendToken) {
          Get.to(() => OTPVerificationScreen(
                name: name,
                email: email,
                phone: phone,
                verificationId: verificationId,
              ));
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      _showSnackbar("Error: ${e.toString()}", Colors.red);
    } finally {
      setState(() => isLoading = false);
    }
  }

  void _showSnackbar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: color),
    );
  }

  Future<void> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return; // User canceled sign-in
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await _auth.signInWithCredential(credential);
      _showSnackbar("Google Sign-In successful!", Colors.green);
    } catch (e) {
      _showSnackbar("Google Sign-In failed: ${e.toString()}", Colors.red);
    }
  }

  Future<void> _signInWithApple() async {
    try {
      final AuthorizationCredentialAppleID credential =
          await SignInWithApple.getAppleIDCredential(scopes: [AppleIDAuthorizationScopes.email]);
      final OAuthCredential oAuthCredential = OAuthProvider("apple.com").credential(
        idToken: credential.identityToken,
      );
      await _auth.signInWithCredential(oAuthCredential);
      _showSnackbar("Apple Sign-In successful!", Colors.green);
    } catch (e) {
      _showSnackbar("Apple Sign-In failed: ${e.toString()}", Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 30),

              // Title
              const Text(
                "Create Your Account",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color.fromRGBO(0, 137, 85, 1)),
              ),
              const SizedBox(height: 30),

              // Full Name
              InputFields.buildTextField(hint: "Full Name", controller: nameController, context: context),
              const SizedBox(height: 16),

              // Email
              InputFields.buildTextField(hint: "Email", controller: emailController, keyboardType: TextInputType.emailAddress, context: context),
              const SizedBox(height: 16),

              // Phone Number
              InputFields.buildPhoneNumberField(controller: phoneController, context: context),
              const SizedBox(height: 16),

              // Gender Dropdown
              DropdownButtonFormField<String>(
                value: selectedGender,
                decoration: InputDecoration(
                  hintText: "Select Gender",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                ),
                items: ["Male", "Female", "Other"].map((gender) {
                  return DropdownMenuItem(value: gender, child: Text(gender));
                }).toList(),
                onChanged: (value) => setState(() => selectedGender = value),
              ),
              const SizedBox(height: 20),

              // Terms & Conditions Checkbox
              Row(
                children: [
                  Checkbox(
                    value: agreeToTerms,
                    activeColor: const Color.fromRGBO(0, 137, 85, 1),
                    onChanged: (value) => setState(() => agreeToTerms = value!),
                  ),
                  const Expanded(child: Text("I agree to the Terms & Conditions", style: TextStyle(fontSize: 14))),
                ],
              ),
              const SizedBox(height: 10),

              // Sign Up Button
              isLoading
                  ? const CircularProgressIndicator()
                  : PrimaryButton(text: "Sign Up", onPressed: _signUp),
              const SizedBox(height: 20),

              // OR Divider
              const Row(
                children: [
                  Expanded(child: Divider(thickness: 1)),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 10), child: Text("OR")),
                  Expanded(child: Divider(thickness: 1)),
                ],
              ),
              const SizedBox(height: 20),

              // Google Sign-Up Button
              CustomButtons.buildOutlinedButton(
                text: "Sign up with Google",
                icon: FontAwesomeIcons.google,
                onPressed: _signInWithGoogle,
              ),
              const SizedBox(height: 10),

              // Apple Sign-Up Button
              CustomButtons.buildOutlinedButton(
                text: "Sign up with Apple",
                icon: Icons.apple,
                onPressed: _signInWithApple,
              ),
              const SizedBox(height: 20),

              // Already have an account? Sign In
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?"),
                  TextButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage())),
                    child: const Text("Sign In", style: TextStyle(color: Color.fromRGBO(0, 137, 85, 1))),
                  ),
                ],
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
