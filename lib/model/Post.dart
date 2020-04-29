import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

//import 'package:social_app/model/Talent.dart';


class Post {
  String postId;
  int likesCount;
  Timestamp date;
  String description;
  String photoUrl;
  String videoUrl;
  String talentId;
  Map likes;
  
  
  Post({
    this.postId,
    this.likesCount,
    this.date,
    this.description,
    this.photoUrl,
    this.videoUrl,
    this.talentId,
  });


  int getLikesCount(){
    if(likes == null) return 0;
    int count = 0;
    likes.values.forEach((val){
      if(val == true){
        count +=1;
      }
    });
    return count;
  }
  

  Map<String, dynamic> toMap() {
    if (this==null) return {};
    return {
      'postID': postId,
      'likes': likes,
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
      likesCount: map['likesCount'],
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
