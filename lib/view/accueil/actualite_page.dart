import 'package:flutter/material.dart';
import 'package:social_app/service/auth.dart';


class ActualitePage extends StatefulWidget {
  @override
  _ActualitePageState createState() => _ActualitePageState();
}

class _ActualitePageState extends State<ActualitePage> {

final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SocialApp2'),
        actions: <Widget>[
          FlatButton.icon(
            onPressed: (){
            _auth.signOut();
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
