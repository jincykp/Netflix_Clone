import 'package:flutter/material.dart';
import 'package:netflix_clone_s/commom/utils.dart';
import 'package:netflix_clone_s/models/nowPlaying_model.dart';
import 'package:netflix_clone_s/models/tvseries_model.dart';
import 'package:netflix_clone_s/models/upcoming_model.dart';
import 'package:netflix_clone_s/screens/movie_detail_screen.dart';
import 'package:netflix_clone_s/screens/search_screen.dart';
import 'package:netflix_clone_s/services/api_services.dart';
import 'package:netflix_clone_s/widgets/carousal.dart';
import 'package:netflix_clone_s/widgets/nowplaying_card.dart';
import 'package:netflix_clone_s/widgets/upcoming_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  late Future<UpcomingMovieModel> upcomingFuture;
  late Future<NowPlayingMovieModel> nowplayingFuture;
  late Future<TvSeriesModel> topRatedSeries;
  ApiServices apiServices = ApiServices();
  @override
  void initState() {
    super.initState();
    upcomingFuture = apiServices.getUpcomingMovies();
    nowplayingFuture = apiServices.getNowPlaying();
    topRatedSeries = apiServices.getTopRated();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kBackgroundColor,
          title: Image.asset(
            "assets/logo.png",
            height: 50,
            width: 120,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SearchScreen()));
                },
                child: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              ),
            ),
            ClipRect(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.blue, borderRadius: BorderRadius.circular(7)),
                height: 26,
                width: 26,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            FutureBuilder<TvSeriesModel>(
                future: topRatedSeries,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData) {
                    return const Center(child: Text('No data available'));
                  } else {
                    return CustomCarouselSlider(data: snapshot.data!);
                  }
                }),
            SizedBox(
                height: 280,
                child: NowPlayingCard(
                    nowPlayingFuture: nowplayingFuture,
                    titleText: "NowPlaying Movies")),
            SizedBox(
                height: 280,
                child: MovieCard(
                    future: upcomingFuture, headLineText: "Upcoming Movies")),
          ]),
        ));

    // else if (snapshot.hasError) {
    //   Text('${snapshot.error}');
    // }
    // var data = snapshot.data?.results;
    // return ListView.builder(
    //   itemCount: data?.length,
    //   itemBuilder: (context, index) => Text(data![index].title),
    // );
  }
}
