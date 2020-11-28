class TriviaCategoryModel {
  TriviaCategoryModel({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory TriviaCategoryModel.fromJson(Map<String, dynamic> json) =>
      TriviaCategoryModel(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
