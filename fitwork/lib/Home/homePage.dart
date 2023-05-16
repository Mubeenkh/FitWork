import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitwork/Login/SigninPage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import '../Login/loginPage.dart';
import '../Discover/discoverPage.dart';
import '../Workout/WorkoutPage.dart';
import '../Home/timerPage.dart';

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
    documentSnapshot = await firestore.collection('user').doc(widget.email).get();

    if(documentSnapshot.exists){
      Map<String,dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
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
      Discover( userInfo: User),
      Workout(),
      Home(),
      Nutrition(),
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
        body:
        // Column(
        //   children: [
        //     ElevatedButton(
        //         onPressed: () {
        //           print(User.length);
        //         },
        //         child: Text(User['username'].toString())),
            _widgetOptions.elementAt(_selectedIndex),
        //   ],
        // ),
        bottomNavigationBar: BottomNavigationBar(
          // backgroundColor: Colors.blueGrey,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon:
                Icon(
                  Icons.arrow_circle_up,
                  size: 50,
                ),

              label: 'Discover',
              backgroundColor: Color(0xff3C6B62),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.run_circle_outlined,
                size: 50,
              ),
              label: 'Workout',
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
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image.asset(name)
            Container(
              height: 100,
              width: double.infinity,
              color: Colors.grey[400],
              child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Workout picture from api',
                    style: TextStyle(fontSize: 25),
                  )),
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
                    color: Colors.grey[400],
                    child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Last Workout: Date',
                          style: TextStyle(fontSize: 25),
                        )),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Container(
                    height: 200,
                    width: 100,
                    color: Colors.grey[400],
                    child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Motivational quote from api',
                          style: TextStyle(fontSize: 25),
                        )),
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
                      color: Colors.grey[400],
                      child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Timer',
                            style: TextStyle(fontSize: 25),
                          )),
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
                    color: Colors.grey[400],
                    child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Picture of sad dog',
                          style: TextStyle(fontSize: 25),
                        )),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

///-------------------------------------Nutrition Page -------------------------------------///
class Nutrition extends StatefulWidget {
  const Nutrition({Key? key}) : super(key: key);

  @override
  State<Nutrition> createState() => _NutritionState();
}

class _NutritionState extends State<Nutrition> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

///-------------------------------------Profile Page -------------------------------------///
class Profile extends StatefulWidget {

  const Profile({Key? key, required this.userInfo}) : super(key: key);
  final Map<String, dynamic> userInfo;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(),
          Text(widget.userInfo['email'].toString()),
          Text(widget.userInfo['username'].toString()),
          Text(widget.userInfo['type'].toString()),
          TextButton(
            onPressed: () {
              FirebaseAuth.instance.signOut().then((value) {
                print("Sign Out");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SigninPage(),
                    ));
              });
            },
            child: Text('Sign Out'),
          ),
        ],
      ),
    );
  }
}
