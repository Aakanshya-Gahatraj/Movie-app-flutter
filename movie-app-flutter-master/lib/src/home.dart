import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/src/shows.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'login.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final auth = FirebaseAuth.instance;
  final String apiKey = "b2ff4b50a0058858c7446f6ed153d042";
  final readAccessToken =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiMmZmNGI1MGEwMDU4ODU4Yzc0NDZmNmVkMTUzZDA0MiIsInN1YiI6IjYyZDVlZDYwYTQxMGM4MDA1NWRjMDgyZiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.A8GmBKJETuJkmdVcEp6rF7nT3uXvsFWMjv1rgzh9MPU";
  List trendingList = [];
  List videosList = [];
  List trailersList = [];
  List tvList = [];

  @override
  void initState() {
    super.initState();
    loadmovies();
  }

  loadmovies() async {
    TMDB tmdb = TMDB(
      ApiKeys(apiKey, readAccessToken),
      logConfig: const ConfigLogger(
        showLogs: true,
        showErrorLogs: true,
      ),
    );

    Map trendingData = await tmdb.v3.movies.getPopular();
    Map tvData = await tmdb.v3.tv.getPopular();
    // Map trailersData = await tmdbWithCustomLogs.v3.movies.getVideos(762504);
    // Map trailersData = await tmdb.v3.tv.getVideos(94997);
    // print('Here    ');
    // print(trailersData);

    setState(() {
      trendingList = trendingData['results'];
      tvList = (tvData['results']);
      // videosList = trailersData['results'];

      // // latestList = (latestData['results']);
      // // print(trailersList);
      // for (var i = 0; i < videosList.length; i++) {
      //   (videosList[i]['type']).toLowerCase() == 'trailer'
      //       ?
      //       // print("Key=   " + trailersList[i]['key'])
      //       trailersList.add(videosList[i]['key'])
      //       : 'None';
      // } //trailer video is in 0 index
      // print(trailersList);
      // print(videosList);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 20, 4, 35),
            Color.fromARGB(255, 0, 0, 0),
          ],
        ),
      ),
      child: ListView(
        children: [
          Trend(trending: trendingList),
          TV(tvShows: tvList),
          const SizedBox(height: 5),
          Center(
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(150, 50),
                  primary: Color.fromARGB(255, 221, 35, 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // <-- Radius
                  ),
                ),
                onPressed: () {
                  auth.signOut();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const LoginScreen()));
                },
                child: const Text(
                  'Logout',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                )),
          ),
        ],
      ),
    ));
  }
}
