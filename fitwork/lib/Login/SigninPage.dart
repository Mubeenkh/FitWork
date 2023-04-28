import 'package:flutter/material.dart';
import './loginPage.dart';
import './SignupPage.dart';
import '../Home/homePage.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({Key? key}) : super(key: key);

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              ]),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              'assets/images/appicon.png',
              height: 150,
              width: 150,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                'Sign In',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 20,
            ),

            LoginWidgets.loginTextField("Username"),
            SizedBox(
              height: 20,
            ),
            LoginWidgets.loginTextField("Password"),
            SizedBox(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      //sends you to Sign in page
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SignupPage(),));
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black54
                      ),
                    ),
                    style: ButtonStyle(),
                  ),
                ),
                Container(
                  // minW: 200.0,
                  height: 45.0,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.black,
                      elevation: 20,
                      backgroundColor: Color(0xff3C615A),
                      // side: BorderSide(
                      //   width: 3,
                      //   color: Color(0xff5FB28B),
                      // ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      // onPrimary: Color(0xff1F3040),
                    ),
                    child: Stack(
                      children: <Widget>[
                        // Stroked text as border.
                        Text(
                          'Sign In',
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
                          'Sign In',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey[300],
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {
                      //SENDS THE USER TO THE SIGN UP PAGE
                      // Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(username: 'dfdf'),));
                    },
                  ),
                ),
                SizedBox(height: 15,),
                LoginWidgets.loginElevatedButtons('Back', context, FitWork()),
              ],
            )
          ],
        ),
      ),
    );
  }
}
//                  ElevatedButton(
//                       onPressed: () {
//                         //TODO: Firestore create a new record code
//
//                         Map<String, dynamic> newBook =
//                         new Map<String, dynamic>();
//                         newBook["title"] = titleController.text;
//                         newBook["author"] = authorController.text;
//
//                         FirebaseFirestore.instance
//                             .collection("books")
//                             .add(newBook)
//                             .whenComplete(() {
//                           Navigator.of(context).pop();
//                         });
//                       },
//                       child: Text(
//                         "save",
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
