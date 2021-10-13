import 'package:flutter/material.dart';
import 'package:pokemon_example/api/pokemon_presenter.dart';
import 'package:pokemon_example/model/pokemon.dart';

class PokemonDetail extends StatelessWidget {
  final int id;

  const PokemonDetail({Key? key, required this.id}) : super(key: key);
  static final _presenter = PokemonPresenter();

  @override
  Widget build(BuildContext context) {
    final pokemonBuilder = (BuildContext context, AsyncSnapshot<Pokemon> snp) {
      if (snp.connectionState != ConnectionState.done)
        return CircularProgressIndicator();

      var img = Image.network(snp.data!.sprites['front_default'],
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      });

      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          img,
          Text('Abilities: ' +
              snp.data!.abilities
                  .map((e) => e['ability']['name'])
                  .toList()
                  .toString()),
          Text('Name: ' + snp.data!.name),
          Text('Weight: ' + snp.data!.weight.toString()),
          Text('Height: ' + snp.data!.height.toString())
        ],
      );
    };

    return Scaffold(
      body: Center(
        child: FutureBuilder(
            future: _presenter.getPokemonById(id), builder: pokemonBuilder),
      ),
    );
  }
}
