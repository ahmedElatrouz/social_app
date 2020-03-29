

import 'package:social_app/model/Categorie.dart';
import 'package:social_app/model/Post.dart';

import 'Utilisateur.dart';

class Talent extends Utilisateur {
  int id=1;
  Categorie categorie ;
  String photo="sdl";
  String video="sdl";
  String description="sdl";
  List<Post> posts;
  Talent({
    this.id=1,
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
