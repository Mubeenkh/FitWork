import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitwork/Login/SigninPage.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class avatarSelectionPage extends StatefulWidget {
  const avatarSelectionPage({Key? key}) : super(key: key);

  @override
  State<avatarSelectionPage> createState() => _avatarSelectionPageState();
}

class _avatarSelectionPageState extends State<avatarSelectionPage> {
  var avatars = [
    "assets/images/Avatars/bear.png",
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
    return GridView.builder(
      itemCount: avatars.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.6,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4
      ),
      itemBuilder: (context, index) => Container(
        child: GestureDetector(
          onTap: () {
            
          },
          child: Container(
            child: Image.asset(avatars[index].toString()),
          ),
        ),
      ),
    );
  }
}
