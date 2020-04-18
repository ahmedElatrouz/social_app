import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/model/Talent.dart';
import 'package:social_app/repository/talentAuth.dart';
import 'package:social_app/view/accueil/notification_page.dart';
import 'package:social_app/view/accueil/recherche_page.dart';
import 'package:social_app/view/accueil/recommandations_page.dart';
import 'package:social_app/view/profil/profil_page.dart';

import 'actualite_page.dart';

class Home extends StatefulWidget {
  static const String id = 'home';

  /*  Home({
    this.talent,
  }) ;*/
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController pageController;
  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(
      initialPage: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Provider<Talent>(
      //TODO:remplacer l'objet talent par talentService.getCurrentUser() qui retourne un talent et pas une list
      create: (context)=>Talent(nom: 'bahmdan',prenom: 'elatrouz',email: 'ahmed@email.com',nationalite: 'moroccan'),
      child: Scaffold(
        body: PageView(
          children: <Widget>[
            ActualitePage(),
            NotificationPage(),
            ProfilPage(),
            RecherchePage(),
            RecommandationsPage(),
          ],
          controller: pageController,
          onPageChanged: onPageChanged,
          physics: NeverScrollableScrollPhysics(),
        ),
        bottomNavigationBar: Container(
          height: 50.0,
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: true,
            iconSize: 18.0,
            currentIndex: pageIndex,
            onTap: onTap,
            unselectedItemColor: Colors.black,
            selectedItemColor: Colors.lightBlueAccent,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), title: Text('Accueil')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.notifications_active),
                  title: Text('Notifications')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle), title: Text('Profile')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), title: Text('Recherche')),
              //BottomNavigationBarItem(icon: Icon(Icons.star),title: Text('Recommandation')),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void onPageChanged(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  void onTap(int pageIndex) {
    pageController.jumpToPage(
      pageIndex,
    );
  }
}
