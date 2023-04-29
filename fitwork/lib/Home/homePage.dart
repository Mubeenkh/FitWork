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
        appBar: AppBar(
          //1F3040
          //5FB28B
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/justlogo.png',fit: BoxFit.cover,height: 60),
            ],
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
              backgroundColor: Color(0xff94A187),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.run_circle_outlined,size: 50,),
              label: 'Workout',
              backgroundColor: Colors.blueGrey
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home,size: 50,),
              label: 'Home',
              backgroundColor: Colors.blueGrey
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.food_bank,size: 50,),
              label: 'Nutrition',
              backgroundColor: Colors.blueGrey
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person,size: 50,),
              label: 'Profile',
              backgroundColor: Colors.blueGrey
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
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

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

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



// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   TextEditingController titleController = new TextEditingController();
//   TextEditingController authorController = new TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Flutter Firestore CRUD"),
//       ),
//       body: BookList(),
//       // ADD (Create)
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           showDialog(
//               context: context,
//               builder: (BuildContext context) {
//                 return AlertDialog(
//                   content: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Text("Add"),
//                       Padding(
//                         padding: EdgeInsets.only(top: 10),
//                         child: Text(
//                           "Title: ",
//                           textAlign: TextAlign.start,
//                         ),
//                       ),
//                       TextField(
//                         controller: titleController,
//                       ),
//                       Padding(
//                         padding: EdgeInsets.only(top: 20),
//                         child: Text("Author: "),
//                       ),
//                       TextField(
//                         controller: authorController,
//                       ),
//                     ],
//                   ),
//                   actions: <Widget>[
//                     Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 10),
//                       child: ElevatedButton(
//                         // color: Colors.red,
//                         onPressed: () {
//                           Navigator.of(context).pop();
//                         },
//                         child: Text(
//                           "Undo",
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ),
//                     ),
//
//                     //Add Button
//
//                     ElevatedButton(
//                       onPressed: () {
//                         //TODO: Firestore create a new record code
//
//                         Map<String, dynamic> newBook =
//                         new Map<String, dynamic>();
//                         newBook["title"] = titleController.text;
//                         newBook["author"] = authorController.text;
//
//                         FirebaseFirestore.instance
//                             .collection("books")
//                             .add(newBook)
//                             .whenComplete(() {
//                           Navigator.of(context).pop();
//                         });
//                       },
//                       child: Text(
//                         "save",
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   ],
//                 );
//               });
//         },
//         tooltip: 'Add Title',
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }
//
// class BookList extends StatelessWidget {
//   TextEditingController titleController = new TextEditingController();
//   TextEditingController authorController = new TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     //TODO: Retrive all records in collection from Firestore
//     return StreamBuilder<QuerySnapshot>(
//       stream: FirebaseFirestore.instance.collection('books').snapshots(),
//       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
//         switch (snapshot.connectionState) {
//           case ConnectionState.waiting:
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           default:
//             return new ListView(
//               padding: EdgeInsets.only(bottom: 80),
//               children: snapshot.data!.docs.map((DocumentSnapshot document) {
//                 return Padding(
//                   padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
//                   child: Card(
//                     child: ListTile(
//                       onTap: () {
//                         showDialog(
//                             context: context,
//                             builder: (BuildContext context) {
//                               return AlertDialog(
//                                 title: Text("Update Dilaog"),
//                                 content: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: <Widget>[
//                                     Text(
//                                       "Title: ",
//                                       textAlign: TextAlign.start,
//                                     ),
//                                     TextField(
//                                       controller: titleController,
//                                       decoration: InputDecoration(
//                                         hintText: document['title'],
//                                       ),
//                                     ),
//                                     Padding(
//                                       padding: EdgeInsets.only(top: 20),
//                                       child: Text("Author: "),
//                                     ),
//                                     TextField(
//                                       controller: authorController,
//                                       decoration: InputDecoration(
//                                         hintText: document['author'],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 actions: <Widget>[
//                                   Padding(
//                                     padding:
//                                     EdgeInsets.symmetric(horizontal: 10),
//                                     child: ElevatedButton(
//                                       // color: Colors.red,
//                                       onPressed: () {
//                                         Navigator.of(context).pop();
//                                       },
//                                       child: Text(
//                                         "Undo",
//                                         style: TextStyle(color: Colors.white),
//                                       ),
//                                     ),
//                                   ),
//                                   // Update Button
//                                   ElevatedButton(
//                                       child: Text(
//                                         "Update",
//                                         style: TextStyle(color: Colors.white),
//                                       ),
//                                       onPressed: () {
//                                         //TODO: Firestore update a record code
//
//                                         Map<String, dynamic> updateBook =
//                                         new Map<String, dynamic>();
//                                         updateBook["title"] =
//                                             titleController.text;
//                                         updateBook["author"] =
//                                             authorController.text;
//
//                                         // Updae Firestore record information regular way
//                                         FirebaseFirestore.instance
//                                             .collection("books")
//                                             .doc(document.id)
//                                             .update(updateBook)
//                                             .whenComplete(() {
//                                           Navigator.of(context).pop();
//                                         });
//
//                                         child:
//                                         Text(
//                                           "update",
//                                           style: TextStyle(color: Colors.white),
//                                         );
//                                       }),
//                                 ],
//                               );
//                             });
//                       },
//                       title: new Text("Title " + document['title']),
//                       subtitle: new Text("Author " + document['author']),
//                       trailing:
//                       // Delete Button
//                       InkWell(
//                         onTap: () {
//                           //TODO: Firestore delete a record code
//                           FirebaseFirestore.instance
//                               .collection("books")
//                               .doc(document.id)
//                               .delete()
//                               .catchError((e) {
//                             print(e);
//                           });
//                         },
//                         child: Padding(
//                           padding: EdgeInsets.symmetric(
//                               horizontal: 20, vertical: 10),
//                           child: Icon(Icons.delete),
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               }).toList(),
//             );
//         }
//       },
//     );
//   }
// }