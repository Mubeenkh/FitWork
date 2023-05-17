import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../Nutrition/discoverFoods.dart';


///-------------------------------------Nutrition Page -------------------------------------///
class Nutrition extends StatefulWidget {
  const Nutrition({
    Key? key,
    required this.userInfo,
  }) : super(key: key);
  final Map<String, dynamic> userInfo;

  @override
  State<Nutrition> createState() => _NutritionState();
}

class _NutritionState extends State<Nutrition> {
  TextEditingController nameNutritionController = new TextEditingController();
  TextEditingController imageNutritionController = new TextEditingController();

  TextEditingController updateNameNutritionController =
  new TextEditingController();
  TextEditingController updateImageNutritionController =
  new TextEditingController();

  //for the edit option
  bool _isShow = false;

  //Deletting
  Future<Widget> _isCollectionExits(clickedName) async {
    QuerySnapshot<Map<String, dynamic>> _foodsCollection =
    await FirebaseFirestore.instance
        .collection('nutrition')
        .doc(clickedName)
        .collection('foods')
        .get();

    if (_foodsCollection.docs.isNotEmpty) {
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
        message: "Successfully deleted: ${clickedName} Foods",

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
        FirebaseFirestore.instance.collection('nutrition').doc(clickedName).delete();
      });
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
          _showAddNutritionAdminButton(),

          SizedBox(
            height: 15,
          ),

          StreamBuilder<QuerySnapshot>(
            stream:
            FirebaseFirestore.instance.collection("nutrition").snapshots(),
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
                                        builder: (context) => DiscoverFoods(
                                            name: snap[index]['name'],
                                            userInfo: widget.userInfo
                                        )
                                    )
                                );
                              }
                            },
                            child: Container(
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                image: DecorationImage(
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

  _showAddNutritionAdminButton() {
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
                    Text("Add Nutrition"),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        "Name: ",
                        textAlign: TextAlign.start,
                      ),
                    ),
                    TextField(
                      decoration: InputDecoration(
                          filled: true, fillColor: Colors.white,hintText: "Nutrition Name"),
                      controller: nameNutritionController,

                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text("Image: "),
                    ),
                    TextField(
                      decoration: InputDecoration(
                          filled: true, fillColor: Colors.white,hintText: "Nutrition Image"),
                      controller: imageNutritionController,
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
                        nameNutritionController.clear();
                        imageNutritionController.clear();
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

                      Map<String, dynamic> Nutrition = new Map<String, dynamic>();
                      Nutrition['name'] = nameNutritionController.text;
                      Nutrition['image'] = imageNutritionController.text;
                      // //todo: send to database

                      FirebaseFirestore.instance
                          .collection("nutrition")
                          .doc(Nutrition['name'])
                          .set(Nutrition);
                      Navigator.pop(context);
                      nameNutritionController.clear();
                      imageNutritionController.clear();
                    },
                    child: Text(
                      "Add Nutrition",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              );
            },
          );
        },
        child: Text('Add Nutrition'),
      );
    } else {
      return Text(
        'Nutrition',
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
                      updateNameNutritionController.clear();
                      updateImageNutritionController.clear();
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
                          controller: updateNameNutritionController),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text("Image: "),
                      ),
                      TextField(
                          decoration: InputDecoration(
                              filled: true, fillColor: Colors.white),
                          controller: updateImageNutritionController),
                      ElevatedButton(
                          style: _buttonStyle(),
                          onPressed: () {
                            //  Firebase
                            Map<String, dynamic> updateNutrition =
                            new Map<String, dynamic>();
                            updateNutrition['name'] =
                                updateNameNutritionController.text;
                            updateNutrition['image'] =
                                updateImageNutritionController.text;

                            // Update Firestore record information regular way
                            FirebaseFirestore.instance
                                .collection("nutrition")
                                .doc(updateNutrition['name'])
                                .update(updateNutrition)
                                .whenComplete(() {
                              Navigator.pop(context);
                              updateNameNutritionController.clear();
                              updateImageNutritionController.clear();
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
                        updateNameNutritionController.text = snap[index]['name'];
                        updateImageNutritionController.text =
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
                                builder: (context) => DiscoverFoods(
                                    name: snap[index]['name'],
                                    userInfo: widget.userInfo)));
                      },
                      child: Text("View Foods",
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