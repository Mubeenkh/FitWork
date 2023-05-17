import 'package:another_flushbar/flushbar.dart';
import 'package:fitwork/FirebaseSample.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../Home/homePage.dart';

class DiscoverWorkout extends StatefulWidget {
  const DiscoverWorkout({Key? key, required this.name, required this.userInfo}) : super(key: key);
  final String name;
  final Map<String,dynamic> userInfo;
  @override
  State<DiscoverWorkout> createState() => _DiscoverWorkoutState();
}

class _DiscoverWorkoutState extends State<DiscoverWorkout> {

  TextEditingController nameController = new TextEditingController();
  TextEditingController imageController = new TextEditingController();

  TextEditingController updateNameExerciseController = new TextEditingController();
  TextEditingController updateImageExerciseController = new TextEditingController();


  late  DocumentReference _documentReference = FirebaseFirestore.instance.collection('workout').doc(widget.name);

  late CollectionReference _referenceExercises =  _documentReference.collection('exercises');
  late Stream<QuerySnapshot> _streamExercises = _referenceExercises.snapshots();

  //-------------- This is the entire proccess for updating the thingy --------------//
  int exerciseIndex = 0;
  String exerciseId = '';
  _getExerciseLenght(index){
    setState(() {
      exerciseIndex = index;
      // print(exerciseIndex);
    });
  }
  Future<void> _getDocumentID() async {
    List list = [];
    await FirebaseFirestore.instance.collection('workout').doc(widget.name).collection('exercises').get().then((value) {
      for(var val in value.docs){
        list.add(val.id);
      }
    });
    String num = await FirebaseFirestore.instance.collection('workout').doc(widget.name).collection('exercises').doc(list[exerciseIndex]).id;
    // print(list);
    // print('$exerciseIndex : $num');
    exerciseId =  num;
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
            title: Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
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
            color: Color(0xffbad9c1),
          ),
          child: Center(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _showAdminButton(),

                Expanded(child: buildWorkoutListView())

              ],
            ),
          ),
        ),
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
              'image' : e['image']
            }).toList();
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                Map exerciseItem = items[index];
                return GestureDetector(
                  onTap: () {

                    if(widget.userInfo['type'] == "admin"){

                      updateNameExerciseController.text = exerciseItem['name'];
                      updateImageExerciseController.text = exerciseItem['image'];
                      // String exerciseDocumentId = exerciseItem['name'];
                      _getDocumentID();
                      _showAdminEditAlertDialog(exerciseItem, index);
                    }
                    // Flushbar(
                    //   flushbarPosition: FlushbarPosition.TOP,
                    //   message: "Cannot delete:",
                    //   icon: Icon(
                    //     Icons.info,
                    //     size: 30.0,
                    //     color: Colors.black,
                    //   ),
                    //   duration: Duration(seconds: 3),
                    //   backgroundGradient: LinearGradient(
                    //     colors: [
                    //       Colors.red.shade500,
                    //       Colors.red.shade300,
                    //       Colors.red.shade100
                    //     ],
                    //     stops: [0.4, 0.7, 1],
                    //   ),
                    // )..show(context);
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black54),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      // padding: EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
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
                            exerciseItem['name'].toString(),
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Image.asset(exerciseItem['image'], height: 100,)
                        ],
                      ),
                    ),
                  ),
                );

              },
            );
          }
          return Center(child: CircularProgressIndicator());
        }
    );
  }

  _showAdminButton() {

    if( widget.userInfo['type'] == "admin"){
      return ElevatedButton(
          style: ElevatedButton.styleFrom(
            shadowColor: Colors.black,
            elevation: 20,
            backgroundColor:  Color(0xff5FB28B),
            side: BorderSide(
              width: 3,
              color: Color(0xff3C615A) ,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            // onPrimary: Color(0xff1F3040),
          ),
        onPressed: () {

          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Add Exercise"),
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
                        controller: imageController,
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
                          'name': nameController.text,
                          'image': imageController.text
                        };
                        // _referenceExercises.add(exerciseToAdd);
                        _referenceExercises.doc(exerciseToAdd['name']).set(exerciseToAdd);
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
        child: Text('Add Exercise'),
      );
    }else {
      return Text(
        '${widget.name} Exercise',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
      );
    }
  }

  _showAdminEditAlertDialog( exerciseItem, exerciseDocumentId) {
    _getExerciseLenght(exerciseDocumentId);
    return showDialog(
      // barrierColor: Color(0xff3C615A),
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            backgroundColor: Color(0xffbad9c1),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      side: BorderSide(
                        width: 3,
                        color: Color(0xff3C615A),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      updateImageExerciseController.clear();
                      updateNameExerciseController.clear();
                    },
                    child: Text(
                      'Back',
                      style: TextStyle(color: Color(0xff3C615A)),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      "Name: ",
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
                TextField(
                    decoration: InputDecoration(
                        filled: true, fillColor: Colors.white, hintText: 'Exercise Name'),
                    controller: updateNameExerciseController),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text("Image: "),
                  ),
                ),
                TextField(
                    decoration: InputDecoration(
                        filled: true, fillColor: Colors.white, hintText: 'Exercise Image'),
                    controller: updateImageExerciseController,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: _buttonStyle(),
                        onPressed: () {

                          Map<String, dynamic> updateWorkout = new Map<String, dynamic>();
                          updateWorkout['name'] = updateNameExerciseController.text;
                          updateWorkout['image'] = updateImageExerciseController.text;
                          print(updateWorkout);

                          // _getDocumentID(exerciseItem['name']);
                          // _getDocumentID();
                          FirebaseFirestore.instance
                              .collection("workout")
                              .doc(widget.name)
                              .collection('exercises')
                              .doc(exerciseId)
                              .update(updateWorkout)
                              .whenComplete(() {
                            Navigator.pop(context);
                            updateImageExerciseController.clear();
                            updateNameExerciseController.clear();
                            exerciseId = '';
                          });

                        },
                        child: Text('Save Change'),
                      ),
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      child: ElevatedButton(
                        style: _buttonStyle(),
                        onPressed: () {

                          Map<String, dynamic> updateWorkout =
                          new Map<String, dynamic>();

                          FirebaseFirestore.instance
                              .collection("workout")
                              .doc(updateWorkout['name'])
                              .update(updateWorkout)
                              .whenComplete(() {
                            Navigator.pop(context);
                            updateImageExerciseController.clear();
                            updateNameExerciseController.clear();
                          });
                        },
                        child: Text('Delete'),
                      ),
                    )
                  ],
                )


              ],
            ),
          );
        });
      },
    );
  }
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

