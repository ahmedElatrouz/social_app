import 'package:flutter/material.dart';

import 'constants.dart';

AppBar header(context){
  return AppBar(
    
      title: Text(
        "socialApp",
        style:kHeaderTextStyle,
      ),
      actions: <Widget>[
           new IconButton(
             icon: new Icon(Icons.exit_to_app),
            onPressed: () {
              //TODO: logOut here
              Navigator.of(context).pop(null);
              
            } 
           ),
         ],
        leading: new Container(),
      centerTitle: true,
      backgroundColor: Colors.deepPurple,
  );
}