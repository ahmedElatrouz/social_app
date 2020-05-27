import 'package:flutter/material.dart';
import 'package:social_app/view/admin/profiles_page.dart';

class ValidationPage extends StatefulWidget {
  @override
  _ValidationPageState createState() => _ValidationPageState();
}

class _ValidationPageState extends State<ValidationPage> {
  @override
  Widget build(BuildContext context) {
    return ProfilesPage(validatedProfiles: false,);
  }
}