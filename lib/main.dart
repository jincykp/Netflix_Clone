import 'package:flutter/material.dart';
import 'package:netflix_clone_s/screens/splash_screen.dart';

class NetflixClone extends StatelessWidget {
  const NetflixClone({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SplashScreen(),
      themeMode: ThemeMode.dark,
      title: 'Netflix_clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: const TextTheme(bodyLarge: TextStyle(color: Colors.white)),
        scaffoldBackgroundColor: Colors.black,
        primaryColor: Colors.black,
      ),
    );
  }
}

main() {
  runApp(const NetflixClone());
}
