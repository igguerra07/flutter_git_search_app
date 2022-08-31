class UserModel {
  final String? bio;
  final String login;
  final int followers;
  final String? location;
  final int publicRepos;
  final String avatarUrl;

  UserModel({
    required this.bio,
    required this.login,
    required this.location,
    required this.followers,
    required this.avatarUrl,
    required this.publicRepos,
  });

  Map<String, dynamic> toMap() {
    return {
      "bio": bio,
      "login": login,
      "location": location,
      "followers": followers,
      "avatar_url": avatarUrl,
      "public_repos": publicRepos,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      bio: json["bio"],
      login: json["login"] ?? "",
      location: json["location"],
      avatarUrl: json["avatar_url"] ?? "",
      followers: json["followers"]?.toInt() ?? 0,
      publicRepos: json["public_repos"]?.toInt() ?? 0,
    );
  }

  static List<UserModel> fromJsonList(List json) {
    return List.from(json.map((e) => UserModel.fromJson(e)));
  }
}
