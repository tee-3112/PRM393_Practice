import 'package:flutter/material.dart';

class Ex3 extends StatelessWidget {
  const Ex3({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> movies = [
      "Avengers: Endgame",
      "Spider-Man: No Way Home",
      "The Batman",
      "Doctor Strange",
      "Avatar 2",
      "John Wick 4",
      "Dune",
      "Oppenheimer",
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Exercise 3 - Layout Basics"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Movie App",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Chip(label: Text("Action")),
                Chip(label: Text("Comedy")),
                Chip(label: Text("Drama")),
              ],
            ),

            const SizedBox(height: 16),

            const Text(
              "Popular Movies",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Expanded(
              child: ListView.builder(
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      leading: const Icon(Icons.movie),
                      title: Text(movies[index]),
                      subtitle: Text("Movie #${index + 1}"),
                      trailing: const Icon(Icons.arrow_forward_ios),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}