import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_flutter_team_creator/Features/pokedex/route.dart';
import 'common/models/repositories/pokemon_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Esse widget é a raiz da tua aplicação
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokedex Teambuilder com IA',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: PokedexRoute(repository: PokemonRepository(dio: Dio())),
    );
  }
}
