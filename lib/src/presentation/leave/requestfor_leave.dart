
import 'package:delivery_app/src/presentation/leave/new_application.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RequestForLeave extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Leave Request'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'New Application'),
              Tab(text: 'My Application'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            NewApplicationTab(),
            MyApplicationTab(), // Placeholder for My Application Tab
          ],
        ),
      ),
    );
  }
}
