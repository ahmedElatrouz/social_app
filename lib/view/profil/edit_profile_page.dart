import 'package:flutter/material.dart';
import 'package:social_app/model/Talent.dart';
import 'package:social_app/services/talentService.dart';
import 'package:social_app/view/profil/settingPage.dart';
import 'package:social_app/view/shared/constants.dart';

enum pages { compte, confidentialite }

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
                        icon: Icon(Icons.lock), title: Text('CONFIDENTIALITE')),
                  ],
                ),
              ),
              Expanded(
                child: Scaffold(
                    body: PageView(
                  children: <Widget>[
                    EditPageCore(page: pages.compte),
                    EditPageCore(page: pages.confidentialite),
                  ],
                  controller: pageController,
                  onPageChanged: onPageChanged,
                  physics: NeverScrollableScrollPhysics(),
                )),
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

List<EditElements> compteList = [
  EditElements(setting: settings.editProfil),
  EditElements(setting: settings.editEmail),
  EditElements(setting: settings.editTel),
  EditElements(setting: settings.editPassword),
];

List<EditElements> confidentialiteList = [
  EditElements(setting: settings.accesPrive),
];

class EditPageCore extends StatelessWidget {
  final pages page;

  const EditPageCore({@required this.page});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: page == pages.compte ? compteList : confidentialiteList,
      ),
    );
  }
}

class EditElements extends StatelessWidget {
  final settings setting;

  EditElements({@required this.setting});

  TalentService talentService;
  Talent talent;

  getUser(context) async {
    talentService = TalentService();
    talent = await talentService.getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    getUser(context);
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
      ),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SettingPage(
                          talent: talent,
                          setting:
                              setting))), //TODO:Navigator.pushNamed(context, settingPage),
              child: ListTile(
                title: Text(
                  kEditElementsText[setting][0],
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 18.0),
                ),
                subtitle: Text(
                  kEditElementsText[setting][1],
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ]),
    );
  }
}
