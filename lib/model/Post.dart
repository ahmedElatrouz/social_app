import 'package:social_app/model/Talent.dart';

class Post {
  int postID;
  int nombreLikes;
  String date;
  String description;
  String photoUrl;
  String videoUrl;
  Talent talent;
  
  
  Post({
    this.postID,
    this.nombreLikes,
    this.date,
    this.description,
    this.photoUrl,
    this.videoUrl,
    this.talent,
  });
  
}
