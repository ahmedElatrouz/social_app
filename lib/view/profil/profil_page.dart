import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_app/service/auth.dart';
import 'package:social_app/view/shared/reusable_header.dart';

class ProfilPage extends StatefulWidget {
  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  final AuthService _auth = AuthService();
  final Firestore _firestore = Firestore.instance;
  FirebaseUser loggedInUser;
  final FirebaseAuth user = FirebaseAuth.instance;

  void getCurrentUser() async {
    try {
      final usr = await user.currentUser();
      if (usr != null) loggedInUser = usr;
    } catch (e) {
      print(e);
    }
  }

  String name = '';
  String prenom = '';
  String email = '';
  String nationalite = '';

  void infoStream() async {
    _firestore.collection('Talents').snapshots();
    await for (var snapshot in _firestore.collection('Talents').snapshots()) {
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

              color: Color(0xFF009688),
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
                SizedBox(
                  height: 20,
                )
                
              ]),
            ),
            SizedBox(
              height: 80,
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
