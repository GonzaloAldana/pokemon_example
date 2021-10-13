import 'package:flutter/foundation.dart';
import 'package:pokemon_example/api/pokemon_presenter.dart';
import 'package:pokemon_example/model/request.dart';

class PokemonProvider with ChangeNotifier {
  final _presenter = PokemonPresenter();

  /// The actual chunk retrieved by the API
  Request pokemonRequest = Request(0, null, null, []);

  /// All the pokemons retrieved from de API
  List pokemonList = [];
  bool pokemonRequestIsLoading = false;

  int offset = 0, limit = 20;

  void setPokemonRequestIsLoading(bool status) {
    pokemonRequestIsLoading = status;
    notifyListeners();
  }

  /// Will get the next pokemon chunk and adds it to the list
  /// using the offset and limit
  Future<void> getNextPokemonRequest() async {
    setPokemonRequestIsLoading(true);
    pokemonRequest = await _presenter.getPokemonList(limit, offset);
    pokemonList = [...pokemonList, ...pokemonRequest.results];
    if (pokemonRequest.next!.isNotEmpty) {
      offset += limit;
    }
    setPokemonRequestIsLoading(false);
    notifyListeners();
  }
}
