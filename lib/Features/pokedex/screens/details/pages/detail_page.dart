import 'package:flutter/material.dart';
import 'package:pokedex_flutter_team_creator/common/models/pokemon.dart';

// PAGE: Lida apenas com a exibição da UI
class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.pokemon, required String name});
  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pokemon.baseColor, // Cor de fundo baseada no tipo
      appBar: AppBar(
        title: Text(pokemon.name),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent, // AppBar transparente
      ),
      body: Stack(
        children: [
          // Card branco com os detalhes
          Container(
            margin: const EdgeInsets.only(top: 80), // Espaço para a imagem
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 60, 24, 24), // Espaço extra no topo
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // NOME E NÚMERO
                  Text(
                    '#${pokemon.num.padLeft(4, '0')} - ${pokemon.name}',
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),

                  // TIPOS
                  _buildSectionTitle('Types'),
                  _buildChipList(pokemon.types),
                  const SizedBox(height: 16),

                  // HABILIDADES
                  _buildSectionTitle('Abilities'),
                  _buildChipList(pokemon.abilities),
                  const SizedBox(height: 16),
                  
                  // ALTURA E PESO
                  _buildHeightAndWeight(),
                  const SizedBox(height: 16),

                  // ESTATÍSTICAS BASE
                  _buildSectionTitle('Base Stats'),
                  _buildStatsList(pokemon.stats),
                ],
              ),
            ),
          ),

          // Imagem do Pokémon (flutuando sobre o card)
          Align(
            alignment: Alignment.topCenter,
            child: Image.network(
              pokemon.sprite,
              height: 140,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }

  // Widgets auxiliares para manter o build limpo
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildChipList(List<String> items) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      children: items.map((item) => Chip(
        label: Text(item),
        backgroundColor: pokemon.baseColor?.withValues(alpha:0.1),
      )).toList(),
    );
  }

  Widget _buildHeightAndWeight() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildInfoColumn('Height', '${pokemon.height / 10} m'),
        _buildInfoColumn('Weight', '${pokemon.weight / 10} kg'),
      ],
    );
  }
  
  Widget _buildInfoColumn(String label, String value) {
    return Column(
      children: [
        Text(label, style: const TextStyle(color: Colors.grey)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildStatsList(List<PokemonStat> stats) {
    return Column(
      children: stats.map((stat) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            children: [
              Expanded(flex: 2, child: Text(stat.name, style: const TextStyle(color: Colors.grey))),
              Expanded(flex: 1, child: Text(stat.baseStat.toString(), style: const TextStyle(fontWeight: FontWeight.bold))),
              Expanded(
                flex: 5,
                child: LinearProgressIndicator(
                  value: stat.baseStat / 255.0, // Valor máximo de stat é 255
                  backgroundColor: pokemon.baseColor?.withValues(alpha:0.2),
                  valueColor: AlwaysStoppedAnimation<Color>(pokemon.baseColor!),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}