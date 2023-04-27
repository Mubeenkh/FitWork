import 'package:flutter/material.dart';
import './loginPage.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
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
              alignment: Alignment.centerLeft,
              child: Text(
                'Sign Up',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 20,
            ),

            signUpPageTextField("Username"),
            SizedBox(
              height: 20,
            ),
            signUpPageTextField("Password"),
            // TextField(
            //   decoration: InputDecoration(
            //     enabledBorder: OutlineInputBorder(
            //       borderSide: BorderSide(width: 3, color: Colors.greenAccent),
            //     ),
            //     focusedBorder: OutlineInputBorder(
            //       borderSide: BorderSide(width: 3, color: Color(0xffF02E65)),
            //     ),
            //     errorBorder: OutlineInputBorder(
            //       borderSide: BorderSide(
            //           width: 3, color: Color.fromARGB(255, 66, 125, 145)),
            //     ),
            //   ),
            // ),

            signUpPageButtons('Back', context, FitWork()),
          ],
        ),
      ),
    );
  }
}

Widget signUpPageTextField(buttonText) {
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
              fontSize: 28,
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
              fontSize: 28,
              color: Colors.grey[300],
            ),
          ),
        ],
      ),
      TextField(
        decoration: InputDecoration(
          // hintText: buttonText,
          labelText: "Username",
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

Widget signUpPageButtons(buttonText , context, page) {
  return Container(
    // minW: 200.0,
    height: 60.0,
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
          borderRadius: BorderRadius.circular(10),
        ),
        // onPrimary: Color(0xff1F3040),
      ),
      child: Stack(
        children: <Widget>[
          // Stroked text as border.
          Text(
            buttonText,
            style: TextStyle(
              fontSize: 30,
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
              fontSize: 30,
              color: Colors.grey[300],
            ),
          ),
        ],
      ),
      onPressed: () {
        //SENDS THE USER TO THE SIGN UP PAGE
        Navigator.pop(context);
      },
    ),
  );
}
