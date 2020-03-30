import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/model/Talent.dart';
import 'package:social_app/view/accueil/actualite_page.dart';
import 'package:social_app/view/authenticate/authenticate.dart';



class Wrapper extends StatelessWidget {

  

  @override
  Widget build(BuildContext context) {
    final talent =Provider.of<Talent>(context);
    if(talent == null ){
      return Authenticate();
    }
    else{
      return ActualitePage();
    }

    
  }
}