import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/movie_detail_screen.dart';
import 'data/sample_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

     // home: MovieDetailScreen(movie: movies[0],),
       home: const HomeScreen(),
    );
  }
}
