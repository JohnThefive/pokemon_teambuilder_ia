import 'package:flutter/material.dart';
import 'package:pokedex_flutter_team_creator/Features/pokedex/screens/home/container/home_container.dart';
import 'package:pokedex_flutter_team_creator/common/models/repositories/pokemon_repository.dart';

class PokedexRoute extends StatelessWidget {
  const PokedexRoute({super.key, required this.repository});
  final PokemonRepository repository;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: '/',
      onGenerateRoute: (settings) {
        if (settings.name == '/') {
          return MaterialPageRoute(
            builder: (context) {
              return HomeContainer(repository: repository);
            },
          );
        }
        return null;
        /*if (settings.name == '/details'){
          return MaterialPageRoute(
            builder: (context) {
              return HomeContainer(repository: repository);
            });

        }
      },*/
  });
  }
}
