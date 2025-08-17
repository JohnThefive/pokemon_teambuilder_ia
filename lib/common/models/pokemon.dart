
import 'package:flutter/material.dart';

class Pokemon {
  final String name;
  final String sprite;
  final List<String> types;
  final String num; 
  final Color? baseColor;
  // detalhes dos pokemons 
  final List<String> abilities;
  final int height; //altura 
  final int weight; //peso
  final List<PokemonStat> stats;


   const Pokemon({
    required this.name,
    required this.num,
    required this.sprite,
    required this.types,
    required this.abilities,
    required this.height,
    required this.weight,
    required this.stats,
    this.baseColor,
  });



  factory Pokemon.fromMap(Map<String, dynamic> json) {
    // Pega a lista de tipos e a cor base
    final types = (json['types'] as List)
        .map((e) => e['type']['name'] as String)
        .toList();

    // Pega as habilidades
    final abilities = (json['abilities'] as List)
        .map((e) => e['ability']['name'] as String)
        .toList();

    // Pega as estatísticas
    final stats = (json['stats'] as List)
        .map((e) => PokemonStat.fromMap(e))
        .toList();

    return Pokemon(
      name: json['name'],
      num: json['id'].toString(),
      sprite: json['sprites']['front_default'],
      types: types,
      abilities: abilities,
      height: json['height'],
      weight: json['weight'],
      stats: stats,
      baseColor: _colorForType(type: types.first),
    );
  }


  // Função auxiliar para definir a cor baseada no tipo
  static Color? _colorForType({required String type}) {
    switch (type) {
      case 'normal':
        return Colors.brown[400];
      case 'fire':
        return Colors.red;
      case 'water':
        return Colors.blue;
      case 'grass':
        return Colors.green;
      case 'electric':
        return Colors.amber;
      case 'ice':
        return Colors.cyanAccent[400];
      case 'fighting':
        return Colors.orange;
      case 'poison':
        return Colors.purple;
      case 'ground':
        return Colors.orange[300];
      case 'flying':
        return Colors.indigo[200];
      case 'psychic':
        return Colors.pink;
      case 'bug':
        return Colors.lightGreen[500];
      case 'rock':
        return Colors.grey;
      case 'ghost':
        return Colors.indigo[400];
      case 'dark':
        return Colors.brown;
      case 'dragon':
        return Colors.indigo[800];
      case 'steel':
        return Colors.blueGrey;
      case 'fairy':
        return Colors.pink[100];
      default:
        return Colors.grey;
    }
  }
}

  // refazer essa função depois 
  // É útil se você precisar converter seu objeto Pokemon de volta para um JSON.
  //Map<String, dynamic> toJson() {
    //return {
      //'name': name,
      //'sprite': sprite,
      //'num': num,
      //'types': types,
    //};
  //}

// função para axiliar nas estatisticas dos pokémons
class PokemonStat {
  final String name;
  final int baseStat;

  factory PokemonStat.fromMap(Map<String, dynamic> json) {
    return PokemonStat(
      name: json['stat']['name'],
      baseStat: json['base_stat'],
    );
  }

  PokemonStat({required this.name, required this.baseStat});
}
