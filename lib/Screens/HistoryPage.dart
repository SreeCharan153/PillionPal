import 'package:flutter/material.dart';


class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text('History'),
          ),
          bottom: TabBar(
            tabs: [
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
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            title: Text('$listType Item $index'),
            subtitle: Text('Subtitle $index'),
          ),
        );
      },
    );
  }
}
















