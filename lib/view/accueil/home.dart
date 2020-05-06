import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_app/model/Professionnel.dart';
import 'package:social_app/model/Talent.dart';
import 'package:social_app/services/professionelService.dart';
import 'package:social_app/services/talentService.dart';
import 'package:social_app/view/accueil/annonce_page.dart';
import 'package:social_app/view/accueil/recherche_page.dart';
import 'package:social_app/view/admin/categories_page.dart';
import 'package:social_app/view/admin/profiles_page.dart';
import 'package:social_app/view/profil/pro_profile_page.dart';
import 'package:social_app/view/profil/profil_page.dart';
import 'package:social_app/view/profil/upload_post_page.dart';
import 'package:social_app/view/shared/constants.dart';

import 'ajouter_annonce_page.dart';
import 'actualite_page.dart';

class Home extends StatefulWidget {
  static const String id = 'home';
  final UserType userType;
  
  const Home({ this.userType});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController pageController;
  int pageIndex = 0;
  bool isContentLoaded = false;
  Talent talent = Talent();
  Professionnel pro = Professionnel();
  TalentService talentService = TalentService();
  ProfessionelService proService = ProfessionelService();
  List<Widget> talentPages = [];
  List<Widget> proPages = [];
  List<Widget> adminPages = [];

  List<BottomNavigationBarItem> talentNavigationBar = [
    BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Accueil')),
    BottomNavigationBarItem(
        icon: Icon(Icons.account_circle), title: Text('Profile')),
    BottomNavigationBarItem(
        icon: Icon(Icons.add_photo_alternate), title: Text('Post')),
    BottomNavigationBarItem(icon: Icon(Icons.work), title: Text('Annonces')),
  ];

 List<BottomNavigationBarItem> proNavigationBar = [
    BottomNavigationBarItem(
        icon: Icon(Icons.account_circle), title: Text('Profile')),
    BottomNavigationBarItem(
        icon: Icon(Icons.add_box), title: Text('Publier Annonce')),
    BottomNavigationBarItem(icon: Icon(Icons.search), title: Text('Recherche')),
  ];

List<BottomNavigationBarItem> adminNavigationBar = [
    BottomNavigationBarItem(
        icon: Icon(Icons.person_add), title: Text('Profiles')),
    BottomNavigationBarItem(
        icon: Icon(Icons.art_track), title: Text('Categories')),
  ];
  checkTalent() async {
    talent = await talentService.getCurrentUser();
   
  }

  checkPro() async {
    pro = await proService.getCurrentPro();
  }

 
  @override
  void initState() {
    super.initState();
    widget.userType == UserType.talent ? checkTalent() : checkPro();
    talentPages = [
      ActualitePage(),
      ProfilPage(),
      UploadPost(
        post: witchPost.newPost,
      ),
      AnnoncePage(),
    ]; 

    proPages = [
      ProProfilPage(),
      AjouterAnnoncePage(),
      RecherchePage(),
    ];
    adminPages=[
      ProfilesPage(),
      CategoriesPage()
    ];
    
    pageController = PageController(
      initialPage: 0,
    );
  }

  Widget homeContent() {
    return Scaffold(
      body: PageView(
        children: widget.userType == UserType.talent ? talentPages : proPages,
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
          items:  widget.userType == UserType.talent
              ? talentNavigationBar
              : proNavigationBar,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return homeContent();
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
