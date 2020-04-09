import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';



class RecherchePage extends StatefulWidget {
  @override
  _RecherchePageState createState() => _RecherchePageState();
}

class _RecherchePageState extends State<RecherchePage> {





  AppBar rechercheTextWidget() {

    return AppBar(
        backgroundColor: Colors.white,
        title: TextFormField(
          decoration:InputDecoration(
            hintText: 'Search for a user..',
            filled: true,
            prefixIcon: Icon(
              Icons.account_box
            ),
            suffixIcon: IconButton(
              icon: Icon(Icons.clear), 
              onPressed: (){

              }
              ),
            ),
        ),
        
  );
    
  }


  Container noContentWidget(){
      return Container(
          child: Center(
              child:ListView(
                shrinkWrap: true,
                children:<Widget>[
                    SvgPicture.asset('assets/images/search.svg',height: 300.0,),
                    Text(
                      "Find Users",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color:Colors.white ,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w600,
                        fontSize: 60.0
                      ),
                      )
                ]
              ),
            ),
        
      );
  }














  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.deepPurple ,
      appBar: rechercheTextWidget(),
            body:   noContentWidget(),
            
          );
        }
      
        
}