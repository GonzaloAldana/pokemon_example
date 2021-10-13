// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pokemon _$PokemonFromJson(Map<String, dynamic> json) {
  return Pokemon(
    json['abilities'] as List<dynamic>,
    json['height'] as int,
    json['id'] as int,
    json['sprites'] as Map<String, dynamic>,
    json['stats'] as List<dynamic>,
    json['weight'] as int,
    json['name'] as String,
  );
}

Map<String, dynamic> _$PokemonToJson(Pokemon instance) => <String, dynamic>{
      'abilities': instance.abilities,
      'stats': instance.stats,
      'weight': instance.weight,
      'id': instance.id,
      'height': instance.height,
      'sprites': instance.sprites,
      'name': instance.name,
    };
