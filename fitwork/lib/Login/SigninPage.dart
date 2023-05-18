import 'package:cloud_firestore/cloud_firestore.dart';
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

  TextEditingController forgotPasswordController = new TextEditingController();

  Map<String, dynamic> User = new Map<String, dynamic>();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> _fetchData(email) async {
    DocumentSnapshot documentSnapshot;
    documentSnapshot = await firestore.collection('user').doc(email).get();

    if (documentSnapshot.exists) {
      Map<String, dynamic> data =
      documentSnapshot.data() as Map<String, dynamic>;
      setState(() {
        User = data;
      });
    }
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
                LoginWidgets.passwordTextField("Password", passwordController),

                ///----------------------------------------------------------------
                //TODO: send user to ForgotPasswordPage()
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {

                          showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: Color(0xffbad9c1),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Send Password Reset Email"),
                                  ),
                                  SizedBox(height: 5,),
                                  TextField(
                                    decoration: InputDecoration(
                                        filled: true, fillColor: Colors.white, hintText: 'email@.com'),
                                    controller: forgotPasswordController,
                                  ),
                                ],
                              ),
                              actions: <Widget>[
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: ElevatedButton(
                                    // color: Colors.red,
                                    style: _buttonStyle(),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      "Back",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  style: _buttonStyle(),
                                  onPressed: () {
                                    FirebaseAuth.instance.sendPasswordResetEmail(email: forgotPasswordController.text).then((value) {
                                      Flushbar(
                                        flushbarPosition: FlushbarPosition.TOP,
                                        message: "Password Reset Email has been sent",
                                        icon: Icon(
                                          Icons.info,
                                          size: 30.0,
                                          color: Colors.black,
                                        ),
                                        duration: Duration(seconds: 3),
                                        backgroundGradient: LinearGradient(
                                          colors: [
                                            Colors.blue.shade500,
                                            Colors.blue.shade300,
                                            Colors.blue.shade100
                                          ],
                                          stops: [0.4, 0.7, 1],
                                        ),
                                      )..show(context).then((value) {
                                        forgotPasswordController.clear();
                                      });

                                    });


                                  },
                                  child: Text(
                                    "Save",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            );
                          });

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

                          // var instance = FirebaseFirestore.instance.collection('users').where(field)
                          FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text).then((value) {
                            _fetchData(emailController.text).then((value) {
                              if(emailController.text == User['email']){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        HomePage(email: emailController.text),
                                  ),
                                );
                              }else{
                                Flushbar(
                                  flushbarPosition: FlushbarPosition.TOP,
                                  message: "Please check email",

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
                              }

                            });


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
_buttonStyle() {
  return ElevatedButton.styleFrom(
    shadowColor: Colors.black,
    elevation: 20,
    backgroundColor: Color(0xff5FB28B),
    side: BorderSide(
      width: 3,
      color: Color(0xff3C615A),
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5),
    ),
    // onPrimary: Color(0xff1F3040),
  );
}
