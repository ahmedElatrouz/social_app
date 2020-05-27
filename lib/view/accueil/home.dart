import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:social_app/model/Professionnel.dart';
import 'package:social_app/model/Talent.dart';
import 'package:social_app/services/professionelService.dart';
import 'package:social_app/services/talentService.dart';
import 'package:social_app/view/accueil/annonce_page.dart';
import 'package:social_app/view/accueil/recherche_page.dart';
import 'package:social_app/view/admin/categories_page.dart';
import 'package:social_app/view/admin/profiles_page.dart';
import 'package:social_app/view/admin/validation_page.dart';
import 'package:social_app/view/profil/pro_profile_page.dart';
import 'package:social_app/view/profil/profil_page.dart';
import 'package:social_app/view/profil/upload_post_page.dart';
import 'package:social_app/view/shared/constants.dart';

import 'ajouter_annonce_page.dart';
import 'actualite_page.dart';
import 'not_validated_page.dart';

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
  bool isWaiting=true;

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
        icon: Icon(Icons.check), title: Text('Valider')),
    BottomNavigationBarItem(
        icon: Icon(Icons.art_track), title: Text('Categories')),
  ];

  Future<void>checkTalent() async {
    talent = await talentService.getCurrentUser();
   
  }

  Future<void>checkPro() async {
    pro = await proService.getCurrentPro();
  }

 
  @override
  void initState() {
    super.initState();
    isWaiting=true;  
   preparePages();
    adminPages=[
      ProfilesPage(validatedProfiles: true,),
      ValidationPage(),
      CategoriesPage(),
    ];
    
    pageController = PageController(
      initialPage: 0,
    );
  }

  preparePages() async{
    
    switch (widget.userType) {
      case UserType.talent:
      await checkTalent();
      talentPages = talent.isValidated==true? [
      ActualitePage(),
      ProfilPage(poster: null,visitor: UserType.talent,),
      UploadPost(
        post: witchPost.newPost,
      ),
      AnnoncePage(),
    ]:[NotValidatedPage(),
    NotValidatedPage(),
    NotValidatedPage(),
    NotValidatedPage()]; 
        break;

      case UserType.professionnel:
      await checkPro();
       proPages = [
      ProProfilPage(),
      AjouterAnnoncePage(),
      RecherchePage(),
    ];
        break;
      case UserType.admin:print('admin');
        break;
    }
   setState(() {
     isWaiting=false;
   }); 
  }

  List getPages(){
    List list=[];
    switch (widget.userType) {
      case UserType.talent:
        list= talentPages;
        break;
      case UserType.professionnel:
        list=proPages;
        break;
      case UserType.admin:
        list=adminPages;
        break;
    }
    return list;
      
  }

  List getNavigationBar(){
    List list=[];
    switch (widget.userType) {
      case UserType.talent:
        list= talentNavigationBar;
        break;
      case UserType.professionnel:
        list=proNavigationBar;
        break;
      case UserType.admin:
        list=adminNavigationBar;
        break;
    }
    return list;
     
  }

  Widget homeContent() {
    return Scaffold(
      body: PageView(
        children: getPages(),
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
          items: getNavigationBar(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(child: homeContent(), inAsyncCall: isWaiting,);
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
