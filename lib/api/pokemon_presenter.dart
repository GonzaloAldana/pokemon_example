import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pokemon_example/model/pokemon.dart';
import 'package:pokemon_example/model/request.dart';

/// Fetches the pokeapi
class PokemonPresenter {
  final _apiUrl = 'https://pokeapi.co/api/v2';

  /// Gets the list of pokemons given an offset and limit of results
  Future<Request> getPokemonList(int limit, int offset) async {
    try {
      var url = Uri.parse('$_apiUrl/pokemon?limit=$limit&offset=$offset');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var decoded = jsonDecode(response.body);
        var result = Request.fromJson(decoded);
        return result;
      } else {
        return Request(0, null, null, []);
      }
    } catch (e) {
      print(e);
      return Request(0, null, null, []);
    }
  }

  /// Get the information of a pokemon given its ID
  Future<Pokemon> getPokemonById(int id) async {
    try {
      var url = Uri.parse('$_apiUrl/pokemon/$id');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var decoded = jsonDecode(response.body);
        var result = Pokemon.fromJson(decoded);
        return result;
      } else {
        return Pokemon([], 0, 0, {}, [], 0, '');
      }
    } catch (e) {
      print(e);
      return Pokemon([], 0, 0, {}, [], 0, '');
    }
  }
}
