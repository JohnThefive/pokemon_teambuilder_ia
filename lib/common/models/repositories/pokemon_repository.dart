import 'package:dio/dio.dart';
import '../../consts/api_consts.dart';
import '../pokemon.dart';

abstract class IPokemonRepository {
  // Adicionamos um parâmetro para tornar a função mais flexível
  Future<List<Pokemon>> getAllPokemons({int limit = 50});
}

class PokemonRepository implements IPokemonRepository {
  final Dio dio;

  PokemonRepository({required this.dio});

  @override
  Future<List<Pokemon>> getAllPokemons({int limit = 50}) async {
    try {
      // 1. Busca a lista inicial de Pokémon usando a classe ApiConsts
      final listResponse = await dio.get(ApiConsts.allPokemonsURL(limit: limit));
      final List<dynamic> results = listResponse.data['results'];

      // 2. Prepara uma lista de chamadas futuras para buscar os detalhes de cada Pokémon
      final List<Future<Pokemon>> pokemonFutures = results.map((pokemonData) async {
        // Pega a URL de detalhes de cada Pokémon da lista
        final String pokemonDetailUrl = pokemonData['url'];
        
        // Faz a SEGUNDA chamada para obter os detalhes
        final detailResponse = await dio.get(pokemonDetailUrl);
        
        // Cria o objeto Pokemon a partir do JSON de DETALHES (que contém a imagem)
        return Pokemon.fromJson(detailResponse.data);
      }).toList();

      // 3. Executa todas as chamadas de detalhes em paralelo e espera a conclusão
      return await Future.wait(pokemonFutures);

    } catch (e) {
      rethrow ;//Failures(message:'não foi possível carregar os dados');
    }
  }
}