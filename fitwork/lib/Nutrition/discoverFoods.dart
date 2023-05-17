import 'package:fitwork/FirebaseSample.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../Home/homePage.dart';

class DiscoverFoods extends StatefulWidget {
  const DiscoverFoods({Key? key, required this.name, required this.userInfo}) : super(key: key);
  final String name;
  final Map<String,dynamic> userInfo;

  @override
  State<DiscoverFoods> createState() => _DiscoverFoodsState();
}

class _DiscoverFoodsState extends State<DiscoverFoods> {

  TextEditingController nameController = new TextEditingController();
  TextEditingController imageController = new TextEditingController();

  TextEditingController updateNameNutritionController = new TextEditingController();
  TextEditingController updateImageNutritionController = new TextEditingController();



  late  DocumentReference _documentReference = FirebaseFirestore.instance.collection('nutrition').doc(widget.name);

  late CollectionReference _referenceFoods =  _documentReference.collection('foods');
  late Stream<QuerySnapshot> _streamFoods = _referenceFoods.snapshots();

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
            color: Color(0xffbad9c1),
          ),
          child: Center(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _showAdminButton(),

                Expanded(child: buildNutritionListView())

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildNutritionListView() {
    return StreamBuilder<QuerySnapshot>(
        stream: _streamFoods,
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
              // 'images':
            }).toList();
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                Map foodItem = items[index];
                // return ListTile(title: Text(thisItem['name'].toString()),);
                return GestureDetector(
                  onTap: () {
                    if(widget.userInfo['type'] == "admin"){
                      _showAdminEditAlertDialog(foodItem, index);
                    }
                  },
                  child: Card(
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
                            foodItem['name'].toString(),
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Image.asset(foodItem['image'], height: 100,)
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
                      Text("Add Food"),
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

                        Map<String, dynamic> foodToAdd= {
                          'name': nameController.text,
                          'image': imageController.text
                        };
                        _referenceFoods.add(foodToAdd);
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
        child: Text('Add Food'),
      );
    }else {
      return Text(
        '${widget.name}',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
      );
    }
  }
  _showAdminEditAlertDialog(foodItem, documentId) {

    updateNameNutritionController.text = foodItem['name'];
    updateImageNutritionController.text = foodItem['image'];

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
                      updateImageNutritionController.clear();
                      updateNameNutritionController.clear();
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
                        filled: true, fillColor: Colors.white, hintText: 'Food Name'),
                    controller: updateNameNutritionController),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text("Image: "),
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                      filled: true, fillColor: Colors.white, hintText: 'Food Image'),
                  controller: updateImageNutritionController,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: _buttonStyle(),
                        onPressed: () {

                          Map<String, dynamic> updateFood =
                          new Map<String, dynamic>();
                          updateFood['name'] = updateNameNutritionController.text;
                          updateFood['image'] = 'assets/images/Nutrition/${updateImageNutritionController.text}';
                          print(updateFood);
                          FirebaseFirestore.instance
                              .collection("nutrition")
                              .doc(widget.name)
                              .collection(updateFood['name'])
                              .doc(documentId)
                              .update(updateFood)
                              .whenComplete(() {
                            Navigator.pop(context);
                            updateImageNutritionController.clear();
                            updateNameNutritionController.clear();
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

                          Map<String, dynamic> updateFood =
                          new Map<String, dynamic>();

                          FirebaseFirestore.instance
                              .collection("nutrition")
                              .doc(updateFood['name'])
                              .update(updateFood)
                              .whenComplete(() {
                            Navigator.pop(context);
                            updateImageNutritionController.clear();
                            updateNameNutritionController.clear();
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


