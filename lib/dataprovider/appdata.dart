import 'package:experttrack/datamodels/User.dart';
import 'package:experttrack/datamodels/address.dart';
import 'package:flutter/cupertino.dart';

class AppData extends ChangeNotifier {
  Address meetingAddress;
  void updateMeetingAddress(Address meeting) {
    meetingAddress = meeting;
    notifyListeners();
  }

  void updateUser(User user) {
    notifyListeners();
  }
}
