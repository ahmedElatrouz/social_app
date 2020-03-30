

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
  
  

  



  


 }
