import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/src/screen/movies.dart';
import 'package:tmdb_api/tmdb_api.dart';

import 'login.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final auth = FirebaseAuth.instance;
  final String apiKey="b2ff4b50a0058858c7446f6ed153d042";
  final readAccessToken="eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiMmZmNGI1MGEwMDU4ODU4Yzc0NDZmNmVkMTUzZDA0MiIsInN1YiI6IjYyZDVlZDYwYTQxMGM4MDA1NWRjMDgyZiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.A8GmBKJETuJkmdVcEp6rF7nT3uXvsFWMjv1rgzh9MPU";
  List trendingList=[];
  List topratedmovies = [];
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
  // Map topratedresult = await tmdbWithCustomLogs.v3.movies.getTopRated();
  Map tvData = await tmdbWithCustomLogs.v3.tv.getPopular();
  print((trendingData));
  print((tvData));

  setState(() {
    trendingList = trendingData['results'];
    // topratedmovies = topratedresult['results'];
    tvList=(tvData['results']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
    appBar: AppBar(
          title:const Text('TheMovies',
              style: TextStyle(
                  color: Colors.white,
                  fontSize:25)),
          backgroundColor: Colors.transparent),
      body: ListView(
        children: [
        Trend(trending: trendingList),
        TV(tvShows: tvList),
          // TopRatedMovies(
      // toprated: topratedmovies,
      // ),
        const SizedBox(height: 5),
         Center(child: TextButton(child: Text('Logout', style: TextStyle(color: Colors.blueAccent, fontSize:25))
           ,onPressed: (){
              auth.signOut();
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
              },
            ),
          ),
        ],
      )
    );
  }
}