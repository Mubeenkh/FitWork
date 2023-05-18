import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitwork/Login/SigninPage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import '../Login/loginPage.dart';
import '../Workouts/discoverPage.dart';
import '../Stretches/stretchesPage.dart';
import '../Home/timerPage.dart';
import '../Models/Quote.dart';
import '../Services/quote_service.dart';
import 'dart:math';
import '../Nutrition/selectNutritionPage.dart';
import '../Profile/profilePage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.email}) : super(key: key);
  final String email;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, dynamic> User = new Map<String, dynamic>();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> _fetchData() async {
    DocumentSnapshot documentSnapshot;
    documentSnapshot =
        await firestore.collection('user').doc(widget.email).get();

    if (documentSnapshot.exists) {
      Map<String, dynamic> data =
          documentSnapshot.data() as Map<String, dynamic>;
      setState(() {
        User = data;
      });
    }
  }

  void initState() {
    super.initState();
    _fetchData();
  }

  //---------------------------------------------
  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    void _sendHome() {
      setState(() {
        _selectedIndex = 2;
      });
    }

    List<Widget> _widgetOptions = <Widget>[
      Workouts(userInfo: User),
      Stretches(),
      Home(),
      Nutrition(userInfo: User),
      Profile(userInfo: User),
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: AppBar(
            //1F3040
            //5FB28B
            title: Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () => _sendHome(),
                  child: Image.asset('assets/images/logo.png',
                      fit: BoxFit.cover, height: 50),
                )),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0xff1F3040),
                  Color(0xff3C6B62),
                  Color(0xff5FB28B),
                  Color(0xff5FB28B),
                ],
              )),
            ),
          ),
        ),
        body: _widgetOptions.elementAt(_selectedIndex),

        bottomNavigationBar: BottomNavigationBar(
          // backgroundColor: Colors.blueGrey,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.arrow_circle_up,
                size: 50,
              ),
              label: 'Workout',
              backgroundColor: Color(0xff3C6B62),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.run_circle_outlined,
                size: 50,
              ),
              label: 'Stretches',
              backgroundColor: Color(0xff3C6B62),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 50,
              ),
              label: 'Home',
              backgroundColor: Color(0xff3C6B62),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.food_bank,
                size: 50,
              ),
              label: 'Nutrition',
              backgroundColor: Color(0xff3C6B62),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                size: 50,
              ),
              label: 'Profile',
              backgroundColor: Color(0xff3C6B62),
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black54,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

///-------------------------------------Home Page -------------------------------------///
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image.asset(name)
              Container(
                height: 150,
                width: double.infinity,
                // color: Colors.grey[400],
                decoration: BoxDecoration(
                    color: Color(0xffbad9c1),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    'https://post.healthline.com/wp-content/uploads/2020/02/man-exercising-plank-push-up-1200x628-facebook.jpg',
                    fit: BoxFit.cover,
                    
                  ),
                ),
                // child: Align(
                //     alignment: Alignment.center,
                //     child: Text(
                //       'Workout picture from api',
                //       style: TextStyle(fontSize: 25),
                //     )),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 200,
                      width: 100,
                      // color: Colors.grey[400],
                      decoration: BoxDecoration(
                          color: Color(0xffbad9c1),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Color(0xff5FB28B),
                            width: 5
                          )
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.network(
                              'https://nypost.com/wp-content/uploads/sites/2/2018/06/180628-skipping-workout-feature.jpg?quality=75&strip=all&w=1024',
                            fit: BoxFit.cover,

                          ),
                        ),
                      ),
                      // child: Align(
                      //     alignment: Alignment.center,
                      //     child: Text(
                      //       'Last Workout: Date',
                      //       style: TextStyle(fontSize: 25),
                      //     )),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Container(
                      child: Container(
                        height: 200,
                        width: 100,
                        // color: Colors.grey[400],
                        decoration: BoxDecoration(
                          color: Color(0xffbad9c1),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: Color(0xff5FB28B),
                              width: 5
                          )
                        ),
                        child: Align(
                            alignment: Alignment.center, child: quoteWidget()),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => TimerPage()));
                      },
                      child: Container(

                        height: 200,
                        width: 100,
                        // color: Colors.grey[400],
                        decoration: BoxDecoration(
                          color: Color(0xffbad9c1),
                          borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: Color(0xff5FB28B),
                                width: 5
                            )
                        ),
                        child: Align(
                            alignment: Alignment.center,
                            // child: Text(
                            //   'Timer',
                            //   style: TextStyle(fontSize: 25),
                            // ),
                          child: Icon(
                            Icons.timer_sharp, size: 100,color: Color(0xff3C615A),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Container(
                      height: 200,
                      width: 100,
                      // color: Colors.grey[400],
                      decoration: BoxDecoration(
                          color: Color(0xff5FB28B),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Align(
                          alignment: Alignment.center,
                      ),
                      foregroundDecoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            "https://transcode-v2.app.engoo.com/image/fetch/f_auto,c_lfill,w_300,dpr_3/https://assets.app.engoo.com/images/QyDHB4YHkK2V6TA6QkDzSIMbQpg9IIUKO5tn8KuDcJ1.jpeg",
                          ),
                          fit: BoxFit.cover,

                        ),
                        borderRadius: BorderRadius.circular(10)
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

///------------------------------------- Quote Widget -------------------------------------///

class quoteWidget extends StatefulWidget {
  const quoteWidget({Key? key}) : super(key: key);

  @override
  State<quoteWidget> createState() => _quoteWidgetState();
}

class _quoteWidgetState extends State<quoteWidget> {
  List<Quote>? quotes;
  var isLoaded = false;
  Random rand = new Random();

  @override
  void initState() {
    super.initState();

    getData();
  }

  getData() async {
    quotes = await QuoteService().getQuotes();
    if (quotes != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var index = rand.nextInt(200);
    return Visibility(
      visible: isLoaded,
      child: Padding(
          padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
          child: Container(
            child: Column(
              children: [
                Expanded(
                    child: Text(
                  "\"${quotes?[index].text ?? ""}\"",
                  style: TextStyle(fontSize: 20),
                )),
                Text(
                  "- ${quotes?[index].author ?? "unknown"}",
                  style: TextStyle(fontSize: 20),
                )
              ],
            ),
          )),
      replacement: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}



// _buttonStyle() {
//   return ElevatedButton.styleFrom(
//     shadowColor: Colors.black,
//     elevation: 20,
//     backgroundColor: Color(0xff5FB28B),
//     side: BorderSide(
//       width: 3,
//       color: Color(0xff3C615A),
//     ),
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(5),
//     ),
//     // onPrimary: Color(0xff1F3040),
//   );
// }

