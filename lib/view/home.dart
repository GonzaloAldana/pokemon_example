import 'package:flutter/material.dart';
import 'package:pokemon_example/provider/pokemon_provider.dart';
import 'package:pokemon_example/view/pokemon_detail.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ScrollController _controller = ScrollController();
  late PokemonProvider unlistenedPokemonProvider;

  @override
  void initState() {
    super.initState();
    unlistenedPokemonProvider =
        Provider.of<PokemonProvider>(context, listen: false);
    unlistenedPokemonProvider.getNextPokemonRequest();
    _controller.addListener(_scrollListener);
  }

  /// Get the next pokemons when the bottom is reached by the user
  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      unlistenedPokemonProvider.getNextPokemonRequest();
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        print("reach the top");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var pokemonProvider = Provider.of<PokemonProvider>(context);

    var pokeList = ListView.builder(
      shrinkWrap: true,
      controller: _controller,
      itemCount: pokemonProvider.pokemonList.length,
      itemBuilder: (BuildContext context, int i) {
        var poke = pokemonProvider.pokemonList[i];

        var fn = () {
          var id = int.parse(poke['url'].split('/')[6]);

          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => PokemonDetail(id: id)));
        };

        return ListTile(
          key: Key(poke['name']),
          title: Text(poke['name']),
          leading: CircleAvatar(
            child: Text(poke['name'][0].toUpperCase()),
          ),
          trailing: Icon(Icons.chevron_right_outlined),
          onTap: fn,
        );
      },
    );

    return Scaffold(
        body: Column(
      children: [
        Expanded(
          child: pokeList,
        ),
        if (pokemonProvider.pokemonRequestIsLoading) CircularProgressIndicator()
      ],
    ));
  }
}
