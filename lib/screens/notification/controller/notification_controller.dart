// notification_controller.dart
import 'dart:convert';

import 'package:almarsa/constants/app_keys.dart';
import 'package:almarsa/models/notification_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationController extends GetxController {
  final _notifications = <NotificationModel>[].obs;
  final _isLoading = false.obs;
  final _database = FirebaseDatabase.instance.ref();
  String? userId;

  bool get isLoading => _isLoading.value;

  List<NotificationModel> get notifications => _notifications;

  @override
  void onInit() {
    super.onInit();
    _getUserId();
  }

  int get unreadCount =>
      _notifications.where((notification) => !notification.readAt).length;

  Future<void> _getUserId() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final userInfoString = sharedPreferences.getString(AppKeys.userInfoKey);
      if (userInfoString != null) {
        final data = jsonDecode(userInfoString);
        userId = data["user"]["id"].toString();
        fetchNotifications(); // Fetch notifications once we have the user ID
      }
    } catch (e) {
      print('Error getting user ID: $e');
    }
  }

  Future<void> fetchNotifications() async {
    if (userId == null) {
      print('User ID not available');
      return;
    }

    _isLoading.value = true;
    try {
      _database
          .child('notifications')
          .child('user_$userId')
          .onValue
          .listen((event) {
        if (event.snapshot.exists && event.snapshot.value != null) {
          final data = event.snapshot.value as Map;
          _notifications.value = data.entries.map((e) {
            return NotificationModel.fromJson(
                e.key as String, Map.from(e.value as Map));
          }).toList();

          _notifications.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        } else {
          _notifications.clear();
        }
      });
    } catch (e) {
      print('Error fetching notifications: $e');
      _notifications.clear();
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> markAsRead(String notificationId) async {
    if (userId == null) return;

    try {
      // Update in Firebase
      await _database
          .child('notifications')
          .child('user_$userId')
          .child(notificationId)
          .child('read_at')
          .set(true);

      // Update local state
      final index = _notifications.indexWhere((n) => n.id == notificationId);
      if (index != -1) {
        final notification = _notifications[index];
        notification.readAt = true;
        _notifications[index] = notification;
        _notifications.refresh();
      }
    } catch (e) {
      print('Error marking notification as read: $e');
    }
  }

  String getTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 7) {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    } else if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}
