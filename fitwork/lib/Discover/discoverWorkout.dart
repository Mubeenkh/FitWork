import 'package:fitwork/FirebaseSample.dart';
import 'package:flutter/material.dart';
import '../Home/homePage.dart';

class DiscoverWorkout extends StatefulWidget {
  const DiscoverWorkout({Key? key, required this.name}) : super(key: key);
  final String name;
  @override
  State<DiscoverWorkout> createState() => _DiscoverWorkoutState();
}

class _DiscoverWorkoutState extends State<DiscoverWorkout> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: AppBar(
            elevation: 0.0,
            // backgroundColor: Colors.transparent,
            title: Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Back'),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Image.asset('assets/images/logo.png',
                          fit: BoxFit.cover, height: 50),
                    ),
                  ],
                ),
              ),
            ),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                // border: Border.all(width: 0),
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color(0xff1F3040),
                    Color(0xff3C6B62),
                    Color(0xff5FB28B),
                    Color(0xff5FB28B),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: Container(
          // height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xff1F3040),
                Color(0xff3C6B62),
                Color(0xff5FB28B),
                Color(0xff5FB28B),
              ],
            ),
          ),
          child: Center(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Add Workout'),
                ),
                Text(
                  'Triceps Workout',
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
                Container(
                  height: 650,
                  // height: double.infinity,
                  child: ListView(
                    children: [
                      cardContent(widget.name),
                      // cardContent('Bench Dips'),
                      // cardContent('Bench Dips'),
                      // cardContent('Bench Dips'),
                      // cardContent('Bench Dips'),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget cardContent(text) {
  return GestureDetector(
    onTap: () {
      print('workout time');
    },
    child: Card(
      shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.black54),
          borderRadius: BorderRadius.circular(20.0)),
      // shape: CircleBorder(
      //   side: BorderSide(color: Colors.white)
      // ),
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          gradient: LinearGradient(
            colors: [
              Color(0xff3C6B62),
              Color(0xff1B2826),
            ],
          ),
        ),
        // padding: EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Image.asset('assets/images/sampleWorkout.png')
          ],
        ),
      ),
    ),
  );
}
