import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone_s/commom/utils.dart';
import 'package:netflix_clone_s/models/tvseries_model.dart';

class CustomCarouselSlider extends StatelessWidget {
  final TvSeriesModel data;
  const CustomCarouselSlider({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: (size.height * 0.33 < 300) ? 300 : size.height * 0.33,
      child: CarouselSlider.builder(
        itemCount: data.results.length,
        itemBuilder: (BuildContext context, int index, int realIndex) {
          String? backdropPath = data.results[index].posterPath;
          log(backdropPath);
          // var url = backdropPath != null
          //     ? "https://image.tmdb.org/t/p/w500$backdropPath"
          //     : "https://via.placeholder.com/500x281?text=No+Image";

          return GestureDetector(
              child: Column(
            children: [
              Expanded(
                child: Image.network(
                  "https://image.tmdb.org/t/p/w500${data.results[index].backdropPath}",
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.broken_image,
                      color: Colors.white,
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                data.results[index].name,
                style: const TextStyle(color: Colors.white),
              )
            ],
          ));
        },
        options: CarouselOptions(
            height: (size.height * 0.33 < 300) ? 300 : size.height * 0.33,
            aspectRatio: 16 / 9,
            reverse: false,
            initialPage: 0,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            enlargeCenterPage: true,
            scrollDirection: Axis.horizontal),
      ),
    );
  }
}
