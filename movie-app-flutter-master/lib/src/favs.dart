// ignore_for_file: no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class Favs extends StatefulWidget {
  Favs({Key? key}) : super(key: key);

  @override
  State<Favs> createState() => _FavsState();
}

class _FavsState extends State<Favs> {
  final fire_store_coll = FirebaseFirestore.instance.collection('favs');

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
        title: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Text("Watch List",
              style: GoogleFonts.poppins(
                fontSize: 30,
                // color: Color.fromARGB(255, 200, 182, 182),
                color: const Color.fromARGB(255, 233, 228, 228),
                fontWeight: FontWeight.bold,
              )),
        ),
        backgroundColor: const Color.fromARGB(255, 17, 4, 30),
      ),
      body: Container(
        height: 900,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              // Color.fromARGB(255, 27, 20, 34),
              Color.fromARGB(255, 20, 4, 35),
              Color.fromARGB(255, 0, 0, 0),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 25),
          child: SingleChildScrollView(
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
                itemCount: data.length,
                itemBuilder: (context, index) {
                  Favmovie movie = data[index];
                  return ListTile(
                    leading: Checkbox(
                      fillColor:
                          MaterialStateProperty.resolveWith<Color>((states) {
                        if (states.contains(MaterialState.disabled)) {
                          return const Color.fromARGB(255, 226, 92, 77);
                        }
                        return const Color.fromARGB(255, 226, 92, 77);
                      }),
                      value: movie.watched,
                      onChanged: (bool? val) {
                        if (val != null) {
                          updateFavMovWatched(movie.id, val);
                        }
                      },
                    ),
                    title: Text(movie.name,
                        style: GoogleFonts.poppins(
                          fontSize: 22,
                          color: const Color.fromARGB(255, 200, 182, 182),
                          // fontWeight: FontWeight.bold,
                        )),
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
                          icon: const Icon(
                            Icons.edit,
                            color: Color.fromARGB(255, 244, 149, 40),
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
                          icon: const Icon(
                            Icons.delete,
                            color: Color.fromARGB(255, 241, 48, 48),
                          ),
                          onPressed: () {
                            deleteFavMov(movie.id);
                          },
                        )
                      ],
                    ),
                  );
                },
              );
            },
          )),
        ),
      ),
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
