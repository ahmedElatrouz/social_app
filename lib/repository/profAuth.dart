import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_app/model/Professionnel.dart';

class ProfAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _authStore = Firestore.instance.collection("Professionnels");

  Future currentUser() async{
    return await _auth.currentUser();
  }

  Professionnel _professionnelFromFirebaseUser(FirebaseUser prof) {
    return prof != null ? Professionnel(proID: prof.uid) : null;
  }

  Stream<Professionnel> get professionnel {
    return _auth.onAuthStateChanged.map(_professionnelFromFirebaseUser);
  }

//register with emailand password

  Future signUp(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser prof = result.user;
      return _professionnelFromFirebaseUser(prof);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future createDocument(
      String age,
      String email,
      String genre,
      String natonalite,
      String nom,
      String password,
      String prenom,
      String tel) async 
      {
    FirebaseUser user = await _auth.currentUser();
    print(email + password);

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
      });
    } catch (e) {
      print(e.toString());
      return null;
    }
    return 1;
  }

  Future signIn(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser prof = result.user;
      return _professionnelFromFirebaseUser(prof);
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
