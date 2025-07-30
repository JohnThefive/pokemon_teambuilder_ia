import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_flutter_team_creator/common/models/repositories/pokemon_repository.dart';
import 'package:pokedex_flutter_team_creator/home/container/home_container.dart';

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
      home: HomeContainer(repository: PokemonRepository(dio: Dio())),
    );
  }
}
