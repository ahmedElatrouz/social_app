import 'dart:convert';

import 'package:social_app/model/Talent.dart';

class Notifications {
  String uid;
  DateTime date;
  Talent talent;
  String annonceId;
  String proId;

  Notifications({this.uid, this.date, this.talent, this.annonceId,this.proId});

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'date': date,
      'talent': talent.toMap(),
      'annonce': annonceId,
      'proId' : proId,
    };
  }

  static Notifications fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    return Notifications(
      uid: map['uid'],
      date: map['date'],
      talent: Talent.fromMap(map['talent']),
      annonceId: map['annonceId'],
      proId: map['proId'],
    );
  }

  String toJson() => json.encode(toMap());
  static Notifications fromJson(String source) => fromMap(json.decode(source));
}
