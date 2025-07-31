
class Pokemon {
  final String name;
  final String sprite;
  final List<String> types;
  final String num; 

  const Pokemon({
    required this.name,
    required this.sprite,
    required this.types,
    required this.num,
  });

  // parte mais importante da definição 
  factory Pokemon.fromJson(Map<String, dynamic> json) {

    // primeiro vamos mapear a lista de tipos do pokemon 
     final List<String> pokemonTypes = (json['types'] as List)
        .map((typeInfo) => typeInfo['type']['name'] as String)
        .toList();



    // Aqui extraímos os valores do mapa JSON.
    return Pokemon(
      name: json['name'],
      sprite: json['sprites']['front_default'],
      num: json['id'].toString(),
      types: pokemonTypes,
    );
  }
  
  // É útil se você precisar converter seu objeto Pokemon de volta para um JSON.
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'sprite': sprite,
      'num': num,
      'types': types,
    };
  }
}