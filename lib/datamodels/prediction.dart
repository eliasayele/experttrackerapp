class Prediction {
  String userId;
  String name;
  String bio;
  String profession;
  String avatar;

  Prediction({
    this.name,
    this.userId,
    this.bio,
    this.profession,
    this.avatar,
  });

  Prediction.fromJson(Map<String, dynamic> json) {
    userId = json['_id'];
    name = json['name'];
    bio = json['bio'];
    profession = json['profession'];
    avatar = json['avatar'];
  }
}
