class Experts {
  String userId;
  String name;
  String profession;
  String avatar;
  String latitude;
  String longitude;

  Experts(
      {this.userId,
      this.name,
      this.profession,
      this.avatar,
      this.latitude,
      this.longitude});

  Experts.fromJson(Map<dynamic, dynamic> json) {
    userId = json['_id'];

    profession = json['profession'];

    name = json['name'];
    if (json['user'] != null) {
      latitude = json['user']['latitude'].toString();
      longitude = json['user']['longitude'].toString();
      avatar = json['user']['avatar'];
    }
    print('elias');
    print(latitude);
  }
}
