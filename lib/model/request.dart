import 'package:json_annotation/json_annotation.dart';

part 'request.g.dart';

@JsonSerializable()
class Request {
  int count;
  String? next, previous;
  List results;

  Request(this.count, this.next, this.previous, this.results);

  factory Request.fromJson(Map<String, dynamic> json) =>
      _$RequestFromJson(json);

  Map<String, dynamic> toJson() => _$RequestToJson(this);
}
