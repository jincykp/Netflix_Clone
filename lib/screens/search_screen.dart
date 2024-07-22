// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:netflix_clone_s/models/movie_recommendation_model.dart';
// import 'package:netflix_clone_s/models/search_model.dart';
// import 'package:netflix_clone_s/screens/movie_detail_screen.dart';
// import 'package:netflix_clone_s/services/api_services.dart';

// class SearchScreen extends StatefulWidget {
//   const SearchScreen({super.key});

//   @override
//   State<SearchScreen> createState() => _SearchScreenState();
// }

// class _SearchScreenState extends State<SearchScreen> {
//   late Future<MovieRecommendationModel> popularMovies;
//   TextEditingController searchController = TextEditingController();
//   ApiServices apiServices = ApiServices();
//   SearchModel? searchModel;

//   void search(String query) {
//     apiServices.getSearchedMovie(query).then((results) {
//       setState(() {
//         searchModel = results;
//       });
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     popularMovies = apiServices.getPopularMovies();
//   }

//   @override
//   void dispose() {
//     searchController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 CupertinoSearchTextField(
//                   controller: searchController,
//                   prefixIcon: const Icon(
//                     Icons.search,
//                     color: Colors.grey,
//                   ),
//                   suffixIcon: const Icon(
//                     Icons.cancel,
//                     color: Colors.grey,
//                   ),
//                   style: const TextStyle(color: Colors.white),
//                   backgroundColor: Colors.grey.withOpacity(0.3),
//                   onChanged: (value) {
//                     if (value.isEmpty) {
//                       setState(() {
//                         searchModel = null;
//                       });
//                     } else {
//                       search(searchController.text);
//                     }
//                   },
//                 ),
//                 const SizedBox(height: 10),
//                 searchController.text.isEmpty
//                     ? FutureBuilder<MovieRecommendationModel>(
//                         future: popularMovies,
//                         builder: (context, snapshot) {
//                           if (snapshot.connectionState ==
//                               ConnectionState.waiting) {
//                             return const Center(
//                                 child: CircularProgressIndicator());
//                           } else if (snapshot.hasError) {
//                             return Center(
//                                 child: Text('Error: ${snapshot.error}'));
//                           } else if (!snapshot.hasData ||
//                               snapshot.data!.results.isEmpty) {
//                             return const Center(
//                                 child: Text('No popular movies found'));
//                           } else {
//                             var data = snapshot.data!.results;
//                             return Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 const Text(
//                                   "Top Search",
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 20),
//                                 ListView.builder(
//                                   itemCount: data.length,
//                                   physics: const NeverScrollableScrollPhysics(),
//                                   shrinkWrap: true,
//                                   itemBuilder: (context, index) {
//                                     return InkWell(
//                                       onTap: () {
//                                         Navigator.push(
//                                             context,
//                                             MaterialPageRoute(
//                                                 builder: (context) =>
//                                                     MovieDetailScreen(
//                                                         movieId:
//                                                             data[index].id)));
//                                       },
//                                       child: Container(
//                                         height: 150,
//                                         padding: const EdgeInsets.all(5),
//                                         child: Row(
//                                           children: [
//                                             Image.network(
//                                               "https://image.tmdb.org/t/p/w500${data[index].posterPath}",
//                                               fit: BoxFit.cover,
//                                               errorBuilder:
//                                                   (context, error, stackTrace) {
//                                                 return const Icon(
//                                                   Icons.broken_image,
//                                                   color: Colors.white,
//                                                 );
//                                               },
//                                             ),
//                                             const SizedBox(width: 20),
//                                             Expanded(
//                                               child: Text(
//                                                 data[index].title,
//                                                 maxLines: 2,
//                                                 overflow: TextOverflow.ellipsis,
//                                                 style: const TextStyle(
//                                                     color: Colors.white),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     );
//                                   },
//                                 ),
//                               ],
//                             );
//                           }
//                         },
//                       )
//                     : searchModel == null
//                         ? const SizedBox.shrink()
//                         : GridView.builder(
//                             physics: const NeverScrollableScrollPhysics(),
//                             shrinkWrap: true,
//                             itemCount: searchModel?.results.length,
//                             gridDelegate:
//                                 const SliverGridDelegateWithFixedCrossAxisCount(
//                               crossAxisCount: 3,
//                               mainAxisSpacing: 15,
//                               crossAxisSpacing: 5,
//                               childAspectRatio: 1.2 / 2,
//                             ),
//                             itemBuilder: (context, index) {
//                               return InkWell(
//                                 onTap: () {
//                                   Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) =>
//                                               MovieDetailScreen(
//                                                   movieId: searchModel!
//                                                       .results[index].id)));
//                                 },
//                                 child: Column(
//                                   children: [
//                                     searchModel!.results[index].backdropPath ==
//                                             null
//                                         ? Image.asset(
//                                             "assets/netflix (3).png",
//                                             height: 145,
//                                           )
//                                         : CachedNetworkImage(
//                                             imageUrl:
//                                                 "https://image.tmdb.org/t/p/w500${searchModel!.results[index].backdropPath}",
//                                             height: 145,
//                                           ),
//                                     SizedBox(
//                                       width: 100,
//                                       child: Text(
//                                         searchModel!
//                                             .results[index].originalTitle,
//                                         maxLines: 2,
//                                         overflow: TextOverflow.ellipsis,
//                                         style: const TextStyle(
//                                             fontSize: 14, color: Colors.white),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               );
//                             },
//                           ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone_s/models/movie_recommendation_model.dart';
import 'package:netflix_clone_s/models/search_model.dart';
import 'package:netflix_clone_s/screens/movie_detail_screen.dart';
import 'package:netflix_clone_s/services/api_services.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late Future<MovieRecommendationModel> popularMovies;
  TextEditingController searchController = TextEditingController();
  ApiServices apiServices = ApiServices();
  SearchModel? searchModel;
  bool isSearching = false;

  void search(String query) {
    setState(() {
      isSearching = true;
    });

    apiServices.getSearchedMovie(query).then((results) {
      setState(() {
        searchModel = results;
        isSearching = false;
      });
    }).catchError((error) {
      setState(() {
        searchModel = null;
        isSearching = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    popularMovies = apiServices.getPopularMovies();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CupertinoSearchTextField(
                  controller: searchController,
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  suffixIcon: const Icon(
                    Icons.cancel,
                    color: Colors.grey,
                  ),
                  style: const TextStyle(color: Colors.white),
                  backgroundColor: Colors.grey.withOpacity(0.3),
                  onChanged: (value) {
                    if (value.isEmpty) {
                      setState(() {
                        searchModel = null;
                      });
                    } else {
                      search(searchController.text);
                    }
                  },
                ),
                const SizedBox(height: 10),
                isSearching
                    ? const Center(child: CircularProgressIndicator())
                    : searchController.text.isEmpty
                        ? FutureBuilder<MovieRecommendationModel>(
                            future: popularMovies,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return Center(
                                    child: Text('Error: ${snapshot.error}'));
                              } else if (!snapshot.hasData ||
                                  snapshot.data!.results.isEmpty) {
                                return const Center(
                                    child: Text('No popular movies found'));
                              } else {
                                var data = snapshot.data!.results;
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Top Search",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    ListView.builder(
                                      itemCount: data.length,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MovieDetailScreen(
                                                            movieId: data[index]
                                                                .id)));
                                          },
                                          child: Container(
                                            height: 150,
                                            padding: const EdgeInsets.all(5),
                                            child: Row(
                                              children: [
                                                Image.network(
                                                  "https://image.tmdb.org/t/p/w500${data[index].posterPath}",
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (context, error,
                                                      stackTrace) {
                                                    return const Icon(
                                                      Icons.broken_image,
                                                      color: Colors.white,
                                                    );
                                                  },
                                                ),
                                                const SizedBox(width: 20),
                                                Expanded(
                                                  child: Text(
                                                    data[index].title,
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                );
                              }
                            },
                          )
                        : searchModel == null || searchModel!.results.isEmpty
                            ? const Center(
                                child: Text(
                                  'No search results found',
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            : GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: searchModel?.results.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 15,
                                  crossAxisSpacing: 5,
                                  childAspectRatio: 1.2 / 2,
                                ),
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MovieDetailScreen(
                                                      movieId: searchModel!
                                                          .results[index].id)));
                                    },
                                    child: Column(
                                      children: [
                                        searchModel!.results[index]
                                                    .backdropPath ==
                                                null
                                            ? Image.asset(
                                                "assets/netflix (3).png",
                                                height: 145,
                                              )
                                            : CachedNetworkImage(
                                                imageUrl:
                                                    "https://image.tmdb.org/t/p/w500${searchModel!.results[index].backdropPath}",
                                                height: 145,
                                              ),
                                        SizedBox(
                                          width: 100,
                                          child: Text(
                                            searchModel!
                                                .results[index].originalTitle,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
