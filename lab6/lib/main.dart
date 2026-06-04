import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Movie {
  final String title;
  final int year;
  final double rating;
  final List<String> genres;

  Movie({
    required this.title,
    required this.year,
    required this.rating,
    required this.genres,
  });
}

final List<Movie> allMovies = [
  Movie(
    title: "Avengers: Endgame",
    year: 2019,
    rating: 8.4,
    genres: ["Action", "Adventure"],
  ),
  Movie(
    title: "The Batman",
    year: 2022,
    rating: 7.8,
    genres: ["Action", "Crime"],
  ),
  Movie(
    title: "Oppenheimer",
    year: 2023,
    rating: 8.5,
    genres: ["Drama"],
  ),
  Movie(
    title: "Inside Out 2",
    year: 2024,
    rating: 8.0,
    genres: ["Comedy"],
  ),
  Movie(
    title: "Dune Part Two",
    year: 2024,
    rating: 8.8,
    genres: ["Action", "Drama"],
  ),
];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const GenreScreen(),
    );
  }
}

class GenreScreen extends StatefulWidget {
  const GenreScreen({super.key});

  @override
  State<GenreScreen> createState() => _GenreScreenState();
}

class _GenreScreenState extends State<GenreScreen> {
  String searchQuery = "";
  String selectedSort = "A-Z";

  final Set<String> selectedGenres = {};

  final List<String> genres = [
    "Action",
    "Adventure",
    "Drama",
    "Comedy",
    "Crime",
  ];

  @override
  Widget build(BuildContext context) {
    List<Movie> visibleMovies = allMovies.where((movie) {
      bool matchesSearch = movie.title
          .toLowerCase()
          .contains(searchQuery.toLowerCase());

      bool matchesGenre = selectedGenres.isEmpty ||
          selectedGenres.every(
                (genre) => movie.genres.contains(genre),
          );

      return matchesSearch && matchesGenre;
    }).toList();

    switch (selectedSort) {
      case "A-Z":
        visibleMovies.sort(
              (a, b) => a.title.compareTo(b.title),
        );
        break;

      case "Z-A":
        visibleMovies.sort(
              (a, b) => b.title.compareTo(a.title),
        );
        break;

      case "Year":
        visibleMovies.sort(
              (a, b) => b.year.compareTo(a.year),
        );
        break;

      case "Rating":
        visibleMovies.sort(
              (a, b) => b.rating.compareTo(a.rating),
        );
        break;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Find a Movie"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(
                  hintText: "Search movie...",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
              ),

              const SizedBox(height: 12),

              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: genres.map((genre) {
                  return FilterChip(
                    label: Text(genre),
                    selected:
                    selectedGenres.contains(genre),
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          selectedGenres.add(genre);
                        } else {
                          selectedGenres.remove(genre);
                        }
                      });
                    },
                  );
                }).toList(),
              ),

              const SizedBox(height: 12),

              DropdownButton<String>(
                value: selectedSort,
                isExpanded: true,
                items: const [
                  DropdownMenuItem(
                    value: "A-Z",
                    child: Text("A-Z"),
                  ),
                  DropdownMenuItem(
                    value: "Z-A",
                    child: Text("Z-A"),
                  ),
                  DropdownMenuItem(
                    value: "Year",
                    child: Text("Year"),
                  ),
                  DropdownMenuItem(
                    value: "Rating",
                    child: Text("Rating"),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    selectedSort = value!;
                  });
                },
              ),

              const SizedBox(height: 12),

              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth < 800) {
                      return ListView.builder(
                        itemCount: visibleMovies.length,
                        itemBuilder: (context, index) {
                          return MovieCard(
                            movie: visibleMovies[index],
                          );
                        },
                      );
                    }

                    return GridView.builder(
                      itemCount: visibleMovies.length,
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 2.5,
                      ),
                      itemBuilder: (context, index) {
                        return MovieCard(
                          movie: visibleMovies[index],
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(movie.title),
        subtitle: Text(
          "Year: ${movie.year}\nRating: ${movie.rating}",
        ),
        trailing: Wrap(
          spacing: 4,
          children: movie.genres
              .map(
                (genre) => Chip(
              label: Text(
                genre,
                style: const TextStyle(fontSize: 10),
              ),
            ),
          )
              .toList(),
        ),
      ),
    );
  }
}