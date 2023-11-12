import 'dart:convert';

ProfileRes profileResFromJson(String str) => ProfileRes.fromJson(json.decode(str));


class ProfileRes {
    ProfileRes({
        required this.id,
        required this.username,
        required this.email,
        // required this.isAdmin,
        required this.isAgent,
        required this.skills,
        required this.profile,
    });

    final String id;
    final String username;
    final String email;
    // final bool isAdmin;
    final bool isAgent;
    final bool skills;
    final String profile;

    factory ProfileRes.fromJson(Map<String, dynamic> json) => ProfileRes(
        id: json["_id"],
        username: json["username"],
        email: json["email"],
        // isAdmin: json["isAdmin"],
        isAgent: json["isAgent"],
        skills: json['skills'],
        profile: json["profile"],
    );


}
