import '../models/movie.dart';

List<Movie> movies = [
  Movie(
    id: 1,
    title: "Avengers: Endgame",
    posterUrl:
    "https://image.tmdb.org/t/p/w500/or06FN3Dka5tukK1e9sl16pB3iy.jpg",
    overview:
    "After the devastating events of Infinity War, the Avengers assemble once more.",
    genres: ["Action", "Adventure", "Sci-Fi"],
    rating: 8.4,
    trailers: [
      "Official Trailer",
      "Final Trailer",
    ],
  ),
  Movie(
    id: 2,
    title: "The Batman",
    posterUrl:
    "https://image.tmdb.org/t/p/w500/74xTEgt7R36Fpooo50r9T25onhq.jpg",
    overview:
    "Batman uncovers corruption in Gotham City.",
    genres: ["Action", "Crime"],
    rating: 7.8,
    trailers: [
      "Main Trailer",
      "Behind The Scenes",
    ],
  ),
];