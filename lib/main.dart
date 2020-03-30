
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/model/Talent.dart';
import 'package:social_app/service/auth.dart';
import 'package:social_app/view/wrapper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Talent>.value(
      value: AuthService().talent,
      child: MaterialApp(
        home: Wrapper(),
      ),
      );
  }
}   