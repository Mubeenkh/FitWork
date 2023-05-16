import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import './discoverWorkout.dart';

///-------------------------------------Discover Page -------------------------------------///
class Discover extends StatefulWidget {
  const Discover({Key? key, required this.email}) : super(key: key);
  final String email;
  @override
  State<Discover> createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> {

  TextEditingController nameController = new TextEditingController();
  
  late  DocumentReference _documentReference = FirebaseFirestore.instance.collection('workouts').doc('Biceps');

  late CollectionReference _referenceExercises =  _documentReference.collection('exercises');
  late Stream<QuerySnapshot> _streamExercises = _referenceExercises.snapshots();

  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [

          SizedBox(height: 15,),
          Text('Discover Exercises', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
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
                            controller: nameController,
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
                        ElevatedButton(
                          onPressed: () {
                            //TODO: Firestore create a new record code

                            Map<String, dynamic> exerciseToAdd= {
                              'name': nameController.text
                            };
                            _referenceExercises.add(exerciseToAdd);
                            Navigator.pop(context);
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

          SizedBox(height: 15,),

          // StreamBuilder<QuerySnapshot> (
          //   stream: FirebaseFirestore.instance.collection("workout").snapshots(),
          //   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          //     if(snapshot.hasData){
          //       final snap = snapshot.data!.docs;
          //       return Expanded(
          //         // height: 566,
          //         child: ListView.builder(
          //           scrollDirection: Axis.vertical,
          //           shrinkWrap: true,
          //           itemCount: snap.length,
          //           itemBuilder: (context, index) {
          //             return Column(
          //
          //               children: [
          //                 GestureDetector(
          //                   onTap: () {
          //                     Navigator.push(context,
          //                         MaterialPageRoute(builder: (context) => DiscoverWorkout(name: snap[index]['name'],)));
          //                   },
          //                   child: Container(
          //                     height: 100,
          //                     decoration: BoxDecoration(
          //                       borderRadius: BorderRadius.circular(5),
          //                       image: DecorationImage(
          //                         image: NetworkImage(snap[index]['image'].toString()),
          //                         // image: AssetImage('assets/images/Workout/chest.jpg'),
          //                         fit:BoxFit.cover,
          //                       ),
          //                     ),
          //                     child: Card(
          //                         color: Colors.transparent,
          //                         child: Padding(
          //                           padding: const EdgeInsets.all(8.0),
          //                           child: Align(
          //                             alignment: Alignment.bottomLeft,
          //                             child: Text(snap[index]['name'], style: TextStyle(fontSize: 20, color: Colors.white),),
          //                           ),
          //                         )
          //                     ),
          //                   ),
          //                 ),
          //                 SizedBox(height: 10,)
          //               ],
          //             );
          //           },
          //         ),
          //       );
          //
          //
          //     }else{
          //       return Center(
          //         child: CircularProgressIndicator(),
          //       );
          //     }
          //   },
          // )


        ],
      ),
    );
  }
  Widget buildWorkoutListView() {
    return StreamBuilder<QuerySnapshot>(
        stream: _streamExercises,
        builder: (BuildContext context,  AsyncSnapshot snapshot) {
          if( snapshot.hasError){
            return Center(child: Text('Some error occured ${snapshot.error}'),);
          }

          if(snapshot.hasData){
            QuerySnapshot data = snapshot.data;
            List<QueryDocumentSnapshot> documents =data.docs;
            List<Map> items = documents.map((e) => {
              'name' : e['name'],
              // 'images':
            }).toList();
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                Map thisItem = items[index];
                return ListTile(title: Text(thisItem['name'].toString()),);
              },
            );
          }
          return Center(child: CircularProgressIndicator());
        }
    );
  }
}