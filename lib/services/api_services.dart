import 'dart:convert';
import 'dart:developer';

import 'package:netflix_clone_s/commom/utils.dart';
import 'package:netflix_clone_s/models/movie_detailed_model.dart';
import 'package:netflix_clone_s/models/movie_recommendation_model.dart';
import 'package:netflix_clone_s/models/nowPlaying_model.dart';
import 'package:netflix_clone_s/models/search_model.dart';
import 'package:netflix_clone_s/models/tvseries_model.dart';
import 'package:netflix_clone_s/models/upcoming_model.dart';
import 'package:http/http.dart' as http;

const baseUrl = "https://api.themoviedb.org/3/";
var key = "?api_key=$apiKey";
late String endPoint;
const accessToken =
    "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5NzgxNjEzZjYyNDkxNzAzMGI5Njc3NDhhNWJjYzZhYSIsIm5iZiI6MTcyMDUwMDQ1NC40NTMwOTIsInN1YiI6IjY2OGJlZTQ5NzdiYjYwNzBiNjYzNWUyYSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.3E7YkMlYJdA5lPrnrsOvZZS5aoysWS72JWOZC3OC6_k";

class ApiServices {
  Future<UpcomingMovieModel> getUpcomingMovies() async {
    int attempts = 0;
    const int maxAttempts = 5;

    while (attempts < maxAttempts) {
      try {
        String endUrl = 'movie/upcoming';
        final url = '$baseUrl$endUrl$key';
        final response = await http.get(Uri.parse(url));
        log(response.statusCode.toString());
        if (response.statusCode == 200) {
          return UpcomingMovieModel.fromJson(jsonDecode(response.body));
        } else if (response.statusCode >= 300) {
          throw 'Faled to load pupular series';
        }
      } catch (e) {
        log(e.toString());
        await Future.delayed(const Duration(seconds: 1));
        attempts++;
      }
    }
    throw 'Faled to load pupular series';
  }

  Future<NowPlayingMovieModel> getNowPlaying() async {
    int attempts = 0;
    const int maxAttempts = 5;

    while (attempts < maxAttempts) {
      try {
        String endUrl = 'movie/now_playing';
        final url = '$baseUrl$endUrl$key';
        final response = await http.get(Uri.parse(url));
        log(response.statusCode.toString());
        if (response.statusCode == 200) {
          return NowPlayingMovieModel.fromJson(jsonDecode(response.body));
        } else if (response.statusCode >= 300) {
          throw 'Failed to load now playing movies';
        }
      } catch (e) {
        log(e.toString());
        await Future.delayed(const Duration(seconds: 1));
        attempts++;
      }
    }
    throw 'Faled to load now playing movies';
  }

  Future<TvSeriesModel> getTopRated() async {
    int attempts = 0;
    const int maxAttempts = 5;

    while (attempts < maxAttempts) {
      try {
        String endUrl = 'tv/top_rated';
        final url = '$baseUrl$endUrl$key';
        final response = await http.get(Uri.parse(url));
        log(response.statusCode.toString());
        if (response.statusCode == 200) {
          return TvSeriesModel.fromJson(jsonDecode(response.body));
        } else if (response.statusCode >= 300) {
          throw 'Failed to load top rated series';
        }
      } catch (e) {
        log(e.toString());
        await Future.delayed(const Duration(seconds: 1));
        attempts++;
      }
    }
    throw 'Faled to load top rated movies';
  }

  Future<SearchModel> getSearchedMovie(String searchtext) async {
    endPoint = "search/movie?query=$searchtext";
    final url = "$baseUrl$endPoint";
    print("search url =$url");
    final response = await http
        .get(Uri.parse(url), headers: {"Authorization": "Bearer $accessToken"});

    if (response.statusCode == 200) {
      log('search success');
      return SearchModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("Failed to load searched movies ");
  }

  Future<MovieRecommendationModel> getPopularMovies() async {
    int attempts = 0;
    const int maxAttempts = 5;

    while (attempts < maxAttempts) {
      try {
        String endUrl = 'movie/popular';
        final url = '$baseUrl$endUrl$key';
        print("pop url=$url");
        final response = await http.get(Uri.parse(url));
        log(response.statusCode.toString());
        if (response.statusCode == 200) {
          return MovieRecommendationModel.fromJson(jsonDecode(response.body));
        } else if (response.statusCode >= 300) {
          throw 'Failed to load popular movies';
        }
      } catch (e) {
        log(e.toString());
        await Future.delayed(const Duration(seconds: 1));
        attempts++;
      }
    }
    throw 'Faled to load popular movies';
  }

  Future<MovieDetailedModel> getMovieDetail(int movieId) async {
    endPoint = "movie/$movieId";
    final url = "$baseUrl$endPoint$key";
    print("search url =$url");
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      log('search success');
      return MovieDetailedModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("Failed to load movie details ");
  }

  Future<MovieRecommendationModel> getMovieRecommendations(int movieId) async {
    endPoint = "movie/$movieId/recommendations";
    final url = "$baseUrl$endPoint$key";
    print("recommendations url =$url");
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      log('search success');
      return MovieRecommendationModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("Failed to load more like this ");
  }
}
