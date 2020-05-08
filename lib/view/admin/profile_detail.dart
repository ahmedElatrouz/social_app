import 'package:flutter/material.dart';
import 'package:social_app/model/Talent.dart';
import 'package:social_app/view/profil/profil_page.dart';

class ProfileDetail extends StatefulWidget {
  final Talent talent;

  const ProfileDetail({Key key, this.talent}) : super(key: key);
  @override
  _ProfileDetailState createState() => _ProfileDetailState();
}

class _ProfileDetailState extends State<ProfileDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:Column(
        children:<Widget>[
          RaisedButton(
            color: Colors.red[400],
            onPressed: ()=>print('supprimer compte'),
            child:Text('supprimer ce compte') ,
            ),
            RaisedButton(
              color: Colors.green[400],
            onPressed: ()=>print('valider compte'),
            child:Text('valider ce compte') ,
            ),
        ]
      ),
    );
  }
}