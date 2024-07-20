import 'package:flutter/material.dart';
import 'package:netflix_clone_s/commom/utils.dart';
import 'package:netflix_clone_s/models/movie_detailed_model.dart';
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
  @override
  void initState() {
    fetchinitialData();
    super.initState();
  }

  fetchinitialData() {
    moviedetail = apiServices.getMovieDetail(widget.movieId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print(" movie id = ${widget.movieId}");
    return Scaffold(
      body: FutureBuilder(
          future: moviedetail,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final movie = snapshot.data;
              return Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    "https://image.tmdb.org/t/p/w500$imageUrl${movie!.posterPath}"))),
                      )
                    ],
                  )
                ],
              );
            } else {
              return const SizedBox();
            }
          }),
    );
  }
}
