import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Success Dialog Example')),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => const SuccessDialog(),
              );
            },
            child: const Text('Show Dialog'),
          ),
        ),
      ),
    );
  }
}

class SuccessDialog extends StatelessWidget {
  const SuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Close Button (X) in top-right
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.black54),
                onPressed: () => Navigator.pop(context),
              ),
            ),

            const SizedBox(height: 10),

            // Success Icon (Styled)
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green.withOpacity(0.2), // Light green background
              ),
              padding: const EdgeInsets.all(20),
              child: const Icon(Icons.check, color: Colors.green, size: 40),
            ),

            const SizedBox(height: 20),

            // Success Message (Centered)
            const Text(
              'successful',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),

            const SizedBox(height: 40),

            // Green "Done" Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Done',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
