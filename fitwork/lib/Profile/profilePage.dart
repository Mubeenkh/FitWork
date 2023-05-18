import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitwork/Login/SigninPage.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../Profile/avatarSelectionPage.dart';

///-------------------------------------Profile Page -------------------------------------///
class Profile extends StatefulWidget {
  const Profile({Key? key, required this.userInfo}) : super(key: key);
  final Map<String, dynamic> userInfo;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  Map<String, dynamic> User = new Map<String, dynamic>();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> _fetchData() async {
    DocumentSnapshot documentSnapshot;
    documentSnapshot = await firestore.collection('user').doc(widget.userInfo['email']).get();

    if (documentSnapshot.exists) {
      Map<String, dynamic> data =
      documentSnapshot.data() as Map<String, dynamic>;
      setState(() {
        User = data;
      });
    }
  }

  void initState() {
    super.initState();
    // _reload();
    _fetchData();

  }

  final double coverHeight = 150;
  final double avatarHeight = 144;

  @override
  Widget build(BuildContext context) {
    _fetchData();
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
          child: showAvatarImage(widget.userInfo),
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

  showAvatarImage(userProfile) {
    if (widget.userInfo['avatar'].toString() != "") {
      // widget.userInfo.clear();
      // print(widget.userInfo);
      return GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => avatarSelectionPage(userProfile: userProfile,)));
        },
        child:    CircleAvatar(
          radius: avatarHeight / 2,
          backgroundColor: Colors.white,
          child: Image.asset(
              widget.userInfo['avatar'].toString()
          ),
        )
      );
    }
    else {
      return CircleAvatar(
        radius: avatarHeight / 2,
        backgroundColor: Colors.white,
        child: GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => avatarSelectionPage(userProfile: userProfile,)));
          },
          child: CircleAvatar(
            radius: avatarHeight / 2 - 4,
            backgroundImage: NetworkImage(
                "https://www.testhouse.net/wp-content/uploads/2021/11/default-avatar.jpg",
            ),
            backgroundColor: Colors.white,
          ),
        )
      );
    }
  }

  Widget buildContent() =>
      Container(
        child: Column(
          children: [
            Text(widget.userInfo['email'].toString(),),
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
                  // print("Sign Out");
                  widget.userInfo.clear();
                  // print(widget.userInfo);
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
