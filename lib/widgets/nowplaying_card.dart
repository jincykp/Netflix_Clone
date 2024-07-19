import 'package:flutter/material.dart';
import 'package:netflix_clone_s/models/nowPlaying_model.dart';

class NowPlayingCard extends StatelessWidget {
  final Future<NowPlayingMovieModel> nowPlayingFuture;
  final String titleText;
  const NowPlayingCard(
      {super.key, required this.nowPlayingFuture, required this.titleText});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<NowPlayingMovieModel>(
      future: nowPlayingFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.results.isEmpty) {
          return const Center(child: Text('No now playing movies found'));
        } else {
          var data = snapshot.data!.results;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                titleText,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 220, // Define the height for the ListView.builder
                child: ListView.builder(
                  itemCount: data.length,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Image.network(
                        "https://image.tmdb.org/t/p/w500${data[index].posterPath}",
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.broken_image,
                            color: Colors.white,
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
