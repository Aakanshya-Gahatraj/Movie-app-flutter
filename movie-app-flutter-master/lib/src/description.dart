import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:movie_app/src/favs.dart';
import 'package:movie_app/src/home.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MovieDesc extends StatefulWidget {
  const MovieDesc(
      {Key? key,
      required this.name,
      required this.description,
      required this.bannerurl,
      required this.posterurl,
      required this.vote,
      required this.launch_on})
      : super(key: key);

  final String name, description, bannerurl, posterurl, vote, launch_on;

  @override
  State<MovieDesc> createState() =>
      // ignore: no_logic_in_create_state
      _MovieDescState(name, description, bannerurl, posterurl, vote, launch_on);
}

class _MovieDescState extends State<MovieDesc> {
  String name, description, bannerurl, posterurl, vote, launch_on;
  _MovieDescState(this.name, this.description, this.bannerurl, this.posterurl,
      this.vote, this.launch_on);

  Future createFav(
      {required String name,
      required bool watched,
      required int rating}) async {
    final db = FirebaseFirestore.instance.collection('favs').doc();

    final json = {'name': name, 'watched': watched, 'rating': rating};

    await db.set(json);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Color.fromARGB(255, 252, 251, 251)),
          onPressed: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const HomeScreen())),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
              height: 260,
              child: Stack(children: [
                Positioned(
                  child: SizedBox(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    child: Image.network(
                      bannerurl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                    top: 80,
                    left: 170,
                    child: IconButton(
                        icon: Icon(Icons.play_circle_filled_outlined,
                            color: Colors.yellow[700], size: 60),
                        onPressed: () async => await launchUrlString(
                            "https://www.youtube.com/watch?v=BdJKm16Co6M"))),
                Positioned(
                  bottom: 8,
                  child: Container(
                      width: 393,
                      height: 35,
                      color: Color.fromARGB(116, 33, 29, 29),
                      // ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5, left: 20),
                        child: Text(
                          '⭐  Rating: ' + vote,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                      )),
                )
              ])),
          const SizedBox(height: 15),
          Container(
              padding: const EdgeInsets.all(20),
              child: Text(
                name,
                style: GoogleFonts.poppins(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(
                      255, 233, 228, 228), // fontWeight: FontWeight.bold,
                ),
              )),
          const SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              "Release Date:  " + launch_on,
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Color.fromARGB(
                    255, 233, 228, 228), // fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Flexible(
              child: SizedBox(
                // padding: const EdgeInsets.only(top:10,bottom: ),
                height: 140,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Text(description,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Color.fromARGB(
                            255, 233, 228, 228), // fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.justify),
                ),
              ),
            ),
            // ],
            // ),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  // padding: const EdgeInsets.only(left: 20, right: 20),
                  fixedSize: const Size(100, 50),
                  primary: const Color.fromARGB(255, 248, 60, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16), // <-- Radius
                  ),
                ),
                onPressed: () {
                  createFav(name: name, rating: 1, watched: false);
                },
                child: const Text('Add to Watch List')),
          ),
        ],
      ),
    );
  }
}

class TvDesc extends StatelessWidget {
  final String name, description, bannerurl, posterurl, vote, aired_on;

  const TvDesc(
      {Key? key,
      required this.name,
      required this.description,
      required this.bannerurl,
      required this.posterurl,
      required this.vote,
      required this.aired_on})
      : super(key: key);

  Future createFav(
      {required String name,
      required bool watched,
      required int rating}) async {
    final db = FirebaseFirestore.instance.collection('favs').doc();

    final json = {'name': name, 'watched': watched, 'rating': rating};

    await db.set(json);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Color.fromARGB(255, 252, 251, 251)),
          onPressed: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const HomeScreen())),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
              height: 260,
              child: Stack(children: [
                Positioned(
                  child: SizedBox(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    child: Image.network(
                      bannerurl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 8,
                  child: Container(
                      width: 393,
                      height: 35,
                      color: Color.fromARGB(116, 33, 29, 29),
                      // ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5, left: 20),
                        child: Text('⭐  Rating: ' + vote,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            )),
                      )),
                )
              ])),
          const SizedBox(height: 15),
          Container(
              padding: const EdgeInsets.all(20),
              child: Text(
                name,
                style: GoogleFonts.poppins(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(
                      255, 233, 228, 228), // fontWeight: FontWeight.bold,
                ),
              )),
          const SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              "Aired On:  " + aired_on,
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Color.fromARGB(
                    255, 233, 228, 228), // fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.justify,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  height: 200,
                  width: 100,
                  child: Image.network(posterurl),
                ),
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.only(left: 15),
                    child: SizedBox(
                      height: 140,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Text(
                          description,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: const Color.fromARGB(255, 233, 228,
                                228), // fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(100, 50),
                primary: const Color.fromARGB(255, 248, 60, 56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16), // <-- Radius
                ),
              ),
              onPressed: () {
                createFav(name: name, rating: 1, watched: false);
              },
              child: Text(
                'Add to Watch List',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(
                      255, 233, 228, 228), // fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
