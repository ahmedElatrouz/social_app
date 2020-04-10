import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_app/model/Talent.dart';
import 'package:social_app/service/talentDao.dart';

class RecherchePage extends StatefulWidget {
  @override
  _RecherchePageState createState() => _RecherchePageState();
}

class _RecherchePageState extends State<RecherchePage> {


List<Text> talentsNames=[];
  AppBar rechercheTextWidget() {
    return AppBar(
      backgroundColor: Colors.white,
      title: TextFormField(
        decoration: InputDecoration(
          hintText: 'Search for a user..',
          filled: true,
          prefixIcon: Icon(Icons.account_box),
          suffixIcon: IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                
                //TODO:clear the textField
              }),
        ),
        onFieldSubmitted:(value){
                  createList(value);
                

        } ,
      ),
    );
  }


  createList(String value)async{
      
                     List<Talent>  talents=await TalentDao().searchByName(value);

                       List<Text> list=[];
                        for(Talent t in talents){
                          list.add( Text(t.nom));
                        }
                        setState(() {
                          talentsNames=list;
                          
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
            "Recherche",
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
      body:talentsNames.isEmpty? noContentWidget():existContentWidget(),
          );
        }
      



        Container existContentWidget() {
            return Container(
                child: ListView(
                  children:talentsNames,
                ),
            );


        }
}
