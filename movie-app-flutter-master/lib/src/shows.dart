import 'package:flutter/material.dart';
import 'package:movie_app/src/description.dart';

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
          const Text("Trending 🔥",
              style: TextStyle(color: Colors.white, fontSize: 20)),
          const SizedBox(height: 10),
          Container(
              height: 300, //poster height
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: trending.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => MovieDesc(
                                  name: trending[index]['title'] != null
                                      ? trending[index]['title']
                                      : 'Not Loaded',
                                  description:
                                      trending[index]['overview'] != null
                                          ? trending[index]['overview']
                                          : 'Not Loaded',
                                  bannerurl: 'https://image.tmdb.org/t/p/w500' +
                                      trending[index]['backdrop_path'],
                                  posterurl: 'https://image.tmdb.org/t/p/w500' +
                                      trending[index]['poster_path'],
                                  vote: trending[index]['vote_average'] != null
                                      ? trending[index]['vote_average']
                                          .toString()
                                      : 'Not Loaded',
                                  launch_on:
                                      trending[index]['release_date'] != null
                                          ? trending[index]['release_date']
                                          : 'Not Loaded',
                                )));
                      },
                      child: Container(
                        width: 140,
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                      'https://image.tmdb.org/t/p/w500' +
                                          trending[index]['poster_path']),
                                ),
                              ),
                              height: 200,
                            ),
                            const SizedBox(height: 20),
                            if (trending[index]['title'] != null) ...{
                              Text(trending[index]['title'],
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 16),
                                  textAlign: TextAlign.center),
                            } else ...{
                              const Text('Loading',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20)),
                            }
                          ],
                        ),
                      ),
                    );
                  })),
          const SizedBox(height: 2),
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
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("TV Shows 📺",
              style: TextStyle(color: Colors.white, fontSize: 20)),
          const SizedBox(height: 10),
          Container(
              height: 200,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: tvShows.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => TvDesc(
                                name: tvShows[index]['name'] != null
                                    ? tvShows[index]['name']
                                    : 'Not Loaded',
                                description: tvShows[index]['overview'] != null
                                    ? tvShows[index]['overview']
                                    : 'Not Loaded',
                                bannerurl: 'https://image.tmdb.org/t/p/w500' +
                                    tvShows[index]['backdrop_path'],
                                posterurl: 'https://image.tmdb.org/t/p/w500' +
                                    tvShows[index]['poster_path'],
                                vote: tvShows[index]['vote_average'] != null
                                    ? tvShows[index]['vote_average'].toString()
                                    : 'Not Loaded',
                                aired_on:
                                    tvShows[index]['first_air_date'] != null
                                        ? tvShows[index]['first_air_date']
                                        : 'Not Loaded',
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          width: 250,
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
                                height: 140,
                              ),
                              const SizedBox(height: 20),
                              Text(tvShows[index]['name'] ?? 'Loading',
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 16),
                                  textAlign: TextAlign.center),
                            ],
                          ),
                        ));
                  }))
        ],
      ),
    );
  }
}
