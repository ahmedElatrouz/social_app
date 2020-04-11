import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/service/auth.dart';
import 'package:social_app/view/shared/reusable_header.dart';



class ProfilPage extends StatefulWidget {
  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {

  final AuthService _auth= AuthService();

  String name = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context,"profil"),


      body:SingleChildScrollView(
        child: Column(
          children: <Widget>[
            FutureBuilder(
              future: Provider.of(context)._auth.currentUser(),
              builder: (context , snapshot)
             {
                if(snapshot.connectionState == ConnectionState.done){
                  return Text('${snapshot.data}');
                }
                else{
                 return  CircularProgressIndicator();
                }
              }
              )
          ],
        ),
      )
     
    );
  }
}