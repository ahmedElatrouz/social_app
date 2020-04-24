import 'dart:convert';

//import 'package:social_app/model/Talent.dart';


class Post {
  String postId;
  int nombreLikes;
  DateTime date;
  String description;
  String photoUrl;
  String videoUrl;
  String talentId;
  
  
  Post({
    this.postId,
    this.nombreLikes,
    this.date,
    this.description,
    this.photoUrl,
    this.videoUrl,
    this.talentId,
  });
  

  Map<String, dynamic> toMap() {
    return {
      'postID': postId,
      'nombreLikes': nombreLikes,
      'date': date,
      'description': description,
      'photoUrl': photoUrl,
      'videoUrl': videoUrl,
      'talent_ID': talentId,     //talent.toMap(),
    };
  }

  static Post fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Post(
      postId: map['postID'],
      nombreLikes: map['nombreLikes'],
      date: map['date'],
      description: map['description'],
      photoUrl: map['photoUrl'],
      videoUrl: map['videoUrl'],
      talentId: map['talent_ID'], //Talent.fromMap(map['talent']),
    );
  }

  String toJson() => json.encode(toMap());

  static Post fromJson(String source) => fromMap(json.decode(source));
}
