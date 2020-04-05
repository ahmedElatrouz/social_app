import 'package:flutter/material.dart';
import 'package:social_app/view/profil/edit_profile_page.dart';

import 'constants.dart';

AppBar header(context,String page){
  return AppBar(
    
      title: Text(
        "socialApp",
        style:kHeaderTextStyle,
      ),
      
      actions: <Widget>[
           new IconButton(
             icon: page=="profil"? Icon(Icons.edit):Icon(Icons.exit_to_app),
            onPressed: () {
              
              
              if(page=="profil") Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProfilPage()));
              else{
                //TODO: logOut here
              Navigator.of(context).pop(null);
              }
            } 
           ),
         ],
        leading: new Container(),
      centerTitle: true,
      backgroundColor: Color(0xFF1D1E33),
  );
}