import 'package:flutter/material.dart';
import './loginPage.dart';
import './SignupPage.dart';

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
                LoginWidgets.loginElevatedButtons('Back', context, FitWork()),
              ],
            )
          ],
        ),
      ),
    );
  }
}
