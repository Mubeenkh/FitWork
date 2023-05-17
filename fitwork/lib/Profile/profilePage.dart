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
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(),
          Text(widget.userInfo['email'].toString()),
          Text(widget.userInfo['username'].toString()),
          Text(widget.userInfo['type'].toString()),
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