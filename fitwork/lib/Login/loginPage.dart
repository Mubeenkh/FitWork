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
            borderSide: BorderSide(width: 3,
                color: Colors.greenAccent),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 3,
                color: Colors.amberAccent),
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
                  mainPageButtons('Sign in' , context , SigninPage()),
                  ////////////////
                  SizedBox(
                    height: 30,
                  ),

                  ////////// Sign out //////////
                  mainPageButtons('Sign Up' , context, SignupPage()),
                ],
              ),
            ),
          ),
        ),
    );
  }
}

Widget mainPageButtons(buttonText , context, page) {
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
        Navigator.push(context, MaterialPageRoute(builder: (context) => page,));
      },
    ),
  );
}
