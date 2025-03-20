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
      theme: ThemeData(fontFamily: 'Arial'),
      home: const HelpAndSupportScreen(),
    );
  }
}

class HelpAndSupportScreen extends StatelessWidget {
  const HelpAndSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const Text(
                    'Back',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Centered Title
              const Center(
                child: Text(
                  'Help and Support',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),

              // Scrollable Content
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    'Lorem ipsum dolor sit amet consectetur. Sit pulvinar mauris mauris eu nibh semper nisl pretium laoreet. '
                    'Sed non faucibus ac lectus eu arcu. Nulla sit congue facilisis vestibulum egestas nisl feugiat pharetra. '
                    'Odio sit tortor morbi at orci ipsum dapibus interdum. Lorem felis est aliquet arcu nullam pellentesque. '
                    'Et habitasse ac arcu et nunc euismod rhoncus facilisis sollicitudin.',
                    style: const TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
