import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_app/view/accueil/annonce_page.dart';
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
  
  PageController pageController;
  int pageIndex = 0;
  bool isContentLoaded=false;

  @override
  void initState() {
    super.initState();
    pageController = PageController(
      initialPage: 0,
    );
    

    
  }
 

 Widget homeContent(){
    return Scaffold(
      body: PageView(
            children: <Widget>[
              ActualitePage(),
             // NotificationPage(),
              ProfilPage(),
              AnnoncePage(),
              //RecherchePage(),
              //RecommandationsPage(),
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
                icon: Icon(Icons.account_circle), title: Text('Profile')),
            BottomNavigationBarItem(
                icon: Icon(Icons.work), title: Text('Annonces')),
            //BottomNavigationBarItem(icon: Icon(Icons.star),title: Text('Recommandation')),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return  homeContent();
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
