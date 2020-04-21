
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/model/Talent.dart';
import 'package:social_app/repository/talentAuth.dart';
import 'package:social_app/services/talentService.dart';
import 'package:social_app/view/accueil/actualite_page.dart';
import 'package:social_app/view/accueil/home.dart';
import 'package:social_app/view/authenticate/authenticate.dart';
import 'package:social_app/view/authenticate/login_page.dart';
import 'package:social_app/view/authenticate/register_page.dart';
import 'package:get_it/get_it.dart';

//GetIt getIt = GetIt.instance;

void main() {
//getIt.registerSingleton<TalentService>(TalentService(),
  //    signalsReady: true);
runApp(MyApp());
} 

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute:Authenticate.id,
      routes: {
        Authenticate.id : (context) => Authenticate(),
        LoginPage.id : (context) => LoginPage(),
        Register.id : (context) => Register(),
        ActualitePage.id : (context) => ActualitePage(),
        Home.id :(context)=>Home()
      
     },
    );
  }
}   