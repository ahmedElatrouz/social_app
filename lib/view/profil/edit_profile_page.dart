

import 'package:flutter/material.dart';
import 'package:social_app/view/accueil/notification_page.dart';
import 'package:social_app/view/accueil/recommandations_page.dart';
import 'package:social_app/view/shared/constants.dart';


  enum settings{
    editEmail,editTel,editPassword,accesPrive
  }
  enum pages{
    compte,confidentialite
  }








class EditProfilPage extends StatefulWidget {
  @override
  _EditProfilPageState createState() => _EditProfilPageState();
}


class _EditProfilPageState extends State<EditProfilPage> {


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
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Preferences",
            style: TextStyle(fontSize: 24.0),
          ),
        ),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                color: Colors.grey[100],
                child: BottomNavigationBar(
                  currentIndex: pageIndex,
                  onTap: onTap,
                  elevation: 50.0,
                  type: BottomNavigationBarType.fixed,
                  items: [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.person), title: Text('COMPTE')),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.lock),
                        title: Text('CONFIDENTIALITE')),
                   
                  ],
                ),
              ),
             Expanded(
                            child: Scaffold(
                 body:PageView(
                  children: <Widget>[
                    EditPageCore(page: pages.compte),
                     EditPageCore(page: pages.confidentialite),
                  
                  ],
                  controller: pageController,
                   onPageChanged: onPageChanged,
                   physics: NeverScrollableScrollPhysics(),
                )
               ),
             ) 
              
               
            ]));
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

   @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }


}


List<EditElements> compteList=[
              EditElements(settings.editEmail),
              EditElements(settings.editTel),
              EditElements(settings.editPassword),];

List<EditElements> confidentialiteList=[
              EditElements(settings.accesPrive),];


class EditPageCore extends StatelessWidget {
  final pages page;

  const EditPageCore({@required this.page});
  @override
  Widget build(BuildContext context) {
    return Container(
      child:Column(
        children:page==pages.compte?compteList:confidentialiteList,        
        
      ) ,
    );
  }
}








class EditElements extends StatelessWidget {

  final settings setting;

   EditElements(this.setting);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color:Colors.white,
        border: Border.all(color:Colors.grey),
      ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
        children:<Widget>[
          GestureDetector(
              onTap:()=> print("go to this setting"),
              child: ListTile(
                  title: Text(
                    kEditElementsText[setting][0],
                    style: TextStyle(
                      color:Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 18.0
                    ),),
                    subtitle: Text(kEditElementsText[setting][1],
                    style:TextStyle(color:Colors.grey), ),
              ),
          ),
         
        ]
      ),
    );
  }
}

