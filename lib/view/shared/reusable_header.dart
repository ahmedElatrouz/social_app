import 'package:flutter/material.dart';
import 'package:social_app/view/profil/edit_profile_page.dart';

import 'constants.dart';

AppBar header(context, String page,String title) {
  return AppBar(
    elevation: 0.0,
    title: Text(
      title,
      style: kHeaderTextStyle,
    ),

    actions: <Widget>[
      if (page == "profil" || page == 'actualite')
        new IconButton(
            icon: page == "profil" ? Icon(Icons.edit) : Icon(Icons.exit_to_app),
            onPressed: () {
              if (page == "profil")
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EditProfilPage()));
              else {
                Navigator.of(context).pop(null);
              }
            }),
    ],
    leading: new Container(),
    centerTitle: true,
    backgroundColor: Colors.purple[300]// Color(0xFF1D1E33),
  );
}
