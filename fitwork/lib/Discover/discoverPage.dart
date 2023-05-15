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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          // ElevatedButton(onPressed: () {
          //
          // }, child: Text(widget.email)),
          SizedBox(height: 15,),
          Text('Discover Exercises', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
          SizedBox(height: 15,),
          StreamBuilder<QuerySnapshot> (
            stream: FirebaseFirestore.instance.collection("workout").snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
              if(snapshot.hasData){
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
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => DiscoverWorkout(name: snap[index]['name'],)));
                            },
                            child: Container(
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                image: DecorationImage(
                                  image: NetworkImage(snap[index]['image'].toString()),
                                  // image: AssetImage('assets/images/Workout/chest.jpg'),
                                  fit:BoxFit.cover,
                                ),
                              ),
                              child: Card(
                                  color: Colors.transparent,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(snap[index]['name'], style: TextStyle(fontSize: 20, color: Colors.white),),
                                    ),
                                  )
                              ),
                            ),
                          ),
                          SizedBox(height: 10,)
                        ],
                      );
                    },
                  ),
                );


              }else{
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
}