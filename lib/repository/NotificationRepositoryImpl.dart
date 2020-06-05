import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_app/model/Notification.dart';
import 'package:social_app/repository/NotificationRepository.dart';
import 'package:uuid/uuid.dart';

final notifRef = Firestore.instance.collection('Notifications');

class NotificationRepositoryImpl implements NotificationRepository {
  String notifId = Uuid().v4();

  @override
  Future<int> createNotification(Notifications notification) async {
    int r = 0;
    try {
      notification.uid = notifId;
      await notifRef.document(notifId).setData({
        'uid': notifId,
        'date': notification.date,
        'talent': notification.talent.toMap(),
        'annonceId': notification.annonceId,
        'proId' : notification.proId,
      });
      r = 1;
    } catch (e) {
      print(e);
    }
    return r;
  }

  @override
  Future<int> deleteNotification(String id) async {
    int r = 0;
    var doc = await notifRef.document(id).get();
    try {
      if (doc.exists) {
        doc.reference.delete();
        r = 1;
      }
    } catch (e) {
      print(e);
    }
    return r;
  }

  @override
  Future<int> updateNotification(Notifications notification) async {
    int r = 0;
    var doc = await notifRef.document(notification.uid).get();
    try {
      if (doc.exists) {
        doc.reference.updateData(notification.toMap());
        r = 1;
      }
    } catch (e) {
      print(e);
    }
    return r;
  }
}
