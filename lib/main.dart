import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokemon_example/provider/pokemon_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PokemonProvider()),
      ],
      child: GetMaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

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

    return Scaffold(
        body: Column(
      children: [
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            controller: _controller,
            itemCount: pokemonProvider.pokemonList.length,
            itemBuilder: (BuildContext context, int i) {
              var poke = pokemonProvider.pokemonList[i];
              return ListTile(
                  title: Text(poke['name']),
                  leading: CircleAvatar(
                    child: Text(poke['name'][0].toUpperCase()),
                  ),
                  trailing: Icon(Icons.chevron_right_outlined));
            },
          ),
        ),
        if (pokemonProvider.pokemonRequestIsLoading) CircularProgressIndicator()
      ],
    ));
  }
}
