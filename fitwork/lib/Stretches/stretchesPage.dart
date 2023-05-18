import 'dart:convert';

import 'package:duration_button/duration_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///-------------------------------------Stretches Page -------------------------------------///
class Stretches extends StatefulWidget {
  const Stretches({Key? key}) : super(key: key);

  @override
  State<Stretches> createState() => _StretchesState();
}

class _StretchesState extends State<Stretches> {
  List _items = [];

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/stretches.json');
    final data = await json.decode(response);
    setState(() {
      _items = data["stretches"];
      print("${_items.length}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Cool Down Stretches",style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          ),
        ),
        _items.isNotEmpty
            ? Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: _items.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                              image: AssetImage(
                                  _items[index]["image"],
                              ),
                              fit: BoxFit.cover
                            )
                          ),
                          child: Card(
                            color: Colors.transparent,
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                    _items[index]["name"],
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 5,)
                      ],
                    );
                  },
                ),
              )
            : OutlinedDurationButton(
              border: Border.all(
                color: Color(0xff3C615A)
              ),
              coverColor: Color(0xff5FB28B),
              child: Text('Loading...'),
              onPressed: () => readJson(),
              duration: const Duration(seconds: 1),
            ),
        // IconDurationButton(
        //       Icons.favorite,
        //       size: 30,
        //       iconColor: Colors.pink,
        //       onPressed: () => readJson(),
        //       duration: const Duration(seconds: 2),
        //     ),
        // ElevatedButton(
        //         style: _buttonStyle(),
        //         onPressed: () {
        //           readJson();
        //         },
        //         child: Text("Load Stretches"),
        //       )
      ],
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
