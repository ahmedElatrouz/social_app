import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/model/Talent.dart';
import 'package:social_app/services/talentService.dart';
import 'package:social_app/view/shared/progress.dart';

class AddProfileImage extends StatefulWidget {
  @override
  _AddProfileImageState createState() => _AddProfileImageState();
}

class _AddProfileImageState extends State<AddProfileImage> {
  File image;
  bool isUploading = false;
  TalentService talentService = TalentService();
  Talent talent=Talent();

  getTalent()async{
    talent = await talentService.getCurrentUser();
  }

  addImage() async {
    Navigator.pop(context);
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);
      this.image = image;
  }


  Container buildSplashScrean() {
    return Container(
      color: Color(0xFF009688),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          /*SvgPicture.asset(
            'assets/images/upload.svg',
            height: 260,
          ),*/
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              child: Text('Upload post',
                  style: TextStyle(color: Colors.white, fontSize: 20)),
              color: Colors.deepOrange,
              onPressed: () => addImage(),
            ),
          )
        ],
      ),
    );
  }


  clearPost() {
    setState(() {
      image = null;
    });
  }


  handleSubmit() async {

    setState(() {
      isUploading = true;
    });
    if(image != null){
    //await postService.handleSubmitImage(image, captionController , widget.currentTalent.uid);
    await talentService.handleSubmitProfileImage(image, talent.uid);
    }

    setState(() {
      image = null;
      isUploading = false;
    });
  }


  Scaffold buildUploadForm() {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.white70,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: clearPost,
        ),
        title: Text('caption post', style: TextStyle(color: Colors.black)),
        actions: [
          FlatButton(
            child: Text('Post',
                style: TextStyle(
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 20)),
            onPressed: isUploading ? null : () => handleSubmit(),
          )
        ],
      ),

      body: Center(
        child: ListView(
          children: <Widget>[
            isUploading ? linearProgress() : Text(''),
            if (image != null)
              Container(
                height: 300,
                width: MediaQuery.of(context).size.width * 0.8,
                child: Center(
                  child: AspectRatio(
                    aspectRatio: 16 / 16,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 4,
                        ),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: FileImage(image),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return image == null
        ? buildSplashScrean()
        : buildUploadForm();
  }
}
