

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_app/view/accueil/notification_page.dart';
import 'package:social_app/view/accueil/recherche_page.dart';
import 'package:social_app/view/accueil/recommandations_page.dart';
import 'package:social_app/view/profil/profil_page.dart';

import 'actualite_page.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  PageController pageController;
  int pageIndex=0;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController=PageController(
      initialPage: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children:<Widget>[
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
        currentIndex: pageIndex ,
        onTap: onTap,
        activeColor: Colors.deepPurple,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.whatshot)),
          BottomNavigationBarItem(icon: Icon(Icons.notifications_active)),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle)),
          BottomNavigationBarItem(icon: Icon(Icons.search)),
          BottomNavigationBarItem(icon: Icon(Icons.star)),        
          
        ],
                )  ,
                
                    );
                  }
                
                  @override
                  void dispose() {
                    // TODO: implement dispose
                    pageController.dispose();
                    super.dispose();
                  }
                
                  void onPageChanged(int pageIndex) {
                    setState(() {
                      this.pageIndex=pageIndex;
                    });
          }
        
          void onTap(int pageIndex) {
              pageController.jumpToPage(pageIndex);
           }
}