
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/model/Talent.dart';
import 'package:social_app/service/auth.dart';
import 'package:social_app/view/accueil/actualite_page.dart';
import 'package:social_app/view/authenticate/authenticate.dart';
import 'package:social_app/view/authenticate/login_page.dart';
import 'package:social_app/view/authenticate/register_page.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Talent>.value(
      value: AuthService().talent,
      child: MaterialApp(
        initialRoute: Authenticate.id,
        routes: {
          Authenticate.id : (context) => Authenticate(),
          LoginPage.id : (context) => LoginPage(),
          Register.id : (context) => Register(),
          //ActualitePage.id : (context) => ActualitePage(),
       },
      ),
      );
  }
}   