import 'dart:convert';

List<Skills> skillsFromJson(String str) => List<Skills>.from(json.decode(str).map((x) => Skills.fromJson(x)));

String skillsToJson(List<Skills> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Skills {
    final String id;
    final String skill;

    Skills({
        required this.id,
        required this.skill,
    });

    factory Skills.fromJson(Map<String, dynamic> json) => Skills(
        id: json["_id"],
        skill: json["skill"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "skill": skill,
    };
}
