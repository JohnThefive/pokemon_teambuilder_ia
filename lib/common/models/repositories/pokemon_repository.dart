import 'package:dio/dio.dart';
import 'package:pokedex_flutter_team_creator/error/failures.dart';
import '../../consts/api_consts.dart';
import '../pokemon.dart';

abstract class IPokemonRepository {
  Future<List<Pokemon>> getAllPokemons({int limit = 50});
  Future<Pokemon> getPokemon({required String name});
}

class PokemonRepository implements IPokemonRepository {
  final Dio dio;

  PokemonRepository({required this.dio});

  @override
  Future<List<Pokemon>> getAllPokemons({int limit = 50}) async {
    try {
      final listResponse = await dio.get(ApiConsts.allPokemonsURL(limit: limit));
      final List<dynamic> results = listResponse.data['results'];

      final List<Future<Pokemon>> pokemonFutures = results.map((pokemonData) async {
        final String pokemonDetailUrl = pokemonData['url'];
        final detailResponse = await dio.get(pokemonDetailUrl);
        return Pokemon.fromMap(detailResponse.data);
      }).toList();

      return await Future.wait(pokemonFutures);
    } on DioException catch (e) {
      // Trate erros mais informativos com Dio
      throw Failures(message: 'Erro de rede ao buscar pokémons: ${e.message}');
    } catch (e) {
      throw Failures(message: 'Erro desconhecido ao buscar pokémons');
    }
  }

  @override
  Future<Pokemon> getPokemon({required String name}) async {
    try {
      final response = await dio.get(ApiConsts.pokemonDetailsURL(name));
      return Pokemon.fromMap(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        throw Failures(message: 'Pokémon "$name" não encontrado');
      }
      throw Failures(message: 'Erro ao buscar o Pokémon "$name": ${e.message}');
    } catch (e) {
      throw Failures(message: 'Erro desconhecido ao buscar o Pokémon "$name"');
    }
  }
}
