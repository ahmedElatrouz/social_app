

import 'dart:convert';

import 'package:social_app/model/Categorie.dart';
import 'package:social_app/model/Post.dart';

import 'Utilisateur.dart';

class Talent extends Utilisateur {
  String uid;
  Categorie categorie ;
  String photo="sdl";
  String video="sdl";
  String description="sdl";
  List<Post> posts;
  
  Talent({
    this.uid,
    this.categorie,
    this.photo="sdl",
    this.video="sdl",
    this.description="sdl",
    this.posts,
  });

  void aimerPost(Post post){
    post.nombreLikes=post.nombreLikes++;
  }
  
  

  



  



  Map<String, dynamic> toMap() {
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
      uid: map['uid'],
      categorie:null,
     // categorie: Categorie categorie.fromMap(map['']),
      photo: map['photo="sdl"'],
      video: map['video="sdl"'],
      description: map['description="sdl"'],
      posts: List<Post>.from(map['posts']?.map((x) => Post.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  static Talent fromJson(String source) => fromMap(json.decode(source));
 }
