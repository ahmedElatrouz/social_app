import 'package:flutter/material.dart';
import 'package:social_app/model/Annonce.dart';
import 'package:social_app/model/Professionnel.dart';
import 'package:social_app/services/annonceService.dart';
import 'package:social_app/services/professionelService.dart';
import 'package:social_app/view/accueil/display_annonce.dart';
import 'package:social_app/view/shared/progress.dart';
import 'package:social_app/view/shared/reusable_header.dart';

class AnnoncePage extends StatefulWidget {
  @override
  _AnnoncePageState createState() => _AnnoncePageState();
}

class _AnnoncePageState extends State<AnnoncePage> {
  bool isWaiting = false;
  List<Annonce> annonces = [];
  List<DisplayAnnonce> displayAnnonce = [];
  AnnonceService annonceService = AnnonceService();

  @override
  void initState() {
    super.initState();
    if (displayAnnonce.isEmpty) isWaiting = true;
    getAllAnnonces();
  }

  getAllAnnonces() async {
    annonces = await annonceService.allAnnonces();
    print(annonces);
    await listAnnonses();
    setState(() {
      isWaiting = false;
    });
  }

  listAnnonses() async {

    for (Annonce annonce in annonces) {
      Professionnel prof = await ProfessionelService().searchById(annonce.proRef);
        print(prof);

        setState(() {
        displayAnnonce.add(DisplayAnnonce(
          annonce: annonce,
          prof: prof,
        ));
          });
    }
  }


  Widget alternativeScreen() {
    if (isWaiting)
      return circularProgress();
    else
      return Center(
        child: Text("pas de resultats"),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF009688).withOpacity(0.5),
      appBar: header(context, "annonce"),
      body: isWaiting || displayAnnonce.isEmpty
          ? alternativeScreen()
          : ListView(children: displayAnnonce),
    );
  }
}
