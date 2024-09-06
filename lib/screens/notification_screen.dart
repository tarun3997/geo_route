import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geo_route/model/notification_model.dart';
import 'package:geo_route/server/api/notification_api.dart';
import 'package:geo_route/utils/timestamp.dart';
import 'package:geo_route/widget/notification_card.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  Future<List<NotificationModel>>? notificationModel;

  @override
  void initState() {
    notificationModel = handelGetNotification();
    super.initState();
  }

  Future<void> _refreshNotifications() async {
    setState(() {
      notificationModel = handelGetNotification();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        shadowColor: Colors.grey,
        title: const Text('Notifications'),
      ),
      body: Theme.of(context).platform == TargetPlatform.iOS
          ? _buildCupertinoList()
          : _buildMaterialList(),
    );
  }

  Widget _buildCupertinoList() {
    return FutureBuilder<List<NotificationModel>>(
      future: notificationModel,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CupertinoActivityIndicator(radius: 20),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData) {
          return const Center(child: Text("No data found"));
        } else {
          final data = snapshot.data!;
          return CustomScrollView(
            slivers: <Widget>[
              CupertinoSliverRefreshControl(
                onRefresh: _refreshNotifications,
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    final notification = data[index];
                    String formattedTime = formatTimestamp(notification.time);
                    return NotificationCard(
                      vehicleNumber: notification.vehicleNumber,
                      title: notification.title,
                      body: notification.body,
                      time: formattedTime,
                    );
                  },
                  childCount: data.length,
                ),
              ),
            ],
          );
        }
      },
    );
  }

  Widget _buildMaterialList() {
    return RefreshIndicator(
      onRefresh: _refreshNotifications,
      child: FutureBuilder<List<NotificationModel>>(
        future: notificationModel,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData) {
            return const Center(child: Text("No data found"));
          } else {
            final data = snapshot.data!;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final notification = data[index];
                String formattedTime = formatTimestamp(notification.time);
                return NotificationCard(
                  vehicleNumber: notification.vehicleNumber,
                  title: notification.title,
                  body: notification.body,
                  time: formattedTime,
                );
              },
            );
          }
        },
      ),
    );
  }
}
