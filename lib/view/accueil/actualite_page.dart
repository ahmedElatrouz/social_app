import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_app/service/auth.dart';
import 'package:social_app/view/shared/reusable_header.dart';



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
    return  //Center(child: Text("actualite"));
    
     Scaffold(
      appBar:header(context), /*AppBar(
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
      ),*/
      body: Container(
        child: Center(
          child: Text(
            'actualite',
            style: TextStyle(
              fontSize:20,
          ),
          ),
        ),
      ),
    );
  }
}
