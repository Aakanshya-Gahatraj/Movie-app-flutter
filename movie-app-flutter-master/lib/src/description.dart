import 'package:flutter/material.dart';
import 'package:movie_app/src/home.dart';

class MovieDesc extends StatelessWidget {
  final String name, description, bannerurl, posterurl, vote, launch_on;

  const MovieDesc(
      {Key? key,
      required this.name,
      required this.description,
      required this.bannerurl,
      required this.posterurl,
      required this.vote,
      required this.launch_on})
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
        ],
      ),
    );
  }
}
