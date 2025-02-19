// notification_screen.dart
import 'package:almarsa/constants/app_colors.dart';
import 'package:almarsa/constants/custom_text.dart';
import 'package:almarsa/screens/notification/controller/notification_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});

  final NotificationController controller = Get.find<NotificationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        // This ensures all icons are white
        title: Text(
          'Notifications',
          style: CustomTextStyles.getLargeStyle4(context),
        ),
      ),
      body: Obx(
        () {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.notifications.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.notifications_off_outlined,
                      size: 48.sp,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'No notifications yet',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: controller.fetchNotifications,
            child: ListView.builder(
              padding: EdgeInsets.all(16.r),
              itemCount: controller.notifications.length,
              itemBuilder: (context, index) {
                final notification = controller.notifications[index];
                return NotificationCard(
                  name: notification.title,
                  title: notification.message,
                  time: controller.getTimeAgo(notification.createdAt),
                  isRead: notification.readAt,
                  onTap: () {
                    if (!notification.readAt) {
                      controller.markAsRead(notification.id);
                    }
                    Get.snackbar(
                      notification.title,
                      notification.message,
                      duration: const Duration(seconds: 3),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final String name;
  final String title;
  final String time;
  final bool isRead;
  final VoidCallback onTap;

  const NotificationCard({
    super.key,
    required this.name,
    required this.title,
    required this.time,
    required this.isRead,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        decoration: BoxDecoration(
          color: isRead ? Colors.grey.withOpacity(0.1) : AppColors.primaryColor,
          border: Border.all(
            color: isRead ? Colors.grey.shade600 : Colors.blue.shade400,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(12.r),
        ),
        padding: EdgeInsets.all(12.r),
        child: Row(
          children: [
            Icon(
              Icons.notifications,
              color: isRead ? Colors.grey : Colors.blue,
              size: 24.r,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: isRead ? Colors.grey : Colors.black,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: isRead ? Colors.grey : Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            Text(
              time,
              style: TextStyle(
                fontSize: 11.sp,
                color: isRead ? Colors.grey : Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
