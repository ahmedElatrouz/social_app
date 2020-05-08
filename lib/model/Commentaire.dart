import 'dart:convert';


class Commentaire {
  String uid;
  String contenue;
  DateTime date;
  String talentID;
  String annonceID;
  String nomTalent;
  String photoProfile;

  Commentaire({
    this.uid,
    this.contenue,
    this.date,
    this.talentID,
    this.annonceID,
    this.nomTalent,
    this.photoProfile,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'date': date,
      'contenue': contenue,
      'talent_ID': talentID,
      'annonce_ID': annonceID,
      'nomTalent': nomTalent,
      'photoProfile': photoProfile,

    };
  }

  static Commentaire fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Commentaire(
      uid: map['uid'],
      contenue: map['contenue'],
      date: map['date'],
      talentID : map['talent_ID'],
      annonceID: map['annonce_ID'],
      nomTalent: map['nomTalent'],
      photoProfile: map['photoProfile'],
    );
  }

  String toJson() => json.encode(toMap());

  static Commentaire fromJson(String source) => fromMap(json.decode(source));
}
