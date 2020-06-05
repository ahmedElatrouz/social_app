import 'package:social_app/model/Notification.dart';

abstract class NotificationRepository {
  Future<int> createNotification(Notifications notification);
  Future<int> updateNotification(Notifications notification);
  Future<int> deleteNotification(String id);
}
