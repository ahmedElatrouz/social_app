import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_app/model/Talent.dart';
//import 'package:social_app/model/Utilisateur.dart';
import 'package:social_app/service/talentDao.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:social_app/view/shared/progress.dart';
class RecherchePage extends StatefulWidget {
  @override
  _RecherchePageState createState() => _RecherchePageState();
}

class _RecherchePageState extends State<RecherchePage> {
  TextEditingController searchController = TextEditingController();

  List<ResultWidget> rechercheResult = [];
  bool isWaiting=false;
  bool noResult=false;

  AppBar rechercheTextWidget() {
    return AppBar(
      backgroundColor: Colors.white,
      title: TextFormField(
        controller: searchController,
        decoration: InputDecoration(
          hintText: 'Search for a user..',
          filled: true,
          prefixIcon: Icon(Icons.account_box),
          suffixIcon: IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                clearSearch();
                //TODO:clear the textField
              }),
        ),
        onFieldSubmitted: (value) {
          setState(() {
            isWaiting=true;
          });
          createList(value);
        },
      ),
    );
  }

  clearSearch() {
    searchController.clear();
  }

  createList(String value) async {
    List<Talent> talents = await TalentDao().searchByName(value);
    List<ResultWidget> list = [];
    for (Talent t in talents) {
      list.add(ResultWidget(user: t,));
    }
    setState(() {
      rechercheResult = list;
      
      isWaiting=false;
      if(rechercheResult.isEmpty) noResult=true;
      
    });
  }

  Container noContentWidget() {
    final Orientation orientation = MediaQuery.of(context).orientation;
    return Container(
      child: Center(
        child: ListView(shrinkWrap: true, children: <Widget>[
          SvgPicture.asset(
            'assets/images/search.svg',
            height: orientation == Orientation.portrait ? 300.0 : 100.0,
          ),
          Text(
            noResult?"Talent non trouvé"  :  "Recherche",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w600,
              fontSize: orientation == Orientation.portrait ? 50.0 : 40.0,
            ),
          )
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: rechercheTextWidget(),
      body: rechercheResult.isEmpty ? noContentWidget() : existContentWidget(),
    );
  }

  Container existContentWidget() {
    if(isWaiting)
    return circularProgress();
    else return Container(
      child: ListView(
        children: rechercheResult,
      ),
    );
  }
}






class ResultWidget extends StatelessWidget {

  final Talent user;

  const ResultWidget({ this.user});


  @override
  Widget build(BuildContext context) {
    return Container(
      
      color: Colors.deepPurple.withOpacity(0.7),
      child: Column(
        children:<Widget>[
          GestureDetector(
              onTap:()=> print("go to this profil"),
              child: ListTile(
                leading:CircleAvatar(
                  backgroundColor: Colors.grey,
                  backgroundImage:user.photo!=null?CachedNetworkImageProvider(user.photo):AssetImage('assets/images/ahmed.jpg') ,
                  ),
                  title: Text(
                    user.nom,
                    style: TextStyle(
                      color:Colors.white,
                      fontWeight: FontWeight.bold,
                    ),),
                    subtitle: Text(user.nom+" "+user.prenom,
                    style:TextStyle(color:Colors.white), ),
              ),
          ),
          Divider(
            height: 2.0,
            color: Colors.white54,
          ),
        ]
      ),
    );
  }
}
