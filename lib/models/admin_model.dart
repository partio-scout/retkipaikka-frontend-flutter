class AdminUser {
  final String id;
  final String token;
  final String notifications;
  final String userNotifications;
  final String username;
  final String email;
  final List<dynamic> roles;
  final List<dynamic> regions;
  final bool newUser;

  AdminUser(
      {required this.id,
      required this.token,
      required this.notifications,
      required this.userNotifications,
      required this.username,
      required this.email,
      required this.roles,
      required this.regions,
      required this.newUser});

  factory AdminUser.fromJson(Map<String, dynamic> json) {
    print(json);
    return AdminUser(
        id: json["userId"],
        token: json["id"],
        notifications: json["user"]["notifications"],
        userNotifications: json["user"]["user_notifications"],
        username: json["user"]["username"],
        email: json["user"]["email"],
        roles: json["user"]["roles"],
        regions: json["user"]["regions"],
        newUser: json["user"]["new_user"]);
  }


   static Map<String,dynamic> toJson(AdminUser user) {
      return {
        "userId":user.id,
        "id":user.token,
        "user":{
          "notifications":user.notifications,
          "user_notifications":user.notifications,
          "username":user.username,
          "email":user.email,
          "roles":user.roles,
          "regions":user.regions,
          "new_user":user.newUser,
        }
      };
   
  }
}
