1. Start by creating required models.

```dart
class Genre {
  final int id;
  final String name;

  Genre({this.id, this.name});
}

class Movie {
  final int id;
  final String title;

  Movie({
    this.id,
    this.title,
  });
}
```

2. Add a factory constructor to the `Genre` model.

```dart
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
```

3. Add a factory constructor to the `Movie` model.

```dart
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
```

4. Create a function `getGenres` that returns a list of genres.

```dart
Future<List<Genre>> getGenres() async {}
```

5. In this function, make a request to the api to get all genres.

```dart
  final response = await http.get(Uri.parse(
      'https://api.themoviedb.org/3/genre/movie/list?api_key=${API_KEY}&language=en-US'));
```

6. Check the status code of the response, else throw an error.

```dart
  if (response.statusCode == 200) {
  } else {
    throw Exception('Failed to load genres');
  }
```

7. Map the json response to a list of `Genre` objects.

```dart
  final genres = jsonDecode(response.body)['genres'];
  return genres.map<Genre>((genre) => Genre.fromJson(genre)).toList();
```

8. Create a function `getMovie` that returns a random movie.

```dart
Future<Movie> getMovie(int genreId) async {}
```

9. In this function, make a request to the api to get a random movie.

```dart
  final response = await http.get(Uri.parse(
      'https://api.themoviedb.org/3/discover/movie?api_key=${API_KEY}&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_genres=${genreId}'));
```

10. Check the status code of the response, else throw an error.

```dart
  if (response.statusCode == 200) {
  } else {
    throw Exception('Failed to load movie');
  }
```

11. Take the first movie from the json response and map it to a Movie object.

```dart
  final movie = jsonDecode(response.body)['results'][0];
  return Movie.fromJson(movie);
```

12. Turn your main method to `async`.

```dart
  void main() async {
  }
```

13. Create a list of genres.

```dart
  final genres = await getGenres();
```

14. Show the user a list of genres alongside ids.

```dart
  print(
      genres.map((genre) => "${genre.id} - ${genre.name}").toList().join('\n'));
```

15. Ask the user to enter the genre id.

```dart
  stdout.write("Select a genre: ");
  final line = stdin.readLineSync();
  final genreId = int.parse(line);
```

16. Call the `getMovie` function and pass the genre id.

```dart
  final movie = await getMovie(genreId);
```

17. Print the movie name.

```dart
  print(movie.title);
```

18. Complete code:

```dart
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
```
