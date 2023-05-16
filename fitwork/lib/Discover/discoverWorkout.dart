import 'package:fitwork/FirebaseSample.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../Home/homePage.dart';

class DiscoverWorkout extends StatefulWidget {
  const DiscoverWorkout({Key? key, required this.name}) : super(key: key);
  final String name;

  @override
  State<DiscoverWorkout> createState() => _DiscoverWorkoutState();
}

class _DiscoverWorkoutState extends State<DiscoverWorkout> {
  // TextEditingController nameController = new TextEditingController();
  // TextEditingController imageController = new TextEditingController();

  Map<String, dynamic> Exercises = {};

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> _fetchData() async {
    DocumentSnapshot documentSnapshot;
    documentSnapshot =
        await firestore.collection("exercises").doc(widget.name).get();
    if (documentSnapshot.exists) {
      Map<String, dynamic> data =
          documentSnapshot.data() as Map<String, dynamic>;
      setState(() {
        Exercises = data;
      });
    }
  }

  List<Widget> list = [];
  Future<void> _fetchMoreData() async {
    Exercises.forEach(
          (key, value) {
        print(key);
        print(value['stringExample']);
        // list.add(new Text(key));
        // list.add(new Text(value['stringExample']));
        setState(() {
          list.add(
            new Card(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.black54),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Container(
                padding: EdgeInsets.all(8),
                // padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  gradient: LinearGradient(
                    colors: [
                      Color(0xff3C6B62),
                      Color(0xff1B2826),
                    ],
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      key,
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
        });
      },
    );
  }

  void initState() {
    super.initState();
    _fetchData();
    _fetchMoreData();
  }

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
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Add Workout"),
                                Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Text(
                                    "Name: ",
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                TextField(
                                    // controller: nameController,
                                    ),
                                Padding(
                                  padding: EdgeInsets.only(top: 20),
                                  child: Text("Image: "),
                                ),
                                TextField(
                                    // controller: imageController,
                                    ),
                              ],
                            ),
                            actions: <Widget>[
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: ElevatedButton(
                                  // color: Colors.red,
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    "Undo",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),

                              //Add Button

                              ElevatedButton(
                                onPressed: () {
                                  //TODO: Firestore create a new record code
                                  Map<String, dynamic> newBook =
                                      new Map<String, dynamic>();
                                  Map<String, dynamic> example = {
                                    "sad": {
                                      "stringExample": "ds world!",
                                      "numberExample": 3.565,
                                    },
                                  };

                                  FirebaseFirestore.instance
                                      .collection("exercises")
                                      .doc(widget.name)
                                      .update(example)
                                      .whenComplete(() {
                                    Navigator.of(context).pop();
                                  });

                                  // Map<String, dynamic> addExercise = {};
                                  // addExercise['name'] = nameController.text;
                                  // addExercise['image'] = imageController.text;
                                  // FirebaseFirestore.instance
                                  //     .collection(widget.name)
                                  //     .doc(addExercise['name'])
                                  //     .set(addExercise);
                                },
                                child: Text(
                                  "save",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          );
                        });
                  },
                  child: Text('Add Workout'),
                ),
                Text(
                  '${widget.name} Workout',
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
                Container(
                    height: 300,
                    child: Column(
                      children: list,
                    ),
                ),
                // ListView.builder(
                //     itemCount: Exercises.length,
                //     itemBuilder: (BuildContext context, int index) {
                //       Exercises.forEach((key, value) {
                //         print(key);
                //         print(value['stringExample']);
                //       });
                //     }
                // ),

                // StreamBuilder<QuerySnapshot>(
                //   stream: FirebaseFirestore.instance
                //       .collection("exercises")
                //       .snapshots(),
                //   builder: (BuildContext context,
                //       AsyncSnapshot<QuerySnapshot> snapshot) {
                //     if (snapshot.hasData) {
                //       final snap = snapshot.data!.docs;
                //       return Expanded(
                //         // height: 566,
                //         child: ListView.builder(
                //           scrollDirection: Axis.vertical,
                //           shrinkWrap: true,
                //           itemCount: snap.length,
                //           itemBuilder: (context, index) {
                //             // Exercises.map((key, value) {
                //             //   print(value);
                //             // });
                //             Exercises.forEach((key, value) {
                //               print(Exercises.length);
                //               print(key);
                //               print(value['stringExample']);
                //             });
                //           },
                //         ),
                //       );
                //     } else {
                //       return Center(
                //         child: CircularProgressIndicator(),
                //       );
                //     }
                //   },
                // ),

                // Container(
                //   height: 623,
                //   decoration: BoxDecoration(
                //     border: Border(
                //       bottom: BorderSide(
                //         color: Colors.black
                //       )
                //     )
                //   ),
                //   // height: double.infinity,
                //   child: ListView(
                //     children: [
                //       cardContent(widget.name),
                //       // cardContent('Bench Dips'),
                //       // cardContent('Bench Dips'),
                //       // cardContent('Bench Dips'),
                //       // cardContent('Bench Dips'),
                //     ],
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget listStuff(Exercises) {
  List<Widget> list = [];

  Exercises.forEach(
    (key, value) {
      print(key);
      print(value['stringExample']);
      // list.add(new Text(key));
      // list.add(new Text(value['stringExample']));
      list.add(
        new Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.black54),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            padding: EdgeInsets.all(8),
            // padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              gradient: LinearGradient(
                colors: [
                  Color(0xff3C6B62),
                  Color(0xff1B2826),
                ],
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  key,
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
    },
  );
  return new Column(children: list);
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
