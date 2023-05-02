import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import './loginPage.dart';
import './SignupPage.dart';
import '../Home/homePage.dart';
import 'package:another_flushbar/flushbar.dart';


class SigninPage extends StatefulWidget {
  const SigninPage({Key? key}) : super(key: key);

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();

  static Future<User?> loginUsingEmailPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        print("No user found for that email");
      }
    }
    return user;
  }

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
        child: Container(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 50,
                ),
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

                ///----------------------------------------------------------------
                ///Text fields for user to input Username and Password (Maybe Email)
                SizedBox(
                  height: 20,
                ),
                // signInTextField("Username"),
                LoginWidgets.loginTextField("Email", emailController),
                SizedBox(
                  height: 20,
                ),
                // signInTextField("Password"),
                LoginWidgets.loginTextField("Password", passwordController),

                ///----------------------------------------------------------------
                //TODO: send user to ForgotPasswordPage()
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          //sends you to Sign in page
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => SignupPage(),
                          //     ));
                        },
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(fontSize: 20, color: Colors.black54),
                        ),
                        style: ButtonStyle(),
                      ),
                    ),
                    //TODO: Sign in button to go to homePage()
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
                        child: LoginWidgets.stackedText('Sign In', 20.0, 3.0),
                        onPressed: () async {
                          //TODO: SENDS THE USER TO THE HOME PAGE

                          FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text).then((value) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      HomePage(username: 'dfdf'),
                                ),
                              );
                          }).onError((error, stackTrace) {
                            print("Error ${error.toString()}");
                            Flushbar(
                              flushbarPosition: FlushbarPosition.TOP,
                              message: "Wrong email and password",

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
                          });


                        },
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    //TODO: sending back to loginPage()
                    LoginWidgets.loginElevatedButtons(
                        'Back', context, FitWork()),

                    //TODO: Sending to SignUpPage() page
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: TextStyle(fontSize: 20, color: Colors.black54),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignupPage(),
                                ));
                          },
                          child: Text(
                            'Sign up',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black54,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/////////////////////

// Widget signInTextField(buttonText) {
//   return Column(
//     // mainAxisAlignment: MainAxisAlignment.start,
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       stackedText(buttonText, 26.0, 4.0),
//       TextField(
//         decoration: InputDecoration(
//           hintText: buttonText,
//           labelText: buttonText,
//           // labelStyle: ,
//           enabledBorder: OutlineInputBorder(
//               borderSide: BorderSide(width: 4, color: Color(0xff058A3A)),
//               borderRadius: BorderRadius.circular(10)),
//           border: OutlineInputBorder(),
//           focusedBorder: OutlineInputBorder(
//               borderSide: BorderSide(width: 4, color: Color(0xff058A3A)),
//               borderRadius: BorderRadius.circular(10)),
//           errorBorder: OutlineInputBorder(
//               borderSide: BorderSide(
//                   width: 3, color: Color.fromARGB(255, 66, 125, 145)),
//               borderRadius: BorderRadius.circular(10)),
//           filled: true,
//           fillColor: Color(0xffEDEDED),
//         ),
//       ),
//     ],
//   );
// }

Widget stackedText(String text, double textSize, double borderSize) {
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
