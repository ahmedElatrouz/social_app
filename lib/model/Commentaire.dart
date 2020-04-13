import 'dart:convert';

import 'package:social_app/model/Annonce.dart';
import 'package:social_app/model/Talent.dart';

class Commentaire {
  String uid;
  String contenue;
  DateTime date;
  Talent talent;
  Annonce annonce;

  Commentaire({
    this.uid,
    this.contenue,
    this.date,
    this.talent,
    this.annonce,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'date': date,
      'contenue': contenue,
      'talent': talent.toMap(),
      'annonce': annonce.toMap(),
    };
  }

  static Commentaire fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Commentaire(
      uid: map['uid'],
      contenue: map['contenue'],
      date: map['date'],
      talent: Talent.fromMap(map['talent']),
      annonce: Annonce.fromMap(map['annonce']),
    );
  }

  String toJson() => json.encode(toMap());

  static Commentaire fromJson(String source) => fromMap(json.decode(source));
}
