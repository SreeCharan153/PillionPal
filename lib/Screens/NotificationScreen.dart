import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: NotificationScreen(),
  ));
}

class NotificationScreen extends StatelessWidget {
  // Sample notification data
  final List<Map<String, dynamic>> notifications = [
    {
      'title': 'Rider Request Successful',
      'subtitle': 'You Can Be a Rider',
      'time': '15 min ago',
      'isHighlighted': true,
      'category': 'Today'
    },
    {
      'title': 'Payment confirm',
      'subtitle': 'Lorem ipsum dolor sit amet consectetur...',
      'time': '25 min ago',
      'isHighlighted': false,
      'category': 'Yesterday'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Notification",
          style: TextStyle( fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: _buildNotificationList(),
        ),
      ),
    );
  }

  List<Widget> _buildNotificationList() {
    List<Widget> widgets = [];
    String? lastCategory;

    for (var notification in notifications) {
      if (lastCategory != notification['category']) {
        widgets.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              notification['category'],
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        );
        lastCategory = notification['category'];
      }

      widgets.add(
        Card(
         // color: notification['isHighlighted'] ? Colors.green[50] : Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification['title'],
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  notification['subtitle'],
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                SizedBox(height: 6),
                Text(
                  notification['time'],
                  style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return widgets;
  }
}
