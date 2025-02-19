// notification_model.dart

class NotificationModel {
  final String id;
  final DateTime createdAt;
  final String message;
  bool readAt;
  final String title;

  NotificationModel({
    required this.id,
    required this.createdAt,
    required this.message,
    required this.readAt,
    required this.title,
  });

  factory NotificationModel.fromJson(String id, Map<String, dynamic> json) {
    return NotificationModel(
      id: id,
      createdAt: DateTime.parse(
          json['created_at'] ?? DateTime.now().toIso8601String()),
      message: json['data']['message'] ?? '',
      readAt: json['read_at'] ?? false,
      title: json['title'] ?? 'Notification',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'created_at': createdAt.toIso8601String(),
      'data': {
        'message': message,
      },
      'read_at': readAt,
      'title': title,
    };
  }
}
