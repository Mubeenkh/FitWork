import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import './discoverWorkout.dart';

///-------------------------------------Discover Page -------------------------------------///
class Discover extends StatefulWidget {
  const Discover({
    Key? key,
    required this.userInfo,
  }) : super(key: key);
  final Map<String, dynamic> userInfo;

  @override
  State<Discover> createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> {
  TextEditingController nameWorkoutController = new TextEditingController();
  TextEditingController imageWorkoutController = new TextEditingController();

  TextEditingController updateNameWorkoutController =
      new TextEditingController();
  TextEditingController updateImageWorkoutController =
      new TextEditingController();

  //for the edit option
  bool _isShow = false;

  //Deleting a Workout
  Future<Widget> _isCollectionExits(clickedName) async {
    //Checking if the Exercise collection is empty before deleting it
    QuerySnapshot<Map<String, dynamic>> _exercisesCollection =
        await FirebaseFirestore.instance
            .collection('workout')
            .doc(clickedName)
            .collection('exercises')
            .get();

    if (_exercisesCollection.docs.isNotEmpty) {
      // print('is not empty');
      return Flushbar(
        flushbarPosition: FlushbarPosition.TOP,
        message: "Cannot delete: ${clickedName}",
        icon: Icon(
          Icons.info,
          size: 30.0,
          color: Colors.black,
        ),
        duration: Duration(seconds: 3),
        backgroundGradient: LinearGradient(
          colors: [
            Colors.red.shade500,
            Colors.red.shade300,
            Colors.red.shade100
          ],
          stops: [0.4, 0.7, 1],
        ),
      )..show(context);
      // return true;
    } else {
      // print('is empty');

      return Flushbar(
        flushbarPosition: FlushbarPosition.TOP,
        message: "Successfully deleted: ${clickedName} Workouts",

        icon: Icon(
          Icons.info,
          size: 30.0,
          color: Colors.black,
        ),
        duration: Duration(seconds: 3),
        backgroundGradient: LinearGradient(
          colors: [
            Colors.green.shade500,
            Colors.green.shade300,
            Colors.green.shade100
          ],
          stops: [0.4, 0.7, 1],
        ),
      )..show(context).then((value) {
        // FirebaseFirestore.instance.collection('workout').doc(clickedName).collection('exercises').doc().delete();
        FirebaseFirestore.instance.collection('workout').doc(clickedName).delete();
      });


      // FirebaseFirestore.instance.collection('workout').doc(clickedName).collection('exercises').doc().delete();
      // return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          // Text('Discover Workout', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
          _showAddWorkoutAdminButton(),

          SizedBox(
            height: 15,
          ),

          StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection("workout").snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                final snap = snapshot.data!.docs;
                return Expanded(
                  // height: 566,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: snap.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (widget.userInfo['type'] == "admin") {
                                _showAdminClickedCard(snap, index);
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DiscoverWorkout(
                                            name: snap[index]['name'],
                                            userInfo: widget.userInfo)));
                              }
                            },
                            child: Container(
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                image: DecorationImage(
                                  // image: NetworkImage(snap[index]['image'].toString()),
                                  image: AssetImage(
                                      snap[index]['image'].toString()),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Card(
                                color: Colors.transparent,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                      snap[index]['name'],
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      );
                    },
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )
        ],
      ),
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

  _showAddWorkoutAdminButton() {
    if (widget.userInfo['type'] == "admin") {
      return ElevatedButton(
        style: _buttonStyle(),
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
                    Text("Add Workout"),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        "Name: ",
                        textAlign: TextAlign.start,
                      ),
                    ),
                    TextField(
                      decoration: InputDecoration(
                          filled: true, fillColor: Colors.white,hintText: "Workout Name"),
                      controller: nameWorkoutController,

                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text("Image: "),
                    ),
                    TextField(
                      decoration: InputDecoration(
                          filled: true, fillColor: Colors.white,hintText: "Workout Image"),
                      controller: imageWorkoutController,
                    ),
                  ],
                ),
                actions: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: ElevatedButton(
                      style: _buttonStyle(),
                      // color: Colors.red,
                      onPressed: () {
                        Navigator.of(context).pop();
                        nameWorkoutController.clear();
                        imageWorkoutController.clear();
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
                      //TODO: Firestore create a new record code

                      Map<String, dynamic> Workout = new Map<String, dynamic>();
                      Workout['name'] = nameWorkoutController.text;
                      Workout['image'] = imageWorkoutController.text;
                      // //todo: send to database

                      FirebaseFirestore.instance
                          .collection("workout")
                          .doc(Workout['name'])
                          .set(Workout);
                      Navigator.pop(context);
                      nameWorkoutController.clear();
                      imageWorkoutController.clear();
                    },
                    child: Text(
                      "Add Workout",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              );
            },
          );
        },
        child: Text('Add Workout'),
      );
    } else {
      return Text(
        'Discover Workout',
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      );
    }
  }

  _showAdminClickedCard(snap, index) {
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
                      setState(
                        () {
                          _isShow = false;
                        },
                      );
                      Navigator.of(context).pop();
                      updateNameWorkoutController.clear();
                      updateImageWorkoutController.clear();
                    },
                    child: Text(
                      'Back',
                      style: TextStyle(color: Color(0xff3C615A)),
                    ),
                  ),
                ),
                Visibility(
                  visible: _isShow,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          "Name: ",
                          textAlign: TextAlign.start,
                        ),
                      ),
                      TextField(
                          decoration: InputDecoration(
                              filled: true, fillColor: Colors.white),
                          controller: updateNameWorkoutController),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text("Image: "),
                      ),
                      TextField(
                          decoration: InputDecoration(
                              filled: true, fillColor: Colors.white),
                          controller: updateImageWorkoutController),
                      ElevatedButton(
                          style: _buttonStyle(),
                          onPressed: () {
                            //  Firebase
                            Map<String, dynamic> updateWorkout =
                                new Map<String, dynamic>();
                            updateWorkout['name'] =
                                updateNameWorkoutController.text;
                            updateWorkout['image'] =
                                updateImageWorkoutController.text;

                            // Update Firestore record information regular way
                            FirebaseFirestore.instance
                                .collection("workout")
                                .doc(updateWorkout['name'])
                                .update(updateWorkout)
                                .whenComplete(() {
                              Navigator.pop(context);
                              updateNameWorkoutController.clear();
                              updateImageWorkoutController.clear();
                              setState(() {
                                _isShow = false;
                              });
                            });
                          },
                          child: Text('Save Change'))
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(
                      // color: Colors.red,
                      style: _buttonStyle(),
                      onPressed: () {
                        updateNameWorkoutController.text = snap[index]['name'];
                        updateImageWorkoutController.text =
                            snap[index]['image'];
                        setState(() {
                          _isShow = !_isShow;
                        });
                      },
                      child: Text(_isShow ? 'Hide Edit' : 'Show Edit',
                          style: TextStyle(color: Colors.white)),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      // color: Colors.red,
                      style: _buttonStyle(),
                      onPressed: () {
                        _isCollectionExits(snap[index]['name']);
                      },
                      child: Text(
                        'Delete',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      style: _buttonStyle(),
                      onPressed: () {
                        //TODO: Firestore create a new record code
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DiscoverWorkout(
                                    name: snap[index]['name'],
                                    userInfo: widget.userInfo)));
                      },
                      child: Text("View Exerciese",
                          style: TextStyle(color: Colors.white)),
                    ),
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
