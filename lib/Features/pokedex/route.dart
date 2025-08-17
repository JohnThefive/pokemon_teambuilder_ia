import 'package:flutter/material.dart';
import 'package:pokedex_flutter_team_creator/Features/pokedex/screens/details/container/detail_container.dart';
import 'package:pokedex_flutter_team_creator/Features/pokedex/screens/home/container/home_container.dart';
import 'package:pokedex_flutter_team_creator/common/models/repositories/pokemon_repository.dart';

class PokedexRoute extends StatelessWidget {
  const PokedexRoute({
    super.key,
    required this.repository,
  });

  final PokemonRepository repository;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(
              builder: (context) {
                // Apenas construa o HomeContainer. Ele cuidará da própria navegação.
                return HomeContainer(
                  repository: repository,
                );
              },
            );

          case '/details':
            return MaterialPageRoute(
              builder: (context) {
                return Detailcontainer(
                  repository: repository,
                  arguments: (settings.arguments as DetailArguments),
                );
              },
            );

          default:
            // É uma boa prática retornar uma página de erro em vez de null.
            return MaterialPageRoute(
              builder: (context) => const Scaffold(
                body: Center(
                  child: Text('Página não encontrada!'),
                ),
              ),
            );
        }
      },
    );
  }
}