import 'package:flutter/material.dart';

import 'constants.dart';

AppBar header(){
  return AppBar(
    
      title: Text(
        "socialApp",
        style:kHeaderTextStyle,
      ),
      centerTitle: true,
      backgroundColor: Colors.deepPurple,
  );
}