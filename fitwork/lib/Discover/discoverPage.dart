
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

  TextEditingController updateNameWorkoutController = new TextEditingController();
  TextEditingController updateImageWorkoutController = new TextEditingController();

  bool _isShow = false;

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
          _showAdminButton(),

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
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => DiscoverWorkout(
                              //             name: snap[index]['name'],
                              //             userInfo: widget.userInfo)));
                              if (widget.userInfo['type'] == "admin") {
                                showDialog(
                                  // barrierColor: Color(0xff3C615A),
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return StatefulBuilder(
                                        builder: (context, setState) {
                                      return AlertDialog(
                                        backgroundColor: Color(0xffbad9c1),
                                        content: Visibility(
                                          visible: _isShow,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(top: 10),
                                                child: Text(
                                                  "Name: ",
                                                  textAlign: TextAlign.start,
                                                ),
                                              ),
                                              TextField(
                                                controller:
                                                    updateNameWorkoutController,
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(top: 20),
                                                child: Text("Image: "),
                                              ),
                                              TextField(
                                                controller:
                                                  updateImageWorkoutController,
                                              ),
                                              ElevatedButton(
                                                  onPressed: () {
                                                    //  Firebase

                                                    Map<String, dynamic> updateWorkout = new Map<String, dynamic>();
                                                    updateWorkout['name'] = updateNameWorkoutController.text;
                                                    updateWorkout['image'] = updateImageWorkoutController.text;

                                                    // Updae Firestore record information regular way
                                                    FirebaseFirestore.instance
                                                        .collection("workout")
                                                        .doc(updateWorkout['name'])
                                                        .update(updateWorkout)
                                                        .whenComplete(() {
                                                        Navigator.pop(context);
                                                        updateNameWorkoutController.clear();
                                                        updateImageWorkoutController.clear();
                                                        setState(
                                                              () {
                                                            _isShow = false;
                                                          },
                                                        );
                                                    });


                                                  },
                                                  child: Text('Save Change'))
                                            ],
                                          ),
                                        ),
                                        actions: <Widget>[
                                          Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: ElevatedButton(
                                                      // color: Colors.red,
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
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                    child: ElevatedButton(
                                                      // color: Colors.red,
                                                      onPressed: () {
                                                        updateNameWorkoutController.text = snap[index]['name'];
                                                        updateImageWorkoutController.text = snap[index]['image'];
                                                        setState(
                                                          () {
                                                            _isShow = !_isShow;
                                                          },
                                                        );
                                                        // Navigator.of(context).pop();
                                                      },
                                                      child: Text(
                                                        _isShow
                                                            ? 'Hide Edit'
                                                            : 'Show Edit',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  //TODO: Firestore create a new record code
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              DiscoverWorkout(
                                                                  name: snap[
                                                                          index]
                                                                      ['name'],
                                                                  userInfo: widget
                                                                      .userInfo)));
                                                },
                                                child: Text(
                                                  "View Exerciese",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ],
                                          ),

                                          // ElevatedButton(
                                          //   // color: Colors.red,
                                          //   onPressed: () {
                                          //     Navigator.of(context).pop();
                                          //   },
                                          //   child: Text(
                                          //     'Back',
                                          //     style: TextStyle(color: Colors.white),
                                          //   ),
                                          // ),
                                          // ElevatedButton(
                                          //   // color: Colors.red,
                                          //   onPressed: () {
                                          //     setState(
                                          //           () {
                                          //         _isShow = !_isShow;
                                          //       },
                                          //     );
                                          //     // Navigator.of(context).pop();
                                          //   },
                                          //   child: Text(
                                          //     _isShow ? 'Hide' : 'Show',
                                          //     style: TextStyle(color: Colors.white),
                                          //   ),
                                          // ),
                                          //
                                          // ElevatedButton(
                                          //   onPressed: () {
                                          //     //TODO: Firestore create a new record code
                                          //     Navigator.push(
                                          //         context,
                                          //         MaterialPageRoute(
                                          //             builder: (context) => DiscoverWorkout(
                                          //                 name: snap[index]['name'],
                                          //                 userInfo: widget.userInfo)));
                                          //
                                          //   },
                                          //   child: Text(
                                          //     "View Exerciese",
                                          //     style: TextStyle(color: Colors.white),
                                          //   ),
                                          // ),
                                        ],
                                      );
                                    });
                                  },
                                );
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

  _showAdminButton() {
    if (widget.userInfo['type'] == "admin") {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
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
                    Text("Add Workout"),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        "Name: ",
                        textAlign: TextAlign.start,
                      ),
                    ),
                    TextField(
                      controller: nameWorkoutController,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text("Image: "),
                    ),
                    TextField(
                      controller: imageWorkoutController,
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
}
