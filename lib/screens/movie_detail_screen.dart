import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone_s/commom/utils.dart';
import 'package:netflix_clone_s/models/movie_detailed_model.dart';
import 'package:netflix_clone_s/models/movie_recommendation_model.dart';
import 'package:netflix_clone_s/services/api_services.dart';

class MovieDetailScreen extends StatefulWidget {
  final int movieId;
  const MovieDetailScreen({super.key, required this.movieId});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  ApiServices apiServices = ApiServices();
  late Future<MovieDetailedModel> moviedetail;
  late Future<MovieRecommendationModel> movieRecommendations;
  @override
  void initState() {
    fetchinitialData();
    super.initState();
  }

  fetchinitialData() {
    moviedetail = apiServices.getMovieDetail(widget.movieId);
    movieRecommendations = apiServices.getMovieRecommendations(widget.movieId);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print(" movie id = ${widget.movieId}");
    return Scaffold(
      body: Builder(builder: (context) {
        return FutureBuilder(
            future: moviedetail,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final movie = snapshot.data;
                String genreText =
                    movie!.genres.map((genre) => genre.name).join(", ");
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.4,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                      "https://image.tmdb.org/t/p/w500$imageUrl${movie.posterPath}",
                                    ),
                                    fit: BoxFit.cover)),
                            child: SafeArea(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: const Icon(
                                        Icons.arrow_back,
                                        color: Colors.white,
                                      )),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              movie.title,
                              style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                Text(
                                  movie.releaseDate.year.toString(),
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 15),
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                                Flexible(
                                  child: Text(
                                    genreText,
                                    style: const TextStyle(
                                        color: Colors.grey, fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              movie.overview,
                              maxLines: 6,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 17),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      FutureBuilder(
                          future: movieRecommendations,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final movieee = snapshot.data;
                              return movieee!.results.isEmpty
                                  ? const SizedBox()
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "More like this",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        GridView.builder(
                                          padding: EdgeInsets.zero,
                                          itemCount: movieee.results.length,
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3,
                                            mainAxisSpacing: 15,
                                            crossAxisSpacing: 5,
                                            childAspectRatio: 1.5 / 2,
                                          ),
                                          itemBuilder: (context, index) {
                                            return InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            MovieDetailScreen(
                                                                movieId: movieee
                                                                    .results[
                                                                        index]
                                                                    .id)));
                                              },
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    "https://image.tmdb.org/t/p/w500$imageUrl${movieee.results[index].posterPath}",
                                              ),
                                            );
                                          },
                                        )
                                      ],
                                    );
                            }
                            return const Text('something went wrong');
                          })
                    ],
                  ),
                );
              } else {
                return const Text("error ");
              }
            });
      }),
    );
  }
}
