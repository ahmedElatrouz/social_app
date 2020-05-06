//import 'package:social_app/model/Professionnel.dart';

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Annonce {
  String id;
  DateTime date;
  String description;
  String proRef;

  Annonce({this.id, this.date, this.description, this.proRef});

  Map<String, dynamic> toMap() {
    return {
      'uid': id,
      'date': date,
      'description': description,
      'proRef': proRef,
    };
  }

  static Annonce fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    return Annonce(
      id: map['uid'],
      description: map['description'],
      date:map['date'].toDate(),
      proRef: map['profRef'],
    );
  }

  String toJson() => json.encode(toMap());

  static Annonce fromJson(String source) => fromMap(json.decode(source));
}
