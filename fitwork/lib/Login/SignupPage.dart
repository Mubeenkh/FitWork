import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import './loginPage.dart';
import './SigninPage.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                'assets/images/appicon.png',
                height: 100,
                width: 100,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              signupTextField("Email", emailController),
              SizedBox(height: 20,),
              signupTextField("Username", usernameController),
              SizedBox(
                height: 20,
              ),
              signupTextField("Password", passwordController),
              SizedBox(
                // height: 20,
              ),

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
                      child: Stack(
                        children: <Widget>[
                          // Stroked text as border.
                          Text(
                            'Register',
                            style: TextStyle(
                              fontSize: 20,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 3
                                ..color = Colors.black87,
                            ),
                          ),
                          // Solid text as fill.
                          Text(
                            'Register',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey[300],
                            ),
                          ),
                        ],
                      ),
                      onPressed: () {
                        //TODO: SAVE DATA THEN SENDS THE USER TO THE SIGN UP PAGE
//                        Map<String, dynamic> newBook =
//        new Map<String, dynamic>();
//        newBook["title"] = titleController.text;
//        newBook["author"] = authorController.text;
                        Map<String, dynamic> User = new Map<String,dynamic>();
                        User['username'] = usernameController.text;
                        User['email'] = emailController.text;
                        User['password'] = passwordController.text;
                        //todo: send to database
                        FirebaseFirestore.instance
                             .collection("user")
                             .add(User)
                             .whenComplete(() {
                           Navigator.of(context).pop();
                         });
                        //TODO: SEND TO NEXT PAGE
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SigninPage(),
                            ));
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
    );
  }
}
// obscureText: true,
// enableSuggestions: false,
// autocorrect: false,
Widget signupTextField(buttonText, textfieldController) {
  return Column(
    // mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Stack(
        children: <Widget>[
          // Stroked text as border.
          Text(
            buttonText,
            style: TextStyle(
              fontSize: 26,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 3
                ..color = Colors.black,
            ),
          ),
          // Solid text as fill.
          Text(
            buttonText,
            style: TextStyle(
              fontSize: 26,
              color: Colors.grey[300],
            ),
          ),
        ],
      ),
      TextField(
        controller: textfieldController,
        decoration: InputDecoration(
          hintText: buttonText,
          // labelText: buttonText,
          // labelStyle: ,

          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 4, color: Color(0xff058A3A)),
              borderRadius: BorderRadius.circular(10)),
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 4, color: Color(0xff058A3A)),
              borderRadius: BorderRadius.circular(10)),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 3, color: Color.fromARGB(255, 66, 125, 145)),
              borderRadius: BorderRadius.circular(10)),
          filled: true,
          fillColor: Color(0xffEDEDED),
        ),
      ),
    ],
  );
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
