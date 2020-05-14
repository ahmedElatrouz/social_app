import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:social_app/model/Talent.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:social_app/services/talentService.dart';
import 'package:social_app/view/profil/other_profile.dart';
import 'package:social_app/view/profil/profil_page.dart';
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



  TalentService talentService=TalentService();
  AppBar rechercheTextWidget() {
    return AppBar(
      backgroundColor:Colors.white,
      //actions: <Widget>[null],// Colors.white,
      automaticallyImplyLeading: false,
      title: TextFormField(
        scrollPadding: EdgeInsets.all(0),
        controller: searchController,
        decoration: InputDecoration(
          focusColor: Colors.grey,
          hoverColor: Colors.grey,
          border: InputBorder.none,
          disabledBorder: InputBorder.none,
          fillColor: Color(0xFFFFFFFF),
          labelStyle: TextStyle(color:Colors.black),
          hintText: 'Search for a user..',
          filled: true,
          prefixIcon: Icon(Icons.account_box,color: Colors.blueGrey,),
          suffixIcon: IconButton(
              icon: Icon(Icons.clear,color: Colors.blueGrey,),
              onPressed: () {
                clearSearch();
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
    List<Talent> talents = await TalentService().searchByName(value);
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
              color: Colors.black,
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
      backgroundColor: Colors.grey[200],
      appBar: rechercheTextWidget(),
      body:isNoContentWidget() ? noContentWidget() : existContentWidget(),
    );
  }


  bool isNoContentWidget(){
    if(isWaiting==true) return false;
    if(rechercheResult.isEmpty) return true;
     return false;
  }

  Container existContentWidget() {
    if(isWaiting==true)
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

  goToProfile(context){
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProfilPage(
                  poster: user,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(3),
      decoration: BoxDecoration(
        
      color: Colors.white,
        borderRadius:
                                BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children:<Widget>[
          GestureDetector(
              onTap:()=> goToProfile(context),
              child: ListTile(
                leading:CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage:user.photo!=null && user.photo.isNotEmpty?CachedNetworkImageProvider(user.photo):AssetImage('assets/images/ahmed.jpg') ,
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        user.nom + ' ' + user.prenom,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),),
                    ],
                  ),
                    subtitle: 
                      Text('musician'),
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
