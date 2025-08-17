import 'package:flutter/material.dart';
import 'package:pokedex_flutter_team_creator/Features/pokedex/screens/details/container/detail_container.dart';
import '../../../../../common/models/pokemon.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
    required this.list,
    required this.onItemTap,
  });

  final List<Pokemon> list;
  final Function(String, DetailArguments) onItemTap;

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

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: ListTile(
              onTap: () {
                onItemTap(
                  '/details',
                  DetailArguments(name: pokemon.name),
                );
              },
              leading: Image.network(
                pokemon.sprite,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  );
                },
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.error),
              ),
              title: Text(
                '#${pokemon.num.toString().padLeft(4, '0')} - ${pokemon.name}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(pokemon.types.join(', ')),
              trailing: const Icon(Icons.navigate_next),
            ),
          );
        },
      ),
    );
  }
}
