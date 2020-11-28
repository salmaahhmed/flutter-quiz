class TriviaCategoryEntity {
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
}
