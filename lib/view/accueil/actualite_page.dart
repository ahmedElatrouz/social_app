import 'package:flutter/material.dart';
import 'package:social_app/model/Post.dart';
import 'package:social_app/model/Talent.dart';
import 'package:social_app/services/postService.dart';
import 'package:social_app/services/talentService.dart';
import 'package:social_app/view/profil/post_widget.dart';
import 'package:social_app/view/shared/progress.dart';
import 'package:social_app/view/shared/reusable_header.dart';


class ActualitePage extends StatefulWidget {
  static const String id = 'actualite_page';
  @override
  _ActualitePageState createState() => _ActualitePageState();
}

class _ActualitePageState extends State<ActualitePage> {
  bool isWaiting = false;
  Talent talent;
  List<Post> usersPosts = [];
  List<PostWidget> postWidgets = [];
  PostService postService = PostService();
  @override
  void initState() {
    super.initState();
    if(postWidgets.isEmpty)
     isWaiting = true;
    getUserAndPosts();
  }

  getUserAndPosts() async {
    talent = await TalentService().getCurrentUser();
    usersPosts = await postService.getallPosts();
    if (usersPosts.isEmpty) print('noooo postsss');
    await generateList();
    setState(() {
      isWaiting = false;
    });
  }

  generateList() async { 
    for (Post post in usersPosts) {
       Talent poster=await TalentService().searchById(post.talentId);

      setState(() {
        postWidgets.add(PostWidget(
          post: post,
          talent: talent,
          poster: poster,
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
        appBar: header(context, "actualite"),
        backgroundColor: Color(0xFF009688).withOpacity(0.5),
        body:isWaiting|| postWidgets.isEmpty
            ? alternativeScreen()
            : ListView(children: postWidgets
                ));
  }
}














/*class PostWidget extends StatelessWidget {
  final Post post;
  final Talent poster;

  PostWidget({
    @required this.post,
    @required this.poster,
    @required this.context,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(5),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 1),
      decoration: BoxDecoration(
        color: Colors.grey[100], //Color(0xFFF0F0F0),
        border: Border.all(color: Colors.blueGrey, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: InkWell(
          child: Column(
            children: <Widget>[
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage(
                    "assets/images/3.jpg",
                  ),
                ),
                contentPadding: EdgeInsets.all(0),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      poster.nom +' '+ poster.prenom,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black,
                          fontSize: 18),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      post.description,
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        color: Colors.black87,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                foregroundDecoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: post.photoUrl != null
                    ? Image.network(post.photoUrl)
                    : Image.asset(
                        'assets/images/ahmed.jpg',
                        height: 170,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      ),
              ),
              
            ],
          ),
          onTap: () {},
        ),
      ),
    );
  }
}
*/