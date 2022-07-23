### Movie Recommendation 🎥

Create a movie recommendation command line application that asks the user for a genre and returns a random movie name.

- Fork and clone [this](https://github.com/JoinCODED/MP-Dart-MovieDB) repository.
- Make sure you have an api key for the movie database. and store it in the `API_KEY` constant.
- The http package is already imported for you.
- You can refer to the package [documentation](https://pub.dev/packages/http) for more information.
- Here is the endpoints you will use:

```
To get all genres
https://api.themoviedb.org/3/genre/movie/list?api_key=${API_KEY}&language=en-US

To get a random movie
https://api.themoviedb.org/3/discover/movie?api_key=${API_KEY}&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_genres=${genreId}
```

- Start by showing the user a list of genres alongside ids.
- Ask the user to enter the genre id.
- Make a request to the api to get a random movie.
