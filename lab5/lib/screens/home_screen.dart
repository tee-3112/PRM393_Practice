import 'package:flutter/material.dart';
import '../data/sample_data.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movie App"),
      ),
      body: ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];

          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              leading: Image.network(
                movie.posterUrl,
                width: 50,
              ),
              title: Text(movie.title),
              subtitle: Text(
                "⭐ ${movie.rating}",
              ),
            ),
          );
        },
      ),
    );
  }
}