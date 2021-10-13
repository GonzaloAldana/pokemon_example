import 'package:json_annotation/json_annotation.dart';

part 'pokemon.g.dart';

@JsonSerializable()
class Pokemon {
  List abilities, stats;
  int weight, id, height;
  Map sprites;
  String name;

  Pokemon(this.abilities, this.height, this.id, this.sprites, this.stats,
      this.weight, this.name);

  factory Pokemon.fromJson(Map<String, dynamic> json) =>
      _$PokemonFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonToJson(this);
}
