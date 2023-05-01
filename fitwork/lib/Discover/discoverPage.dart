import 'package:flutter/material.dart';
import './discoverWorkout.dart';

///-------------------------------------Discover Page -------------------------------------///
class Discover extends StatefulWidget {
  const Discover({Key? key}) : super(key: key);

  @override
  State<Discover> createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Dsicover page'),
        ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  DiscoverWorkout(),));
            },
            child: Text('Discover Workout'),
        ),
      ],
    );
  }
}