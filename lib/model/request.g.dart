// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Request _$RequestFromJson(Map<String, dynamic> json) {
  return Request(
    json['count'] as int,
    json['next'] as String?,
    json['previous'] as String?,
    json['results'] as List<dynamic>,
  );
}

Map<String, dynamic> _$RequestToJson(Request instance) => <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'previous': instance.previous,
      'results': instance.results,
    };
