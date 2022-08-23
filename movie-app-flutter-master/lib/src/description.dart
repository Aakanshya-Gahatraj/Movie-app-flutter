import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/src/favs.dart';
import 'package:movie_app/src/home.dart';

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
      _MovieDescState(name, description, bannerurl, posterurl, vote, launch_on);
}

class _MovieDescState extends State<MovieDesc> {
  String name, description, bannerurl, posterurl, vote, launch_on;
  _MovieDescState(this.name, this.description, this.bannerurl, this.posterurl,
      this.vote, this.launch_on);
  // final controller = TextEditingController();

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
          icon:
              Icon(Icons.arrow_back, color: Color.fromARGB(255, 252, 251, 251)),
          onPressed: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomeScreen())),
        ),
      ),
      body: ListView(
        children: [
          Container(
              height: 250,
              child: Stack(children: [
                Positioned(
                  child: Container(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    child: Image.network(
                      bannerurl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                    left: 20,
                    bottom: 20,
                    child: Text('⭐ Rating: ' + vote,
                        style: TextStyle(color: Colors.white, fontSize: 18))),
              ])),
          SizedBox(height: 15),
          Container(
              padding: EdgeInsets.all(20),
              child: Text(name,
                  style: TextStyle(color: Colors.white, fontSize: 25))),
          SizedBox(height: 15),
          Container(
            padding: EdgeInsets.only(left: 20),
            child: Text(launch_on,
                style: TextStyle(color: Colors.white, fontSize: 20)),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 0),
                  height: 200,
                  width: 100,
                  child: Image.network(posterurl),
                ),
                Flexible(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text(description,
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(100, 50),
                primary: Color.fromARGB(255, 248, 60, 56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16), // <-- Radius
                ),
              ),
              onPressed: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (_) => Favs(text: name)));
                // name = controller.text;
                createFav(name: name, rating: 1, watched: false);
              },
              child: const Text('Add to Watch List')),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon:
              Icon(Icons.arrow_back, color: Color.fromARGB(255, 252, 251, 251)),
          onPressed: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomeScreen())),
        ),
      ),
      body: ListView(
        children: [
          Container(
              height: 250,
              child: Stack(children: [
                Positioned(
                  child: Container(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    child: Image.network(
                      bannerurl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                    left: 20,
                    bottom: 20,
                    child: Text('⭐ Rating: ' + vote,
                        style: TextStyle(color: Colors.white, fontSize: 18))),
              ])),
          SizedBox(height: 15),
          Container(
              padding: EdgeInsets.all(20),
              child: Text(name,
                  style: TextStyle(color: Colors.white, fontSize: 25))),
          SizedBox(height: 15),
          Container(
            padding: EdgeInsets.only(left: 20),
            child: Text("Aired On: " + aired_on,
                style: TextStyle(color: Colors.white, fontSize: 20)),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 0),
                  height: 200,
                  width: 100,
                  child: Image.network(posterurl),
                ),
                Flexible(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text(description,
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(100, 50),
                primary: Color.fromARGB(255, 248, 60, 56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16), // <-- Radius
                ),
              ),
              onPressed: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (_) => Favs(name: name)));
              },
              child: const Text('Add to Watch List')),
        ],
      ),
    );
  }
}
