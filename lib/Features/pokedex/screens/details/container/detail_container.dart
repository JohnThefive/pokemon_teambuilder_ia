import 'package:flutter/material.dart';
import 'package:pokedex_flutter_team_creator/Features/pokedex/screens/details/pages/detail_page.dart';
import 'package:pokedex_flutter_team_creator/common/models/pokemon.dart';
import 'package:pokedex_flutter_team_creator/common/models/repositories/pokemon_repository.dart';
import 'package:pokedex_flutter_team_creator/common/widgets/po_error.dart';
import 'package:pokedex_flutter_team_creator/common/widgets/po_loading.dart';



class DetailArguments {
  final String name;
  DetailArguments({required this.name});
}

class Detailcontainer extends StatelessWidget {
 const Detailcontainer({super.key, required this.repository, required this.arguments});


 
  final IPokemonRepository repository;
  final DetailArguments arguments;


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Pokemon>(

      future: repository.getPokemon(name: arguments.name),

      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const PoLoading();
        }

        if (snapshot.hasError) {
          return PoError(error: snapshot.error.toString());
        }

        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return DetailPage(pokemon: snapshot.data!, name: '',);
        }

        return const PoLoading();
      },
    );
  }
}