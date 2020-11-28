class TriviaCategoryRemote {
  TriviaCategoryRemote({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory TriviaCategoryRemote.fromJson(Map<String, dynamic> json) =>
      TriviaCategoryRemote(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
