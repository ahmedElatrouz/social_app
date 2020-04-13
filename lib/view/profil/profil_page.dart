import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_app/repository/auth.dart';
import 'package:social_app/view/shared/reusable_header.dart';



class ProfilPage extends StatefulWidget {
  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  final AuthService _auth = AuthService();
  FirebaseUser loggedInUser;
  final FirebaseAuth user = FirebaseAuth.instance;
  final userRef = Firestore.instance.collection('Talents');
  String name = '';
  String prenom = '';
  String email = '';
  String nationalite = '';
  String uid = '';

 getCurrentUser() async {
    try {
      final usr = await user.currentUser();
      if (usr != null) loggedInUser = usr;
      uid = loggedInUser.uid;
      print(uid);
    } catch (e) {
      print(e);
    }
  }

  
 infoStream() async {

   /*final QuerySnapshot snapshot = await userRef
   .where("email", isEqualTo: email).getDocuments();

   snapshot.documents.forEach((DocumentSnapshot doc){
      
      name = doc.data['nom'];
      prenom = doc.data['prenom'];
      email = doc.data['email'];
      nationalite = doc.data['nationalite'];
      print(name);
      print(prenom);
      print(email);
   });*/
   userRef.snapshots();
    await for (var snapshot in userRef.snapshots()) {
      for (var info in snapshot.documents) {
        final currentUser = loggedInUser.email;

        if (currentUser == info.data['email']) {
          name = info.data['nom'];
          prenom = info.data['prenom'];
          email = info.data['email'];
          nationalite = info.data['nationalite'];
          print(name);
          print(prenom);
          print(email);
        }
      }
    }
  }

  @override
  void initState() {
    getCurrentUser();
    infoStream();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: header(context, "profil"),
        body: ListView(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Color(0xFF009688),
                
                borderRadius: new BorderRadius.only(
                    bottomLeft:  const  Radius.circular(60.0),
                    bottomRight: const  Radius.circular(60.0))
              ),
              
              child: Column(children: <Widget>[
                SizedBox(
                  height: 3,
                ),
                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/3.jpg'),
                  
                  radius: 60,
                ),
                SizedBox(
                  height: 8,
                ),
                Text('$name $prenom',
                    style:
                        TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
                Text('$email, $nationalite',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black38)),
                Text('Category',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black45)),
                SizedBox(
                  height: 8,
                )
                
              ]),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  onPressed: null,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text('new post',style: TextStyle(fontSize: 25),),
                  ),
                  )
              ],
            ),

            Text(
              'Posts',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,),
            ),
            Container(
              child: Wrap(
                children: <Widget>[
                  for (int i = 0; i < 10; i++)
                    Container(
                      height: MediaQuery.of(context).size.width / 3,
                      width: MediaQuery.of(context).size.width / 3,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage('assets/images/3.jpg'),
                        fit: BoxFit.cover,
                      )),
                    )
                ],
              ),
            )
          ],
        ));
  }
}
