import 'dart:convert';

import 'package:my_first_try/model/User.dart';




class Talent /*extends User*/ {
  int id=1;
  String categorie="kld" ;
  String photo="sdl";
  String video="sdl";
  String description="sdl";
  String posts;

  


 /* Talent({
    this.id,
    this.categorie,
    this.photo,
    this.video,
    this.description,
  });*/

  
/*
  @override
  String toString() {
    return 'Talent(id: $id, nom: $nom, prenom: $prenom, categorie: $categorie, photo: $photo, description: $description, genre: $genre, age: $age)';
  }




  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nom': nom,
      'prenom': prenom,
      'categorie':categorie ,
      'photo': photo,
      'description': description,
      'genre': genre,
      'age': age,
    };
  }

  static Talent fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Talent(
      id: map['id'],
      nom: map['nom'],
      prenom: map['prenom'],
      categorie: map['categorie'], 
      photo: map['photo'],
      description: map['description'],
      genre: map['genre'],
      age: map['age'],
    );
  }

  String toJson() => json.encode(toMap());

  static Talent fromJson(String source) => fromMap(json.decode(source));
*/}
