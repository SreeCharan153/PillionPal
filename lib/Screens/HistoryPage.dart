import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = const Color.fromRGBO(0, 137, 85, 1); // PillionPal theme green
    final theme = Theme.of(context);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: theme.appBarTheme.backgroundColor,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: theme.iconTheme.color),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'History',
            style: TextStyle(color: theme.textTheme.bodyLarge?.color, fontSize: 20),
          ),
          bottom: TabBar(
            indicatorColor: primaryColor,
            labelColor: theme.textTheme.bodyLarge?.color,
            unselectedLabelColor: Colors.grey,
            tabs: const [
              Tab(text: "Upcoming"),
              Tab(text: "Completed"),
              Tab(text: "Cancelled"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            HistoryList(listType: "Upcoming"),
            HistoryList(listType: "Completed"),
            HistoryList(listType: "Cancelled"),
          ],
        ),
      ),
    );
  }
}

class HistoryList extends StatelessWidget {
  final String listType;

  const HistoryList({required this.listType, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final cardColor = isDarkMode ? Colors.grey[900] : Colors.white;
    final textColor = theme.textTheme.bodyLarge?.color ?? Colors.black;
    final subtitleColor = isDarkMode ? Colors.grey : Colors.black54;
    final iconColor = listType == "Upcoming"
        ? Colors.amber
        : listType == "Completed"
            ? const Color.fromRGBO(0, 137, 85, 1)
            : Colors.red;

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: isDarkMode
                ? []
                : [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 6,
                      spreadRadius: 2,
                    ),
                  ],
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: Icon(Icons.directions_bike, color: iconColor, size: 28),
            title: Text(
              '$listType Ride $index',
              style: TextStyle(color: textColor, fontSize: 16),
            ),
            subtitle: Text(
              'Details of ride $index',
              style: TextStyle(color: subtitleColor, fontSize: 14),
            ),
            trailing: Icon(Icons.arrow_forward_ios, color: textColor, size: 18),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/RideDetailsPage',
                arguments: {
                  'bikeName': '$listType Ride $index', // Example data
                  'gender': 'Male', // Example data
                  'bikeNo': 'Bike No. $index', // Example data
                  'licenceNo': 'Licence No. $index', // Example data
                },
              );

            },
          ),
        );
      },
    );
  }
}
