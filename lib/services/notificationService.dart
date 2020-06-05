import 'package:social_app/model/Notification.dart';
import 'package:social_app/repository/NotificationRepository.dart';
import 'package:social_app/repository/NotificationRepositoryImpl.dart';

class NotificationService {
  NotificationRepository notificationRepository;

  NotificationService() {
    notificationRepository = NotificationRepositoryImpl();
  }

  Future<int> createNotification(Notifications notification) {
    return notificationRepository.createNotification(notification);
  }

  Future<int> updateNotification(Notifications notification) {
    return notificationRepository.updateNotification(notification);
  }

  Future<int> deleteNotification(String id) {
    return notificationRepository.deleteNotification(id);
  }
}