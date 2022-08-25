import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
  List trailersList = [];
  List tvList = [];

  @override
  void initState() {
    super.initState();
    loadmovies();
  }

  loadmovies() async {
    TMDB tmdbWithCustomLogs = TMDB(
      ApiKeys(apiKey, readAccessToken),
      logConfig: const ConfigLogger(
        showLogs: true,
        showErrorLogs: true,
      ),
    );

    Map trendingData = await tmdbWithCustomLogs.v3.trending.getTrending();
    Map tvData = await tmdbWithCustomLogs.v3.tv.getPopular();
    // Map trailersList = await tmdbWithCustomLogs.v3.movies.getVideos();
    // print((latestMovieData));

    setState(() {
      trendingList = trendingData['results'];
      tvList = (tvData['results']);
      // print("Here-----> " + tvData['name']);

      // latestList = (latestData['results']);
      // for (var i = 0; i < tvList.length; i++) {
      //   print(tvList[i].name);
      // }
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
            // Color.fromARGB(255, 27, 20, 34),
            Color.fromARGB(255, 20, 4, 35),
            Color.fromARGB(255, 0, 0, 0),
          ],
        ),
      ),
      child: ListView(
        children: [
          Trend(trending: trendingList),
          // Movie(latestMovies: latestList),
          TV(tvShows: tvList),
          const SizedBox(height: 8),
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
