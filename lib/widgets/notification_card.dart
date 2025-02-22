import 'package:almarsa/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
            color: isRead ? Colors.grey.shade600 : AppColors.primaryColor,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(12.r),
        ),
        padding: EdgeInsets.all(12.r),
        child: Row(
          children: [
            Icon(
              Icons.notifications,
              color: isRead ? Colors.grey : Colors.white,
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
                      color: isRead ? Colors.grey : Colors.white,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: isRead ? Colors.grey : Colors.white,
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
                color: isRead ? Colors.grey : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
