import 'package:code/model/jokemodel.dart';
import 'package:flutter/material.dart';

import './data/jokes.dart';

Color appColor = Colors.green[300] as Color;

void main() => runApp(
  MaterialApp(
    home: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: appColor,
        title: const Text("Favorite Jokes"),
      ),
      body: FavScreen(jokes: jokes),
    ),
  ),
);

class FavScreen extends StatefulWidget {
  final List<JokeModel> jokes;
  const FavScreen({super.key, required this.jokes});

  @override
  State<FavScreen> createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  void setFav(JokeModel selectedJoke) {
    setState(() {
      final wasFav = selectedJoke.isFavorite;
      for (var joke in widget.jokes) {
        joke.isFavorite = false;
      }
      selectedJoke.isFavorite = !wasFav;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ...widget.jokes.map(
          (joke) => _FavoriteCard(joke: joke, favCard: () => setFav(joke)),
        ),
      ],
    );
  }
}

class _FavoriteCard extends StatelessWidget {
  final JokeModel joke;
  final VoidCallback favCard;
  const _FavoriteCard({required this.joke, required this.favCard});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(width: .5, color: Colors.grey)),
      ),
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  joke.title,
                  style: TextStyle(
                    color: appColor,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 10.0),
                Text(joke.description),
              ],
            ),
          ),
          IconButton(
            onPressed: favCard,
            icon: Icon(
              joke.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: joke.isFavorite ? Colors.red : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
