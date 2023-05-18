import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitwork/Login/SigninPage.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class avatarSelectionPage extends StatefulWidget {
  const avatarSelectionPage({Key? key, required this.userProfile}) : super(key: key);
  final Map<String, dynamic> userProfile;
  @override
  State<avatarSelectionPage> createState() => _avatarSelectionPageState();
}

class _avatarSelectionPageState extends State<avatarSelectionPage> {

  var avatars = [
    "assets/images/Avatars/cat.png",
    "assets/images/Avatars/chicken.png",
    "assets/images/Avatars/dog.png",
    "assets/images/Avatars/giraffe.png",
    "assets/images/Avatars/koala.png",
    "assets/images/Avatars/panda.png",
    "assets/images/Avatars/rabbit.png",
    "assets/images/Avatars/sea-lion.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(5),
        child: GridView.builder(
          itemCount: avatars.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4
          ),
          itemBuilder: (context, index) => Container(
            child: GestureDetector(
              onTap: () {

                Map<String, dynamic> editAvatar = new Map<String, dynamic>();
                editAvatar = widget.userProfile;
                editAvatar['avatar'] = avatars[index];
                // print(avatars[index]);
                FirebaseFirestore.instance
                  .collection('user')
                  .doc(widget.userProfile['email'])
                  .update(editAvatar).then((value) {
                    Navigator.pop(context);
                });

              },
              child: Container(
                child: Image.asset(avatars[index].toString()),
              ),
            ),
          ),
        ),
      )

    );
  }
}
