import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:another_flushbar/flushbar.dart';

// import 'package:firebase_core/firebase_core.dart';
import './loginPage.dart';
import './SigninPage.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  // final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

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
          child: Container(
            height: double.infinity,
            child: SingleChildScrollView(
              // physics: NeverScrollableScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Image.asset(
                    'assets/images/appicon.png',
                    height: 100,
                    width: 100,
                  ),
                  SizedBox(height: 20),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text('Sign Up',
                        style: TextStyle(
                            fontSize: 35, fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(height: 20),
                  // LoginWidgets.loginTextField("Email", emailController),
                  EmailTextField("Email", emailController, context),
                  SizedBox(height: 20),
                  LoginWidgets.loginTextField("Username", usernameController),
                  SizedBox(height: 20),
                  LoginWidgets.passwordTextField(
                      "Password", passwordController),
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
                            style:
                                TextStyle(fontSize: 20, color: Colors.black54),
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
                          child: LoginWidgets.stackedText('Register', 20, 3),
                          onPressed: () {
                            //TODO: SAVE DATA THEN SENDS THE USER TO THE SIGN UP PAGE

                            checkAccounts();
                            if (usernameController.text != "" &&
                                usernameController.text != null &&
                                emailController.text != "" &&
                                emailController.text != null &&
                                passwordController.text != "" &&
                                passwordController.text != null) {

                              Map<String, dynamic> User =
                                  new Map<String, dynamic>();
                              User['username'] = usernameController.text;
                              User['email'] = emailController.text;
                              User['password'] = passwordController.text;
                              User['avatar'] = '';
                              User['type'] = 'user';
                              // //todo: send to database
                              FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                      email: emailController.text,
                                      password: passwordController.text)
                                  .then(
                                (value) {
                                  // FirebaseFirestore.instance
                                  //     .collection("user")
                                  //     .add(User);
                                  FirebaseFirestore.instance
                                      .collection("user")
                                      .doc(User['email'])
                                      .set(User);

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SigninPage()),
                                  );
                                },
                              ).onError((error, stackTrace) {
                                //
                                if (emailController.text!.isEmpty || !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}').hasMatch(emailController.text!)){
                                  //r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9+$'
                                  // print("TESTING");
                                  flushbarError("Incorrect Email Format", context);
                                } else if (passwordController.text.length < 6) {
                                  flushbarError(
                                      "Password needs need to have 6 characters or more",
                                      context);
                                }

                                print("Error ${error.toString()}");
                                // flushbarError("account already exist", context);
                              });
                            } else {
                              // const snackBar = SnackBar(content: Text('Please fill up all fields'));
                              // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              flushbarError("Fill up all fields", context);
                              // print("bruh");
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      LoginWidgets.loginElevatedButtons(
                          'Back', context, FitWork()),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void checkAccounts() {
    StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('user').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(),
            );
          default:
            return new ListView(
              padding: EdgeInsets.only(bottom: 80),
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                if (emailController.text.toString() ==
                    document['email'].toString()) {
                  // print(document['email'].toString());
                  return Flushbar(
                    flushbarPosition: FlushbarPosition.TOP,
                    message: "account already exist",

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
                return Text('Account created');
              }).toList(),
            );
        }
      },
    );
  }
}

Widget EmailTextField(buttonText, currentController, context) {
  return Column(
// mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      stackedText(buttonText, 26.0, 3.0),
      TextFormField(

        controller: currentController,

        decoration: InputDecoration(
          hintText: buttonText,

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

Widget flushbarError(text, context) {
  return Flushbar(
    flushbarPosition: FlushbarPosition.TOP,
    message: text,

    icon: Icon(
      Icons.info,
      size: 30.0,
      color: Colors.black,
    ),
    duration: Duration(seconds: 3),
    // leftBarIndicatorColor: Colors.green[900],
    // backgroundColor: Colors.black54,
    backgroundGradient: LinearGradient(
      colors: [Colors.red.shade500, Colors.red.shade300, Colors.red.shade100],
      stops: [0.4, 0.7, 1],
    ),
  )..show(context);
}
