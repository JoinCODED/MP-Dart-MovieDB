import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

const API_KEY = 'Your API key';
void main() async {
  final genres = await getGenres();
  print(
      genres.map((genre) => "${genre.id} - ${genre.name}").toList().join('\n'));
  stdout.write("Select a genre: ");
  final line = stdin.readLineSync();
  final genreId = int.parse(line);
  final movie = await getMovie(genreId);
  print(movie.title);
}

Future<List<Genre>> getGenres() async {
  final response = await http.get(Uri.parse(
      'https://api.themoviedb.org/3/genre/movie/list?api_key=${API_KEY}&language=en-US'));
  if (response.statusCode == 200) {
    final genres = jsonDecode(response.body)['genres'];
    return genres.map<Genre>((genre) => Genre.fromJson(genre)).toList();
  } else {
    throw Exception('Failed to load genres');
  }
}

Future<Movie> getMovie(int genreId) async {
  final response = await http.get(Uri.parse(
      'https://api.themoviedb.org/3/discover/movie?api_key=${API_KEY}&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_genres=${genreId}'));
  if (response.statusCode == 200) {
    final movie = jsonDecode(response.body)['results'][0];
    return Movie.fromJson(movie);
  } else {
    throw Exception('Failed to load movies');
  }
}

class Genre {
  final int id;
  final String name;

  Genre({this.id, this.name});

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      id: json['id'],
      name: json['name'],
    );
  }
}

class Movie {
  final int id;
  final String title;

  Movie({
    this.id,
    this.title,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
    );
  }
}
