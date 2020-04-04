import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_app/service/auth.dart';



class ActualitePage extends StatefulWidget {

  static const String id = 'actualite_page';
  @override
  _ActualitePageState createState() => _ActualitePageState();
}

class _ActualitePageState extends State<ActualitePage> {

final AuthService _auth = AuthService();
FirebaseUser loggedInUser;

@override
  void initState() {
    getCurrentUser();
    super.initState();
  }

void getCurrentUser() async{
  try{
  final user = await _auth.currentUser();
  if(user != null){
    print(user.email);
  }
  }catch(e){
    print(e);
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SocialApp2'),
        actions: <Widget>[
          FlatButton.icon(
            onPressed: (){
            _auth.signOut();
            Navigator.pop(context);
            },
             icon: Icon(Icons.person),
             label: Text('logOut'))
        ],
      ),
      body: Container(
        child: Text(
          'Helloooo',
          style: TextStyle(
            fontSize:50,
        ),
        ),
      ),
    );
  }
}
