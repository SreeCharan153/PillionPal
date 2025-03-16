import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Color.fromRGBO(0, 137, 85, 1); // PillionPal theme green

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Theme.of(context).iconTheme.color),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              'History',
              style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color, fontSize: 20),
            ),
          ),
          bottom: TabBar(
            indicatorColor: primaryColor,
            labelColor: Theme.of(context).textTheme.bodyLarge?.color,
            unselectedLabelColor: Colors.grey,
            tabs: const [
              Tab(text: "Upcoming"),
              Tab(text: "Completed"),
              Tab(text: "Cancelled"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ListTileWidget(listType: "Upcoming"),
            ListTileWidget(listType: "Completed"),
            ListTileWidget(listType: "Cancelled"),
          ],
        ),
      ),
    );
  }
}

class ListTileWidget extends StatelessWidget {
  final String listType;

  const ListTileWidget({required this.listType, super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDarkMode ? Colors.grey[900] : Colors.white;
    final textColor = isDarkMode ? Colors.white : Colors.black;
    final subtitleColor = isDarkMode ? Colors.grey : Colors.black54;

    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          padding: const EdgeInsets.all(12),
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
                    )
                  ],
          ),
          child: ListTile(
            leading: Icon(
              listType == "Upcoming"
                  ? Icons.schedule
                  : listType == "Completed"
                      ? Icons.check_circle
                      : Icons.cancel,
              color: listType == "Upcoming"
                  ? Colors.amber
                  : listType == "Completed"
                      ? Color.fromRGBO(0, 137, 85, 1)
                      : Colors.red,
            ),
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
              // TODO: Implement ride details navigation
            },
          ),
        );
      },
    );
  }
}
