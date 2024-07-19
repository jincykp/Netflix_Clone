import 'dart:convert';
import 'dart:developer';

import 'package:netflix_clone_s/commom/utils.dart';
import 'package:netflix_clone_s/models/nowPlaying_model.dart';
import 'package:netflix_clone_s/models/tvseries_model.dart';
import 'package:netflix_clone_s/models/upcoming_model.dart';
import 'package:http/http.dart' as http;

const baseUrl = "https://api.themoviedb.org/3/";
var key = "?api_key=$apiKey";
late String endPoint;

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
}
