class ApiConsts {
  // É privada (_) porque só será usada dentro desta classe.
  static const String _apiBaseUrl = "https://pokeapi.co/api/v2/";


  //  Método para obter a URL da lista de Pokémon (com paginação)
  //  Usar parâmetros nomeados com valores padrão torna o método flexível.
  static String allPokemonsURL({int limit = 151, int offset = 0}) {
    return "${_apiBaseUrl}pokemon?limit=$limit&offset=$offset";
  }

  // Método para obter a URL de um Pokémon específico pelo ID
  // Altere para esperar um TEXTO (String)
  static String pokemonDetailsURL(String pokemonName) {
    return "${_apiBaseUrl}pokemon/$pokemonName/";
}
}