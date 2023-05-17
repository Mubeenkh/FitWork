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
  // TextEditingController nameController = new TextEditingController();
  // TextEditingController imageController = new TextEditingController();


  TextEditingController nameController = new TextEditingController();
  TextEditingController imageController = new TextEditingController();

  late  DocumentReference _documentReference = FirebaseFirestore.instance.collection('workout').doc(widget.name);

  late CollectionReference _referenceExercises =  _documentReference.collection('exercises');
  late Stream<QuerySnapshot> _streamExercises = _referenceExercises.snapshots();

  //--------------

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
              // 'images':
            }).toList();
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                Map thisItem = items[index];
                // return ListTile(title: Text(thisItem['name'].toString()),);
                return Card(
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
                          thisItem['name'].toString(),
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Image.asset(thisItem['image'].toString(), height: 100,)
                      ],
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
        child: Text('Add Exercise'),
      );
    }else {
      return Text(
        '${widget.name} Exercise',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
      );
    }
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
          borderRadius: BorderRadius.circular(5.0)),
      // shape: CircleBorder(
      //   side: BorderSide(color: Colors.white)
      // ),
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
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
