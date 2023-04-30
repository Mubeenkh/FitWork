import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:compass_icon/compass_icon.dart';

class HomePage extends StatefulWidget {

  const HomePage({Key? key, required this.username}) : super(key: key);
  final String username;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _selectedIndex = 2;

  static const List<Widget> _widgetOptions = <Widget>[
    Discover(),
    Workout(),
    Home(),
    Nutrition(),
    Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
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
              child:
                Image.asset('assets/images/logo.png',fit: BoxFit.cover,height: 50),
            ),
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
                )
              ),
            ),

          ),
        ),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          // backgroundColor: Colors.blueGrey,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: CompassIcon(
                  Icon(Icons.arrow_circle_up,size: 50,),
                  compassDirection: CompassDirection.north,
                  initialDirection: CompassDirection.north,
              ),
              label: 'Discover',
              backgroundColor: Color(0xff3C6B62),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.run_circle_outlined,size: 50,),
              label: 'Workout',
              backgroundColor: Color(0xff3C6B62),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home,size: 50,),
              label: 'Home',
              backgroundColor: Color(0xff3C6B62),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.food_bank,size: 50,),
              label: 'Nutrition',
              backgroundColor:Color(0xff3C6B62),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person,size: 50,),
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

///-------------------------------------Discover Page -------------------------------------///
class Discover extends StatefulWidget {
  const Discover({Key? key}) : super(key: key);

  @override
  State<Discover> createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

///-------------------------------------Workout Page -------------------------------------///
class Workout extends StatefulWidget {
  const Workout({Key? key}) : super(key: key);

  @override
  State<Workout> createState() => _WorkoutState();
}

class _WorkoutState extends State<Workout> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
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
    return Padding(
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
                child: Text('Workout picture from api',style: TextStyle(fontSize: 25),)
            ),
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
                      child: Text('Last Workout: Date',style: TextStyle(fontSize: 25),)
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
                      child: Text('Motivational quote from api',style: TextStyle(fontSize: 25),)
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
                child: Container(
                  height: 200,
                  width: 100,
                  color: Colors.grey[400],
                  child: Align(
                      alignment: Alignment.center,
                      child: Text('Timer',style: TextStyle(fontSize: 25),)
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
                      child: Text('Picture of sad dog',style: TextStyle(fontSize: 25),)
                  ),
                ),
              ),
            ],
          )
        ],
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
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}



