import 'dart:convert';

import 'package:social_app/model/Annonce.dart';
import 'package:social_app/model/Utilisateur.dart';

class Professionnel extends Utilisateur {
  String proID;
  List<Annonce> annonces;

  Professionnel({
    String nom,
    String prenom,
    String genre,
    var age,
    String password,
    String email,
    String nationalite,
    String tel,
    String proID,
  }) : super(
            nom: nom,
            prenom: prenom,
            genre: genre,
            age: age,
            password: password,
            email: email,
            nationalite: nationalite,
            tel: tel) {
    this.proID = proID;
  }

  Map<String, dynamic> toMap() {
    //TODO:complete this methode
    return {
      'uid': proID,
      //'annonce': List<dynamic>.from(annonces.map((x) => x.toMap())),
    };
  }

  static Professionnel fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Professionnel(
      proID: map['uid'],
      email: map['email'],
      nom: map['nom'],
      prenom: map['prenom'],
      password: map['password'],
      genre: map['genre'],
      nationalite: map['nationalite'],
      age: int.tryParse(map['age']),
      // List<Annonce>.from(map['annonces']?.map((x) => Annonce.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  static Professionnel fromJson(String source) => fromMap(json.decode(source));
}
