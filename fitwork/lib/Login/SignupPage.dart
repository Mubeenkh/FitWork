import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:another_flushbar/flushbar.dart';

// import 'package:firebase_core/firebase_core.dart';
import './loginPage.dart';
import './SigninPage.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          padding: EdgeInsets.all(40),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xff1F3040),
                Color(0xff5FB28B),
                Color(0xff5FB28B),
              ],
            ),
          ),
          child: Container(
            height: double.infinity,
            child: SingleChildScrollView(
              // physics: NeverScrollableScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Image.asset(
                    'assets/images/appicon.png',
                    height: 100,
                    width: 100,
                  ),
                  SizedBox(height: 20),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text('Sign Up',
                        style:
                            TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(height: 20),
                  LoginWidgets.loginTextField("Email", emailController),
                  SizedBox(height: 20),
                  LoginWidgets.loginTextField("Username", usernameController),
                  SizedBox(height: 20),
                  LoginWidgets.passwordTextField("Password", passwordController),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            //sends you to Sign in page
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SigninPage(),
                                ));
                          },
                          child: Text(
                            'Already to have an account!',
                            style: TextStyle(fontSize: 20, color: Colors.black54),
                          ),
                          style: ButtonStyle(),
                        ),
                      ),
                      //
                      //TODO: INSERT THE DATA TO THE DATABASE
                      Container(
                        // minW: 200.0,
                        height: 45.0,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shadowColor: Colors.black,
                            elevation: 20,
                            backgroundColor: Color(0xff3C615A),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: LoginWidgets.stackedText('Register', 20, 3),
                          onPressed: () {
                            //TODO: SAVE DATA THEN SENDS THE USER TO THE SIGN UP PAGE

                            // checkAccounts();
                            // final snapShot = await FirebaseFirestore.instance
                            //     .collection('posts')
                            //     .doc(docId) // varuId in your case
                            //     .get();
                            //
                            // if (snapShot == null || !snapShot.exists) {
                            //   // Document with id == varuId doesn't exist.
                            //
                            //   // You can add data to Firebase Firestore here
                            // }

                            if(usernameController.text != "" && usernameController.text != null &&
                                emailController.text != "" && emailController.text != null &&
                                passwordController.text != "" && passwordController.text != null) {

                                Map<String, dynamic> User = new Map<String,
                                    dynamic>();
                                User['username'] = usernameController.text;
                                User['email'] = emailController.text;
                                User['password'] = passwordController.text;
                                // //todo: send to database
                                FirebaseFirestore.instance
                                    .collection("user")
                                    .add(User)
                                    .whenComplete(() {
                                  //TODO: SEND TO NEXT PAGE
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SigninPage()),
                                  );
                                });

                            }else {
                              // const snackBar = SnackBar(content: Text('Please fill up all fields'));
                              // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              Flushbar(
                                flushbarPosition: FlushbarPosition.TOP,
                                message: "Please fill up all fields",

                                icon: Icon(
                                  Icons.info,
                                  size: 30.0,
                                  color: Colors.black,
                                ),
                                duration: Duration(seconds: 3),
                                // leftBarIndicatorColor: Colors.green[900],
                                // backgroundColor: Colors.black54,
                                backgroundGradient: LinearGradient(
                                  colors: [
                                    Colors.red.shade500,
                                    Colors.red.shade300,
                                    Colors.red.shade100
                                  ],
                                  stops: [0.4, 0.7, 1],
                                ),
                              )..show(context);
                              print("bruh");
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      LoginWidgets.loginElevatedButtons('Back', context, FitWork()),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}
// ElevatedButton(
//      onPressed: () {
//        //TODO: Firestore create a new record code
//
//        Map<String, dynamic> newBook =
//        new Map<String, dynamic>();
//        newBook["title"] = titleController.text;
//        newBook["author"] = authorController.text;
//
//        FirebaseFirestore.instance
//            .collection("books")
//            .add(newBook)
//            .whenComplete(() {
//          Navigator.of(context).pop();
//        });
//      },
//      child: Text(
//        "save",
//        style: TextStyle(color: Colors.white),
//      ),
//    ),
