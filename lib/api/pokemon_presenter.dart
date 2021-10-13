import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pokemon_example/model/request.dart';

class PokemonPresenter {
  final _apiUrl = 'https://pokeapi.co/api/v2';

  Future<Request> getPokemonList(int limit, int offset) async {
    try {
      var url = Uri.parse('$_apiUrl/pokemon?limit=$limit&offset=$offset');
      var response = await http.get(url);
      var decoded = jsonDecode(response.body);
      var result = Request.fromJson(decoded);
      return result;
    } catch (e) {
      print(e);
      return Request(0, null, null, []);
    }
  }
}
