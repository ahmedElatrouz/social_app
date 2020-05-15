

import 'dart:convert';
import 'package:social_app/model/Categorie.dart';
import 'package:social_app/model/Post.dart';

import 'Utilisateur.dart';

class Talent extends Utilisateur {

  String uid;
  Categorie categorie ;
  String photo;
  String video;
  String description;
  List<Post> posts;
  
  Talent({ 
  String nom,
  String prenom,
  String genre,
  var age,
  String password,
  String email,
  String nationalite,
  String uid,
  String tel,
  String photoProfile,
  Categorie categorie,
  String photo,
  String video,
  String description}
  ):super(photoProfile:photoProfile,nom:nom,prenom:prenom,genre:genre,age:age,password:password,email:email,nationalite:nationalite,tel:tel){
    this.uid=uid;
    this.categorie=categorie;
    this.photo=photo;
    this.video=video;
    this.description=description;
    
  }
  
  

  


  Map<String, dynamic> toMap() {
   if (this==null) return {};
    return {
      'uid': uid,
      'email':email,
      'nom':nom,
      'prenom':prenom,
      'password':password,
      'genre':genre,
      'nationalite':nationalite,
      'photoProfile' :photoProfile,
      'Categorie': categorie.toMap(),
      'photoUrl': photo,
      'videoUrl': video,
      'description': description,
      //'posts': List<dynamic>.from(posts.map((x) => x.toMap())),
    };
  }

  static Talent fromMap(Map<String, dynamic> map) {
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
      photoProfile :map['photoProfile'],
      //age: int.tryParse(map['age']),
      categorie : Categorie.fromMap(map['Categorie']),
    //  List<Post>.from(map['posts']?.map((x) => Post.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  static Talent fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Talent(${super.toString()} , uid: $uid , photo: $photo, video: $video, description: $description, posts: $posts)';
  }
}

 