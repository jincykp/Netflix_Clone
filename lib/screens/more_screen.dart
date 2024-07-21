import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:netflix_clone_s/commom/utils.dart';
import 'package:netflix_clone_s/models/trending_movie_model.dart';
import 'package:netflix_clone_s/models/upcoming_model.dart';
import 'package:netflix_clone_s/services/api_services.dart';
import 'package:netflix_clone_s/widgets/coming_soon_widget.dart';

class HotandNew extends StatefulWidget {
  const HotandNew({super.key});

  @override
  State<HotandNew> createState() => _HotandNewState();
}

class _HotandNewState extends State<HotandNew> {
  late Future<TrendingMovieModel> trending;
  late Future<UpcomingMovieModel> upcomeing;
  ApiServices apiServices = ApiServices();

  @override
  void initState() {
    super.initState();
    trending = apiServices.getTrending('day');
    upcomeing = apiServices.getUpcomingMovies();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text(
              "New & Hot",
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              const Icon(
                Icons.cast,
                color: Colors.white,
              ),
              const SizedBox(
                width: 20,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Container(
                  height: 27,
                  width: 27,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(
                width: 20,
              )
            ],
            bottom: TabBar(
              tabs: const [
                Tab(
                  text: "  🔥 Coming Soon  ",
                ),
                Tab(
                  text: "  🍿 Everyone's Watching  ",
                ),
              ],
              labelColor: Colors.black,
              labelStyle: const TextStyle(fontWeight: FontWeight.bold),
              unselectedLabelColor: Colors.white,
              dividerColor: Colors.black,
              isScrollable: false,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(30), color: Colors.white),
            ),
          ),
          body: TabBarView(
            children: [
              _buildFutureBuilder1(),
              _buildFutureBuilder2(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFutureBuilder1() {
    return FutureBuilder<UpcomingMovieModel>(
      future: upcomeing,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          var data = snapshot.data!.results;
          log(data.length.toString());
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return ComeingSoonWidget(
                image: '$imageUrl${data[index].backdropPath}',
                overView: data[index].overview,
                logo: '$imageUrl${data[index].posterPath}',
                month: data[index].releaseDate.month.toString(),
                day: data[index].releaseDate.day.toString(),
              );
            },
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _buildFutureBuilder2() {
    return FutureBuilder<TrendingMovieModel>(
      future: trending,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          var data = snapshot.data!.results;
          log(data.length.toString());
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return ComeingSoonWidget(
                image:
                    'https://image.tmbd.org/t/p/w500$imageUrl${data[index].backdropPath}',
                overView: data[index].overview,
                logo:
                    'https://image.tmbd.org/t/p/w500$imageUrl${data[index].posterPath}',
                month: data[index].releaseDate.month.toString(),
                day: data[index].releaseDate.day.toString(),
              );
            },
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:netflix_clone/widgets/coming_soon_movie_widget.dart';

// class MoreScreen extends StatefulWidget {
//   const MoreScreen({super.key});

//   @override
//   State<MoreScreen> createState() => _MoreScreenState();
// }

// class _MoreScreenState extends State<MoreScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: SafeArea(
//         child: Scaffold(
//           appBar: AppBar(
//             elevation: 0,
//             backgroundColor: Colors.black,
//             title: const Text(
//               'New & Hot',
//               style: TextStyle(color: Colors.white),
//             ),
//             actions: [
//               const Padding(
//                 padding: EdgeInsets.only(right: 10.0),
//                 child: Icon(
//                   Icons.cast,
//                   color: Colors.white,
//                 ),
//               ),
//               const SizedBox(
//                 width: 10,
//               ),
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(6),
//                 child: Container(
//                   color: Colors.blue,
//                   height: 27,
//                   width: 27,
//                 ),
//               ),
//               const SizedBox(
//                 width: 20,
//               ),
//             ],
//             bottom: TabBar(
//               dividerColor: Colors.black,
//               isScrollable: false,
//               indicator: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20),
//                 color: Colors.white,
//               ),
//               labelColor: Colors.black,
//               labelStyle:
//                   const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
//               unselectedLabelColor: Colors.white,
//               tabs: const [
//                 Tab(
//                   text: '  🍿 Coming Soon  ',
//                 ),
//                 Tab(
//                   text: "  🔥 Everyone's watching  ",
//                 ),
//               ],
//             ),
//           ),
//           body: const TabBarView(children: [
//             SingleChildScrollView(
//               child: Column(
//                 children: [
//                   ComingSoonMovieWidget(
//                     imageUrl:
//                         'https://miro.medium.com/v2/resize:fit:1024/1*P_YU8dGinbCy6GHlgq5OQA.jpeg',
//                     overview:
//                         'When a young boy vanishes, a small town uncovers a mystery involving secret experiments, terrifying supernatural forces, and one strange little girl.',
//                     logoUrl:
//                         "https://s3.amazonaws.com/www-inside-design/uploads/2017/10/strangerthings_feature-983x740.jpg",
//                     month: "Jun",
//                     day: "19",
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   ComingSoonMovieWidget(
//                     imageUrl:
//                         'https://www.pinkvilla.com/images/2022-09/rrr-review.jpg',
//                     overview:
//                         'A fearless revolutionary and an officer in the British force, who once shared a deep bond, decide to join forces and chart out an inspirational path of freedom against the despotic rulers.',
//                     logoUrl:
//                         "https://www.careerguide.com/career/wp-content/uploads/2023/10/RRR_full_form-1024x576.jpg",
//                     month: "Mar",
//                     day: "07",
//                   ),
//                 ],
//               ),
//             ),
//             ComingSoonMovieWidget(
//               imageUrl:
//                   'https://miro.medium.com/v2/resize:fit:1024/1*P_YU8dGinbCy6GHlgq5OQA.jpeg',
//               overview:
//                   'When a young boy vanishes, a small town uncovers a mystery involving secret experiments, terrifying supernatural forces, and one strange little girl.',
//               logoUrl:
//                   "https://logowik.com/content/uploads/images/stranger-things4286.jpg",
//               month: "Feb",
//               day: "20",
//             ),
//           ]),
//         ),
//       ),
//     );
//   }
// }
