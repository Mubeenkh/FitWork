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
        child: stackedText(buttonText, 30, 4),
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

  static Widget loginTextField(buttonText, currentController) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        stackedText(buttonText, 26.0, 3.0),
        TextField(
          controller: currentController,
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

  static Widget passwordTextField(buttonText, textfieldController) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LoginWidgets.stackedText(buttonText, 26, 4),
        TextField(
          obscureText: true,
          enableSuggestions: false,
          autocorrect: false,
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

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: stackedText(buttonText, 20, 3),

        onPressed: () {
          //SENDS THE USER TO THE SIGN UP PAGE
          Navigator.push(context, MaterialPageRoute(builder: (context) => page,));
        },
      ),
    );
  }

  static Widget stackedText(String text,double textSize, double borderSize) {

    return Stack(
      children: <Widget>[
        // Stroked text as border.
        Text(
          text,
          style: TextStyle(
            fontSize: textSize,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = borderSize
              ..color = Colors.black,
          ),
        ),
        // Solid text as fill.
        Text(
          text,
          style: TextStyle(
            fontSize: textSize,
            color: Colors.grey[300],
          ),
        ),
      ],
    );
  }
}
