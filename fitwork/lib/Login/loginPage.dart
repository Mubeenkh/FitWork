import './SigninPage.dart';
import './SignupPage.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/SigninPage': (context) => SigninPage(),
        '/SignupPage': (context) => SignupPage()
      },
      theme: ThemeData(
        primarySwatch: Colors.red,
        inputDecorationTheme: const InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 3, color: Colors.greenAccent),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 3, color: Colors.amberAccent),
          ),
        ),
      ),
      home: FitWork(),
    );
  }
}

///////////////////////////////////////////////// Main screen /////////////////////////////////////////////////
class FitWork extends StatefulWidget {
  const FitWork({Key? key}) : super(key: key);

  @override
  State<FitWork> createState() => _FitWorkState();
}

class _FitWorkState extends State<FitWork> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xff1F3040), Color(0xff5FB28B)]),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 50,
                ),
                ////////// LOGO //////////
                Image.asset(
                  'assets/images/justlogo.png',
                  width: 150,
                  height: 150,
                ),
                SizedBox(
                  height: 50,
                ),

                ////////// Sign in //////////
                LoginWidgets.mainLoginButtons('Sign in', context, SigninPage()),
                ////////////////
                SizedBox(
                  height: 30,
                ),

                ////////// Sign out //////////
                LoginWidgets.mainLoginButtons('Sign Up', context, SignupPage()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginWidgets {

  static Widget mainLoginButtons(buttonText, context, page) {
    return Container(
      // minW: 200.0,
      height: 60.0,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shadowColor: Colors.black,
          elevation: 20,
          backgroundColor: Color(0xff3C615A),
          side: BorderSide(
            width: 3,
            color: Color(0xff5FB28B),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
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
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => page,
              ));
        },
      ),
    );
  }

  static Widget loginTextField(buttonText) {
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
          decoration: InputDecoration(
            hintText: buttonText,
            labelText: buttonText,
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

  ////////////////////////////////////////////////////////
  static Widget loginElevatedButtons(buttonText, context, page) {
    return Container(
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
              buttonText,
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
              buttonText,
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
          Navigator.push(context, MaterialPageRoute(builder: (context) => page,));
        },
      ),
    );
  }
}
