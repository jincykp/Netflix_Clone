import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ComingSoonWidget extends StatelessWidget {
  final String image;
  final String overView;
  final String logo;
  final String month;
  final String day;

  const ComingSoonWidget({
    super.key,
    required this.image,
    required this.overView,
    required this.logo,
    required this.month,
    required this.day,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Text(
                  month,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  day,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 10),
              ],
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl: image,
                width: size.width * 0.7,
                alignment: Alignment.topLeft,
                errorWidget: (context, url, error) => const Icon(
                  Icons.error,
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: size.width * 0.8,
                child: Row(
                  children: [
                    SizedBox(
                      width: size.width * 0.3,
                      height: size.width * 0.1,
                      child: CachedNetworkImage(
                        imageUrl: logo,
                        alignment: Alignment.centerLeft,
                        errorWidget: (context, url, error) => const Icon(
                          Icons.error,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    const Spacer(),
                    const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.notifications_none_outlined,
                          size: 24,
                          color: Colors.white,
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Remind me",
                          style: TextStyle(fontSize: 10, color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(width: 30),
                    const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.info_outline_rounded,
                          size: 24,
                          color: Colors.white,
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Info",
                          style: TextStyle(fontSize: 10, color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Coming on $month /$day",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 300,
                    child: Text(
                      overView,
                      maxLines: 4,
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}



// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';

// class ComingSoonMovieWidget extends StatelessWidget {
//   final String imageUrl;
//   final String overview;
//   final String logoUrl;
//   final String month;
//   final String day;

//   const ComingSoonMovieWidget({
//     super.key,
//     required this.imageUrl,
//     required this.overview,
//     required this.logoUrl,
//     required this.month,
//     required this.day,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return SizedBox(
//       // height: size.width * 0.85,
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Column(
//               children: [
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 Text(
//                   month,
//                   style: const TextStyle(
//                       fontWeight: FontWeight.bold, color: Colors.grey),
//                 ),
//                 Text(day,
//                     style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 40,
//                         letterSpacing: 5))
//               ],
//             ),
//             const SizedBox(
//               width: 10,
//             ),
//             Expanded(
//                 child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 CachedNetworkImage(imageUrl: imageUrl),
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     SizedBox(
//                       width: size.width * 0.5,
//                       height: size.width * 0.2,
//                       child: CachedNetworkImage(
//                         imageUrl: logoUrl,
//                         alignment: Alignment.centerLeft,
//                       ),
//                     ),
//                     const Spacer(),
//                     const Column(
//                       children: [
//                         Icon(
//                           Icons.notifications_none_rounded,
//                           size: 25,
//                           color: Colors.white,
//                         ),
//                         SizedBox(
//                           height: 5,
//                         ),
//                         Text(
//                           'Remind Me',
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold, fontSize: 8),
//                         )
//                       ],
//                     ),
//                     const SizedBox(
//                       width: 20,
//                     ),
//                     const Column(
//                       children: [
//                         Icon(
//                           Icons.info_outline_rounded,
//                           size: 25,
//                           color: Colors.white,
//                         ),
//                         SizedBox(
//                           height: 5,
//                         ),
//                         Text(
//                           'Info',
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold, fontSize: 8),
//                         )
//                       ],
//                     ),
//                     const SizedBox(
//                       width: 10,
//                     )
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Coming on $month $day',
//                       style: const TextStyle(
//                           fontWeight: FontWeight.bold, fontSize: 16.5),
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     Text(
//                       overview,
//                       textAlign: TextAlign.left,
//                       maxLines: 3,
//                       style:
//                           const TextStyle(color: Colors.grey, fontSize: 12.5),
//                       overflow: TextOverflow.ellipsis,
//                     )
//                   ],
//                 )
//               ],
//             ))
//           ],
//         ),
//       ),
//     );
//   }
// }