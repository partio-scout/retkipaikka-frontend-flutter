import 'dart:convert';

import 'package:retkipaikka_flutter/helpers/api/base_api.dart';
import 'package:retkipaikka_flutter/models/admin_model.dart';
import 'package:retkipaikka_flutter/models/role_model.dart';

class UsersContainer {
  List<AdminUser> newUsers;
  List<AdminUser> oldUsers;
  UsersContainer({required this.newUsers, required this.oldUsers});
}

class UserApi extends BaseApi {
  UserApi({String route = "/Users"}) : super(route);

  Future<AdminUser> login(Map<String, dynamic> loginData) async {
    dynamic response =
        await post("/login", loginData, queryParams: {"include": "user"});

    Map<String, dynamic> res = parseResponse(response);
    return AdminUser.fromJson(res);
  }

  Future<bool> register(Map<String, dynamic> registerData) async {
    dynamic response = await post("/createUser", registerData);
    return parseResponse(response);
  }

  Future<void> logout(AdminUser? user) async {
    if (user == null) return;
    dynamic response = await post("/logout", {"access_token": user.token},
        queryParams: {"access_token": user.token});

    return parseResponse(response);
  }

  List<AdminUser> userJsonToList(List<dynamic> json) {
    List<AdminUser> userList = [];
    for (var user in json) {
      Map<String, dynamic> fullUser = {
        "userId": user["admin_id"],
        "id": null,
        "user": user,
      };
      userList.add(AdminUser.fromJson(fullUser));
    }
    return userList;
  }

  List<Role> roleJsonToList(List<dynamic> json) {
    List<Role> roles = [];
    for (var role in json) {
      roles.add(Role.fromJson(role));
    }
    return roles;
  }

  Future<List<Role>> getAllRoles() async {
    dynamic response = await get("/fetchAllRoles", {});

    List<dynamic> roles = parseResponse(response);

    return roleJsonToList(roles);
  }

  Future<UsersContainer> getAllUsers() async {
    List<AdminUser> res = await _getUsers();
    List<AdminUser> newUsers = res.where((element) => element.newUser).toList();
    List<AdminUser> oldUsers =
        res.where((element) => !element.newUser).toList();

    return UsersContainer(newUsers: newUsers, oldUsers: oldUsers);
  }

  Future<List<AdminUser>> _getUsers({bool newUser = false}) async {
    Map<String, dynamic> query = {
      "include": jsonEncode([
        {"relation": "roles"}
      ])
    };
    dynamic response = await get("", query);

    List<dynamic> list = parseResponse(response);

    return userJsonToList(list);
  }

  Future<List<AdminUser>> getOldUsers() async {
    return _getUsers(newUser: false);
  }

  Future<void> modifyUserNotifications(
      String adminId, String notificationType, List<int> regions) async {
    Map<String, dynamic> params = {
      "user": {"admin_id": adminId, "notifications": notificationType},
      "regions": regions
    };

    dynamic response = await patch("/modifyUserNotifications", params);
    return parseResponse(response);
  }

  Future<void> changePassword(
      String adminId, Map<String, dynamic> payload) async {
    dynamic response = await post("/change-password", payload);

    return parseResponse(response);
  }

  Future<void> modifyUser(String adminId, Map<String, dynamic> payload) async {
    Map<String, dynamic> data = Map.from(payload);

    dynamic response = await patch("/editUser", data);
    return parseResponse(response);
  }

  Future<void> modifyOwnUserSettings(
      String adminId, Map<String, dynamic> payload) async {
    Map<String, dynamic> data = Map.from(payload);
    data["admin_id"] = adminId;
    dynamic response = await patch("/updateSettings", data);
    return parseResponse(response);
  }

  Future<void> deleteUserById(String adminId) async {
    dynamic response = await get("/" + adminId + "/regions/count", {});

    Map<String, dynamic> data = parseResponse(response);
    if (data["count"]! > 0) {
      dynamic regionDelRes = await delete("/" + adminId + "/regions", {});
      parseResponse(regionDelRes);
    }
    dynamic userDelRes = await delete("/" + adminId, {});
    return parseResponse(userDelRes);
  }

  Future<AdminUser> fetchSingleUser(String adminId, String? token) async {
    dynamic response = await get("/fetchUserData/" + adminId, {});

    Map<String, dynamic> res = parseResponse(response);

    Map<String, dynamic> fullUser = {
      "userId": adminId,
      "id": token,
      "user": res,
    };
    return AdminUser.fromJson(fullUser);
  }

  Future<bool> checkTokenValidity(String token) async {
    dynamic response = await get("/checkAccessToken/" + token, {});

    return parseResponse(response);
  }
}
