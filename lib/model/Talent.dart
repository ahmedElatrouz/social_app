

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
  
  Talent({ String nom,
  String prenom,
  String genre,
  var age,
  String password,
  String email,
  String nationalite,
  String uid,
  //Categorie cat,
  String photo,
  String video,
  String description}
  ):super(nom:nom,prenom:prenom,genre:genre,age:age,password:password,email:email,nationalite:nationalite){
    this.uid=uid;
   // this.categorie=cat;
    this.photo=photo;
    this.video=video;
    this.description=description;
    
  }

  

  void aimerPost(Post post){
    post.nombreLikes=post.nombreLikes++;
  }
  


  Map<String, dynamic> toMap() {
    //TODO:complete this methode
    return {
      'uid': uid,
      'Categorie': categorie.toMap(),
      'photo="sdl"': photo="sdl",
      'video="sdl"': video="sdl",
      'description="sdl"': description="sdl",
      'posts': List<dynamic>.from(posts.map((x) => x.toMap())),
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
      photo:map['photo'],
      video:map['video'],
      nationalite: map['nationalite'],
      //age: int.tryParse(map['age']),
     // Categorie categorie.fromMap(map['']),
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

 