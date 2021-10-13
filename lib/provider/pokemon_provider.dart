import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:pokemon_example/api/pokemon_presenter.dart';
import 'package:pokemon_example/model/request.dart';

class PokemonProvider with ChangeNotifier {
  final _presenter = PokemonPresenter();

  Request pokemonRequest = Request(0, null, null, []);
  List pokemonList = [];
  bool pokemonRequestIsLoading = false;

  int offset = 0, limit = 20;

  void setPokemonRequestIsLoading(bool status) {
    pokemonRequestIsLoading = status;
    notifyListeners();
  }

  Future<void> getNextPokemonRequest() async {
    setPokemonRequestIsLoading(true);
    Get.snackbar('Loading more pokemons', '');
    await Future.delayed(Duration(seconds: 2));
    pokemonRequest = await _presenter.getPokemonList(limit, offset);
    pokemonList = [...pokemonList, ...pokemonRequest.results];
    if (pokemonRequest.next!.isNotEmpty) {
      offset += limit;
    }
    setPokemonRequestIsLoading(false);
    notifyListeners();
  }
}
