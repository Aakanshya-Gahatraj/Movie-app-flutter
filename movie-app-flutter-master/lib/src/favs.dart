// ignore_for_file: no_logic_in_create_state

import 'package:flutter/material.dart';

class Favs extends StatefulWidget {
  String text;
  Favs({Key? key, required this.text}) : super(key: key);
  // Favs({Key? key}) : super(key: key);

  @override
  State<Favs> createState() => _FavsState(text);
  // State<Favs> createState() => _FavsState();
}

class _FavsState extends State<Favs> {
  List<String> watchList = ["Stranger Things", "Flower of Evil"];
  // List<String> watchList = ["hello", "lemon"];

  String text;
  _FavsState(this.text);

  @override
  void initState() {
    super.initState();
    watchList.add(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
          title: Text("Watch List",
              style: TextStyle(color: Colors.white, fontSize: 25)),
          backgroundColor: Color.fromARGB(0, 6, 6, 6)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 15),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: watchList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(
                    Icons.favorite,
                    color: Colors.red[300],
                  ),
                  title: Text(watchList[index],
                      style: TextStyle(color: Colors.white, fontSize: 25)),
                  // tileColor: Color,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