// Widget listStuff(Exercises) {
//   List<Widget> list = [];
//
//   Exercises.forEach(
//     (key, value) {
//       print(key);
//       print(value['stringExample']);
//       // list.add(new Text(key));
//       // list.add(new Text(value['stringExample']));
//       list.add(
//         new Card(
//           shape: RoundedRectangleBorder(
//             side: BorderSide(color: Colors.black54),
//             borderRadius: BorderRadius.circular(20.0),
//           ),
//           child: Container(
//             padding: EdgeInsets.all(8),
//             // padding: EdgeInsets.all(20.0),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(20.0),
//               gradient: LinearGradient(
//                 colors: [
//                   Color(0xff3C6B62),
//                   Color(0xff1B2826),
//                 ],
//               ),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   key,
//                   style: TextStyle(
//                       fontSize: 30,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white),
//                 ),
//                 Image.asset('assets/images/sampleWorkout.png')
//               ],
//             ),
//           ),
//         ),
//       );
//     },
//   );
//   return new Column(children: list);
// }

// Widget cardContent(text) {
//   return GestureDetector(
//     onTap: () {
//       print('workout time');
//     },
//     child: Card(
//       shape: RoundedRectangleBorder(
//           side: BorderSide(color: Colors.black54),
//           borderRadius: BorderRadius.circular(5.0),
//       ),
//       child: Container(
//         padding: EdgeInsets.all(8),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(5.0),
//           gradient: LinearGradient(
//             colors: [
//               Color(0xff3C6B62),
//               Color(0xff1B2826),
//             ],
//           ),
//         ),
//         // padding: EdgeInsets.all(20.0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               text,
//               style: TextStyle(
//                   fontSize: 30,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white),
//             ),
//             Image.asset('assets/images/Workout/leg.jpg')
//           ],
//         ),
//       ),
//     ),
//   );
// }
