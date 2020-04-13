import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_app/repository/talentAuth.dart';
import 'package:social_app/view/accueil/notification_page.dart';
import 'package:social_app/view/accueil/recherche_page.dart';
import 'package:social_app/view/accueil/recommandations_page.dart';
import 'package:social_app/view/profil/profil_page.dart';

import 'actualite_page.dart';

class Home extends StatefulWidget {

  static const String id = 'home';
  @override
  _HomeState createState() => _HomeState();
}



class _HomeState extends State<Home> {

 
  final TalentAuthService _auth = TalentAuthService();
  final Firestore _authStore = Firestore.instance;

  bool getUserDocument(String collection) {
    if( _authStore.collection(collection)
                        == _authStore.collection('Talents')){
      return true;
    }
    else return false;
    
  }

  Future currentUser() async{
    FirebaseUser user= await _auth.currentUser();
    print(user.email);
  }



  PageController pageController;
  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
     currentUser();
    pageController = PageController(
      initialPage: 0,
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: pageIndex,
        onTap: onTap,
        activeColor: Colors.deepPurple,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.whatshot)),
          BottomNavigationBarItem(icon: Icon(Icons.notifications_active)),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle)),
          BottomNavigationBarItem(icon: Icon(Icons.search)),
          BottomNavigationBarItem(icon: Icon(Icons.star)),
        ],
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
    pageController.animateToPage(
      pageIndex,
      duration: Duration(milliseconds:200), 
      curve: Curves.easeIn
      );
  }
}
