import 'dart:convert';

class Admin {
  String uid;
  String email;
  String password;

  Admin({
    this.uid,
    this.email,
    this.password,
  });

  Map<String, dynamic> toMap() {
    //TODO:complete this methode
    return {
      'uid': uid,
      'email': email,
      'password': password,
    };
  }

  static Admin fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Admin(
      uid: map['uid'],
      email: map['email'],
      password: map['password'],
    );
  }

  String toJson() => json.encode(toMap());

  static Admin fromJson(String source) => fromMap(json.decode(source));
}
