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
    String photoProfile,
  }) : super(
            nom: nom,
            prenom: prenom,
            genre: genre,
            age: age,
            password: password,
            email: email,
            nationalite: nationalite,
            tel: tel,
            photoProfile : photoProfile) {
    this.proID = proID;
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': proID,
      'annonce': List<dynamic>.from(annonces.map((x) => x.toMap())),
      'photoProfile' :photoProfile
    };
  }



/*static Talent fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Talent(
      uid:map['uid'],
      email:map['email'],
      nom:map['nom'],
      prenom:map['prenom'],
      description:map['description'],
      password:map['password'],
      genre:map['genre'],
      photo:map['photoUrl'],
      video:map['videoUrl'],
      nationalite: map['nationalite'],
      //age: int.tryParse(map['age']),
     // Categorie categorie.fromMap(map['']),
    //  List<Post>.from(map['posts']?.map((x) => Post.fromMap(x))),
    );
  }*/
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
      photoProfile: map['photoProfile']
      // List<Annonce>.from(map['annonces']?.map((x) => Annonce.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  static Professionnel fromJson(String source) => fromMap(json.decode(source));
}
