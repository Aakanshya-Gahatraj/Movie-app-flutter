// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/src/description.dart';
import 'package:movie_app/src/favs.dart';

class Trend extends StatelessWidget {
  final List trending;

  const Trend({Key? key, required this.trending}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 5),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 190),
                  child: Text("Movies",
                      style: GoogleFonts.poppins(
                        fontSize: 28,
                        // color: Color.fromARGB(255, 200, 182, 182),
                        color: const Color.fromARGB(255, 233, 228, 228),
                        fontWeight: FontWeight.bold,
                      )),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.favorite,
                    color: Color.fromARGB(255, 241, 48, 48),
                    size: 35,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => Favs()));
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
              height: 330, //poster height
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: trending.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => MovieDesc(
                                  id: trending[index]['id'] != null
                                      ? (trending[index]['id']).toString()
                                      : "Not loaded",
                                  name: trending[index]['title'] ??
                                      trending[index]['name'],
                                  description: trending[index]['overview'] ??
                                      'Not Loaded',
                                  bannerurl: 'https://image.tmdb.org/t/p/w500' +
                                      trending[index]['backdrop_path'],
                                  posterurl: 'https://image.tmdb.org/t/p/w500' +
                                      trending[index]['poster_path'],
                                  vote: trending[index]['vote_average'] != null
                                      ? trending[index]['vote_average']
                                          .toStringAsFixed(1)
                                      : 'Not Loaded',
                                  launch_on: trending[index]['release_date'] ??
                                      trending[index]["first_air_date"],
                                )));
                      },
                      child: Container(
                        width: 182,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        'https://image.tmdb.org/t/p/w500' +
                                            trending[index]['poster_path']),
                                  ),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20)),
                                  // borderRadius: BorderRadius.only(
                                  //       topLeft: Radius.circular(20),
                                  //       topRight: Radius.circular(20)),
                                ),
                                height: 250,
                              ),
                            ),
                            const SizedBox(height: 10),
                            trending[index]['title'] != null
                                ? Text(
                                    trending[index]['title'],
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      color: const Color.fromARGB(255, 233, 228,
                                          228), // fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  )
                                : Text(
                                    trending[index]['name'],
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      color: const Color.fromARGB(
                                          255, 233, 228, 228),
                                      // letterSpacing: 1,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  )
                          ],
                        ),
                      ),
                    );
                  })),
        ],
      ),
    );
  }
}

class TV extends StatelessWidget {
  final List tvShows;

  const TV({Key? key, required this.tvShows}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 20, left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("TV Shows",
              style: GoogleFonts.poppins(
                fontSize: 28,
                color: const Color.fromARGB(255, 233, 228, 228),
                fontWeight: FontWeight.bold,
              )),
          const SizedBox(height: 15),
          Container(
              height: 190,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: tvShows.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => TvDesc(
                                id: tvShows[index]['id'] != null
                                    ? (tvShows[index]['id']).toString()
                                    : "Not loaded",
                                name: tvShows[index]['name'] ?? 'Not Loaded',
                                description:
                                    tvShows[index]['overview'] ?? 'Not Loaded',
                                bannerurl: 'https://image.tmdb.org/t/p/w500' +
                                    tvShows[index]['backdrop_path'],
                                posterurl: 'https://image.tmdb.org/t/p/w500' +
                                    tvShows[index]['poster_path'],
                                vote: tvShows[index]['vote_average'] != null
                                    ? tvShows[index]['vote_average'].toString()
                                    : 'Not Loaded',
                                aired_on: tvShows[index]['first_air_date'] ??
                                    'Not Loaded',
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          width: 220,
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          'https://image.tmdb.org/t/p/w500' +
                                              tvShows[index]['poster_path']),
                                      fit: BoxFit.cover),
                                ),
                                height: 110,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                tvShows[index]['name'] ?? 'Loading',
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  color: const Color.fromARGB(255, 233, 228,
                                      228), // fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ));
                  }))
        ],
      ),
    );
  }
}
