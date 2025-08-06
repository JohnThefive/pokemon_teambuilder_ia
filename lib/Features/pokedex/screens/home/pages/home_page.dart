import 'package:flutter/material.dart';
import '../../../../../common/models/pokemon.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.list});
  final List<Pokemon> list;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokédex'),
        centerTitle: true,
        elevation: 2,
      ),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          final pokemon = list[index];
          return Card( // Usar um Card deixa o visual mais agradável
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: ListTile(
              // LEADING: Exibe a imagem (sprite) à esquerda
              leading: Image.network(
                pokemon.sprite,
                // Adiciona um loading e um erro para a imagem, caso ela demore ou falhe
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const CircularProgressIndicator();
                },
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
              ),
              // TITLE: Exibe o número e o nome do Pokémon
              title: Text(
                '#${pokemon.num.toString().padLeft(4, '0')} - ${pokemon.name}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              // SUBTITLE: Exibe a lista de tipos
              subtitle: Text(pokemon.types.join(', ')), // Ex: "grass, poison"
              
              // TRAILING: Pode adicionar um ícone ou botão à direita
              trailing: const Icon(Icons.navigate_next),
              onTap: () {
                // Aqui você pode adicionar a navegação para uma tela de detalhes
                // ignore: avoid_print
                print('Clicou no ${pokemon.name}');
              },
            ),
          );
        },
      ),
    );
  }
}