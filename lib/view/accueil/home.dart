

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/model/Talent.dart';
import 'package:social_app/services/talentService.dart';

import 'package:social_app/view/accueil/notification_page.dart';
import 'package:social_app/view/accueil/recherche_page.dart';
import 'package:social_app/view/accueil/recommandations_page.dart';
import 'package:social_app/view/profil/profil_page.dart';
import 'package:social_app/view/shared/progress.dart';

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
  bool isContentLoaded=false;
  Talent talent=new Talent(nom:'NaN',email:'NaN');
TalentService talentService;

  @override
  void initState() {
    super.initState();
    pageController = PageController(
      initialPage: 0,
    );
    

    
  }
 

 Widget homeContent(){
    return Scaffold(
      body: Provider<Talent>(
            create: (context)=>talent,
              child: PageView(
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
