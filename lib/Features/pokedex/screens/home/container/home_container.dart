
import 'package:flutter/material.dart';
import 'package:pokedex_flutter_team_creator/Features/pokedex/screens/home/pages/home_loading.dart';
import 'package:pokedex_flutter_team_creator/Features/pokedex/screens/home/pages/home_page.dart';
import 'package:pokedex_flutter_team_creator/common/models/pokemon.dart';
import 'package:pokedex_flutter_team_creator/common/models/repositories/pokemon_repository.dart';

class HomeContainer extends StatelessWidget {

  const HomeContainer({super.key, required this.repository});
  final IPokemonRepository repository;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Pokemon>>(
      future: repository.getAllPokemons(),
      builder: (context, snapshot) {

        if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
          return HomePage(
            list: snapshot.data!,
            
            onItemTap: (routeName, arguments) {
              Navigator.of(context).pushNamed(
                routeName,
                arguments: arguments,
              );
            },
          );
        }

        return const HomeLoading();
      },
    );
  }
}