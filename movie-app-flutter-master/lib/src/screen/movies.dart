import 'package:flutter/material.dart';

class Trend extends StatelessWidget {
  final List trending;
  // final List tvshows;

  const Trend({ Key? key,  required this.trending}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Trending 🔥", style: TextStyle(color: Colors.white, fontSize:20)),
          const SizedBox(height: 10),

          Container(
              height: 270, //poster height
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: trending.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
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
                            if(trending[index]['title'] != null)...{
                            Text(trending[index]['title']
                                ,style:const TextStyle(color: Colors.white
                                , fontSize:16)
                                ,textAlign: TextAlign.center),
                            }else...{
                              const Text('Loading',style:TextStyle(color: Colors.white, fontSize:20)),
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

  const TV({Key? key,required this.tvShows}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text ("TV Shows 📺", style: TextStyle(color: Colors.white, fontSize:20)),
          const SizedBox(height: 10),
          Container(
            // color: Colors.red,
              height: 200,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: tvShows.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.all(5),
                      // color: Colors.green,
                      width: 250,
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      'https://image.tmdb.org/t/p/w500' +
                                          tvShows[index]['backdrop_path']),
                                  fit: BoxFit.cover),
                            ),
                            height: 140,
                          ),
                          const SizedBox(height: 5),
                          Text( tvShows[index]['original_name'] ?? 'Loading'
                              ,style:const TextStyle(color: Colors.white
                              , fontSize:16)
                              ,textAlign: TextAlign.center
                          ),
                        ],
                      ),
                    );
                  }))
        ],
      ),
    );
  }
}