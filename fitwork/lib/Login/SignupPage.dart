import 'package:flutter/material.dart';
import './loginPage.dart';
import './SigninPage.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

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
                ]),
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

              LoginWidgets.loginTextField("Username"),
              SizedBox(
                height: 20,
              ),
              LoginWidgets.loginTextField("Password"),
              SizedBox(
                height: 20,
              ),
              LoginWidgets.loginTextField("Email"),
              SizedBox(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        //sends you to Sign in page
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SigninPage(),));
                      },
                      child: Text(
                        'Already to have an account!',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black54
                        ),
                      ),
                      style: ButtonStyle(),
                    ),
                  ),
                  LoginWidgets.loginElevatedButtons('Register', context, SigninPage()),
                  SizedBox(height: 15,),
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
