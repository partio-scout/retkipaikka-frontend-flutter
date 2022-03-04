import 'package:retkipaikka_flutter/helpers/api/base_api.dart';
import 'package:retkipaikka_flutter/models/admin_model.dart';

class UserApi extends BaseApi {
  UserApi({String route="/Users"}) : super(route);



  Future<AdminUser> login(Map<String,dynamic> loginData) async{

    dynamic response = await post("/login", loginData, queryParams: {"include":"user"});

    Map<String,dynamic> res =  parseResponse(response);
    return AdminUser.fromJson(res);

  }

  Future<bool> register(Map<String,dynamic> registerData) async{

    dynamic response = await post("/createUser",registerData);
    return parseResponse(response);
  }

  Future<void> logout(AdminUser? user) async {
    if(user == null) return;
    dynamic response = await post("/logout",{"access_token":user.token},queryParams: {"access_token":user.token});

    return parseResponse(response);
  }


  Future<bool> checkTokenValidity(String token) async{
    dynamic response = await get("/checkAccessToken/"+token,{});

    return parseResponse(response);
  }

}
