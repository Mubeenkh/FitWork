import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitwork/Login/SigninPage.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

///-------------------------------------Profile Page -------------------------------------///
class Profile extends StatefulWidget {
  const Profile({Key? key, required this.userInfo}) : super(key: key);
  final Map<String, dynamic> userInfo;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final double coverHeight = 150;
  final double avatarHeight = 144;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        buildTop(),
        buildContent(),
      ],
    );
  }

  Widget buildTop() {
    final bottom = avatarHeight / 2;
    final top = coverHeight - avatarHeight / 2;
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: bottom),
          child: buildCoverImage(),
        ),
        Positioned(
          top: top,
          child: buildAvatarImage(),
        ),
      ],
    );
  }

  Widget buildCoverImage() =>
      Container(
        color: Colors.grey,
        child: Image.network(
          "https://media.istockphoto.com/id/1322158059/photo/dumbbell-water-bottle-towel-on-the-bench-in-the-gym.jpg?s=612x612&w=0&k=20&c=CIdh6LPGwU6U6lbvKCdd7LcppidaYwcDawXJI-b0yGE=",
          width: double.infinity,
          height: coverHeight,
          fit: BoxFit.cover,
        ),
      );

  Widget buildAvatarImage() =>
      CircleAvatar(
        radius: avatarHeight / 2,
        backgroundColor: Colors.white,
        backgroundImage: NetworkImage(
            "https://em-content.zobj.net/thumbs/160/apple/96/new-moon-with-face_1f31a.png"),
      );

  Widget buildContent() =>
      Container(
        child: Column(
          children: [
            Text(widget.userInfo['email'].toString()),
            Text(widget.userInfo['username'].toString()),
            Text(widget.userInfo['type'].toString()),
            TextButton(
              onPressed: () {

              },
              child: Text("Edit profile")
              ,
            ),
            TextButton(
              onPressed: () {
                FirebaseAuth.instance.signOut().then((value) {
                  print("Sign Out");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SigninPage(),
                      ));
                });
              },
              child: Text('Sign Out'),
            ),
          ],
        ),
      );
}
