import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_app/model/Talent.dart';



class AuthService{


final FirebaseAuth  _auth = FirebaseAuth.instance;
final Firestore _authStore = Firestore.instance;



Talent _talentFromFirebaseUser(FirebaseUser talent){
  return talent != null ? Talent(uid: talent.uid) : null;
}


Stream<Talent> get talent{
  return _auth.onAuthStateChanged.map(_talentFromFirebaseUser);
}

//register with emailand password

Future signUp(String email,String password) async{
  try{
    AuthResult result=await _auth.createUserWithEmailAndPassword(email: email, password: password);
    FirebaseUser talent = result.user;
    return _talentFromFirebaseUser(talent);
  }
  catch(e){
    print(e.toString());
    return null;
  }
}


Future createCollection(String age, String email,String genre,String natonalite,String nom,
String password,String prenom,String tel) async{ 

FirebaseUser user = await _auth.currentUser();

  try{

await _authStore.collection("Talents").document(user.uid).setData({
  "uid" : user.uid,
  "age" : age,
  "email" : email,
  "genre" : genre,
  "nationalite" : natonalite,
  "nom" : nom,
  "password" : password,
  "prenom" : prenom,
  "tel" : tel,
});

  }
  catch(e){
    print(e.toString());
    return null;
  }
}


Future signIn(String email,String password) async{
  try{
    AuthResult result=await _auth.signInWithEmailAndPassword(email: email, password: password);
    FirebaseUser talent = result.user;
    return _talentFromFirebaseUser(talent);
  }
  catch(e){
    print(e.toString());
    return null;
  }
}

Future signOut() async{
try{
  return await _auth.signOut();
}
catch(e){
  print(e.toString());
  return null;
}
}

}