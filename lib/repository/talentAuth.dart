import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_app/model/Talent.dart';

class TalentAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _authStore = Firestore.instance.collection('Talent');
  Talent currentTalent;

  Future<FirebaseUser> currentUser() async {
    return await _auth.currentUser();
  }

  Future<String> getcurrentUserUid() async {
    return (await _auth.currentUser()).uid;
  }

  Talent _talentFromFirebaseUser(FirebaseUser talent) {
    return talent != null ? Talent(uid: talent.uid) : null;
  }

  Stream<Talent> get talent {
    return _auth.onAuthStateChanged.map(_talentFromFirebaseUser);
  }

//register with emailand password

  Future signUp(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser talent = result.user;
      return _talentFromFirebaseUser(talent);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future createDocumment(
      String age,
      String email,
      String genre,
      String natonalite,
      String nom,
      String password,
      String prenom,
      String tel,
      String photoUrl,
      String videoUrl,
      String description) async {
        
    FirebaseUser user = await _auth.currentUser();
    print(email + password);
    DocumentSnapshot doc = await _authStore.document(user.uid).get();
    if (!doc.exists) {
      try {
        await _authStore.document(user.uid).setData({
          "uid": user.uid,
          "age": age,
          "email": email,
          "genre": genre,
          "nationalite": natonalite,
          "nom": nom,
          "password": password,
          "prenom": prenom,
          "tel": tel,
          "photoUrl": photoUrl,
          "videoUrl": videoUrl,
          "description": description
        });
        doc = await _authStore.document(user.uid).get();
      } catch (e) {
        print(e.toString());
        return null;
      }
    }
  }

  Future signIn(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser talent = result.user;
      return _talentFromFirebaseUser(talent);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
