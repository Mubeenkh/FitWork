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

  TextEditingController usernameController = new TextEditingController();

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
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              color: Color(0xff5FB28B),
              child: ListTile(
                // splashColor: Color(0xff3C615A),
                leading: Icon(Icons.email),
                iconColor: Color(0xff3C615A),
                title: Text(
                  widget.userInfo['email'].toString(),
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            Card(
              color: Color(0xff5FB28B),
              child: ListTile(
                trailing: Icon(Icons.autorenew),
                leading: Icon(Icons.person),
                iconColor: Color(0xff3C615A),
                title: Text(
                  widget.userInfo['username'].toString(),
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onTap: () {
                  usernameController.text = widget.userInfo['username'];
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Color(0xffbad9c1),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Change Username"),
                              ),
                              SizedBox(height: 5,),
                              TextField(
                                decoration: InputDecoration(
                                    filled: true, fillColor: Colors.white, hintText: 'Confirm Username'),
                                controller: usernameController,
                              ),
                            ],
                          ),
                          actions: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: ElevatedButton(
                                // color: Colors.red,
                                style: _buttonStyle(),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  "Back",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            ElevatedButton(
                              style: _buttonStyle(),
                              onPressed: () {

                                if(usernameController.text.isNotEmpty){
                                  Map<String, dynamic> profile = new Map<String, dynamic>();
                                  profile = widget.userInfo;
                                  profile['username'] = usernameController.text;
                                  FirebaseFirestore.instance.collection('user').doc(profile['email']).update(profile).then((value) {
                                    Flushbar(
                                      flushbarPosition: FlushbarPosition.TOP,
                                      message: "Password Reset Email has been sent",
                                      icon: Icon(
                                        Icons.info,
                                        size: 30.0,
                                        color: Colors.black,
                                      ),
                                      duration: Duration(seconds: 3),
                                      backgroundGradient: LinearGradient(
                                        colors: [
                                          Colors.blue.shade500,
                                          Colors.blue.shade300,
                                          Colors.blue.shade100
                                        ],
                                        stops: [0.4, 0.7, 1],
                                      ),
                                    )..show(context);
                                  });
                                }else{
                                  Flushbar(
                                    flushbarPosition: FlushbarPosition.TOP,
                                    message: "Please fill up criteria",
                                    icon: Icon(
                                      Icons.info,
                                      size: 30.0,
                                      color: Colors.black,
                                    ),
                                    duration: Duration(seconds: 3),
                                    backgroundGradient: LinearGradient(
                                      colors: [
                                        Colors.red.shade500,
                                        Colors.red.shade300,
                                        Colors.red.shade100
                                      ],
                                      stops: [0.4, 0.7, 1],
                                    ),
                                  )..show(context);
                                }
                              },
                              child: Text(
                                "Save",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        );
                      });
                },
              ),
            ),
            Card(
              color: Color(0xff5FB28B),
              child: ListTile(
                leading: Icon(Icons.business_center),
                iconColor: Color(0xff3C615A),
                title: Text(
                  widget.userInfo['type'].toString(),
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            Card(
              color: Color(0xff5FB28B),
              child: ListTile(
                leading: Icon(Icons.business_center),
                trailing: Icon(Icons.autorenew),
                iconColor: Color(0xff3C615A),
                title: Text(
                  'Password',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onTap: () {
                  FirebaseAuth.instance.sendPasswordResetEmail(email: widget.userInfo['email']).then((value) {
                    Flushbar(
                      flushbarPosition: FlushbarPosition.TOP,
                      message: "Password Reset Email has been sent",
                      icon: Icon(
                        Icons.info,
                        size: 30.0,
                        color: Colors.black,
                      ),
                      duration: Duration(seconds: 3),
                      backgroundGradient: LinearGradient(
                        colors: [
                          Colors.blue.shade500,
                          Colors.blue.shade300,
                          Colors.blue.shade100
                        ],
                        stops: [0.4, 0.7, 1],
                      ),
                    )..show(context);
                  });
                },
              ),
            ),
            TextButton(
              style: _buttonStyle(),
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
              child: Text('Sign Out', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      );

}
_TextButtonStyle() {
  return TextButton.styleFrom(
    side: BorderSide(
      width: 3,
      color: Color(0xff3C615A),
    ),
  );
}
_buttonStyle() {
  return ElevatedButton.styleFrom(
    shadowColor: Colors.black,
    elevation: 20,
    backgroundColor: Color(0xff5FB28B),
    side: BorderSide(
      width: 3,
      color: Color(0xff3C615A),
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5),
    ),
    // onPrimary: Color(0xff1F3040),
  );
}
