class Profile {
  String placeName;
  double latitude;
  double longitude;
  String placeId;
  String placeFormattedAddress;

  Profile(
      {this.placeId,
      this.latitude,
      this.longitude,
      this.placeName,
      this.placeFormattedAddress});
}
