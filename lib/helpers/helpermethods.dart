import 'package:google_maps_flutter/google_maps_flutter.dart';

class HelperMethods {
  // static Future<String> findCordinateAddress(Position position, context) async {
  //   String placeAddress = '';
  //   var connectivityResult = await Connectivity().checkConnectivity();
  //   if (connectivityResult != ConnectivityResult.mobile &&
  //       connectivityResult != ConnectivityResult.wifi) {
  //     return placeAddress;
  //   }
  //   //
  //   // String url =
  //   //     'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapKey';
  //   // var response = await RequestHelper.getRequest(url);
  //   // if (response != 'failed') {
  //   //   //response the first json from results data with name of formatted address
  //   //   placeAddress = response['results'][0]['formatted_address'];
  //   //   Address meetingAddress = new Address();
  //   //   meetingAddress.longitude = position.longitude;
  //   //   meetingAddress.latitude = position.latitude;
  //   //   meetingAddress.placeName = placeAddress;
  //   //
  //   //   Provider.of<AppData>(context, listen: false)
  //   //       .updateMeetingAddress(meetingAddress);
  //   }
  //   // return placeAddress;
  // }

  void getExpertsDetail(LatLng position) async {}
}
