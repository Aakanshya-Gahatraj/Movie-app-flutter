// ignore_for_file: no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class Favs extends StatefulWidget {
  // String text;
  // Favs({Key? key, required this.text}) : super(key: key);
  Favs({Key? key}) : super(key: key);

  @override
  // State<Favs> createState() => _FavsState(text);
  State<Favs> createState() => _FavsState();
}

// class _FavsState extends State<Favs> {
class _FavsState extends State<Favs> {
  // List<String> watchList = ["Stranger Things", "Flower of Evil"];
  List<String> watchList = ["hello", "lemon"];
  final fire_store_coll = FirebaseFirestore.instance.collection('favs');
  // String text;
  // _FavsState(this.text);

  @override
  // void initState() {
  //   super.initState();
  //   readFavs();
  //   // watchList.add(text);
  // }

  Stream<List<Favmovie>> readFavs() =>
      fire_store_coll.snapshots().map((snapshot) => snapshot.docs
          .map((doc) => Favmovie.fromJson(doc.id, doc.data()))
          .toList());
  Future updateFavMovRating(String id, int rating) async {
    var docFavMov = fire_store_coll.doc(id);
    await docFavMov.update({'rating': rating});
  }

  Future deleteFavMov(String id) async {
    var docFavMov = fire_store_coll.doc(id);
    await docFavMov.delete();
  }

  TextEditingController ratingController = TextEditingController();

  Future updateFavMovWatched(String id, bool watched) async {
    var docFavMov = fire_store_coll.doc(id);
    await docFavMov.update({'watched': watched});
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
          child: StreamBuilder(
        stream: readFavs(),
        builder:
            (BuildContext context, AsyncSnapshot<List<Favmovie>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          var data = snapshot.data!;
          return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: data.length,
            itemBuilder: (context, index) {
              Favmovie movie = data[index];
              return ListTile(
                leading: Checkbox(
                  fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                    if (states.contains(MaterialState.disabled)) {
                      return Colors.orange.withOpacity(.32);
                    }
                    return Colors.orange;
                  }),
                  value: movie.watched,
                  onChanged: (bool? val) {
                    if (val != null) {
                      updateFavMovWatched(movie.id, val);
                    }
                  },
                ),
                title: Text(movie.name,
                    style: TextStyle(color: Colors.white, fontSize: 16)),
                subtitle: Row(
                  children: [
                    for (int i = 0; i < movie.rating; i++)
                      Icon(
                        Icons.star,
                        color: Colors.amber[200],
                      )
                  ],
                ),
                trailing: Wrap(
                  spacing: 5.0,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Color.fromARGB(255, 58, 48, 241),
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text("Update Watch List"),
                            content: TextFormField(
                                decoration: const InputDecoration(
                                  label: Text('Rating'),
                                ),
                                controller: ratingController,
                                keyboardType: TextInputType.number,
                                autovalidateMode: AutovalidateMode
                                    .onUserInteraction, // to instantly valid the input
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                validator: (String? value) {
                                  if (value == null || value.isEmpty)
                                    return "Enter number";
                                  else if (int.parse(value) <= 0 ||
                                      int.parse(value) > 5)
                                    return "only 1-5 valid";
                                  else
                                    return null;
                                }),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  updateFavMovRating(movie.id,
                                      int.parse(ratingController.text));
                                },
                                child: Container(
                                  color: Colors.green,
                                  padding: const EdgeInsets.all(14),
                                  child: const Text(
                                    "Update",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Color.fromARGB(255, 241, 48, 48),
                      ),
                      onPressed: () {
                        deleteFavMov(movie.id);
                      },
                    )
                  ],
                ),
                // tileColor: Color,
              );
            },
          );
        },
      )),
    );
  }
}

class Favmovie {
  final String id;
  final String name;
  final bool watched;
  final int rating;
  Favmovie(this.id,
      {required this.name, required this.watched, required this.rating});

  static Favmovie fromJson(String id, Map<String, dynamic> json) => Favmovie(id,
      name: json['name'], watched: json['watched'], rating: json['rating']);
}
