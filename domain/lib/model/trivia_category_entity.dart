import 'package:clean_architecture_base/clean_architecture_base.dart';

class TriviaCategoryEntity extends Equatable {
  TriviaCategoryEntity({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory TriviaCategoryEntity.fromJson(Map<String, dynamic> json) =>
      TriviaCategoryEntity(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };

  @override
  List<Object> get props => [id, name];
}
