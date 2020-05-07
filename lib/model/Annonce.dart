import 'dart:convert';

class Annonce {
  String id; 
  DateTime date;
  String description;
  String proRef;
  Map comments ;

  Annonce({this.id, this.date, this.description, this.proRef,this.comments});

  Map<String, dynamic> toMap() {
    return {
      'uid': id,
      'date': date,
      'description': description,
      'proRef': proRef,
      'comments':comments,
    };
  }

  static Annonce fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    return Annonce(
      id: map['uid'],
      description: map['description'],
      date:map['date'].toDate(),
      proRef: map['profRef'],
      comments: map['comments'],
    );
  }

  String toJson() => json.encode(toMap());

  static Annonce fromJson(String source) => fromMap(json.decode(source));
}
