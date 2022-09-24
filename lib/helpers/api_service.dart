import 'package:retkipaikka_flutter/helpers/api/filtering_api.dart';
import 'package:retkipaikka_flutter/helpers/api/notification_api.dart';
import 'package:retkipaikka_flutter/helpers/api/triplocation_api.dart';
import 'package:retkipaikka_flutter/helpers/api/user_api.dart';

class ApiService {
  ApiService._privateConstructor();
  final FilteringApi _filteringApi = FilteringApi();
  final TripLocationApi _tripLocationApi = TripLocationApi();
  final NotificationApi _notificationApi = NotificationApi();
  final UserApi _userApi = UserApi();
  static final ApiService _instance = ApiService._privateConstructor();

  FilteringApi get filteringApi => _filteringApi;
  TripLocationApi get triplocationApi => _tripLocationApi;
  NotificationApi get notificationApi => _notificationApi;
  UserApi get userApi => _userApi;

  factory ApiService() {
    return _instance;
  }
}
