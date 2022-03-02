import 'dart:convert';

import 'package:retkipaikka_flutter/helpers/api/base_api.dart';
import 'package:retkipaikka_flutter/models/triplocation_model.dart';

class TripLocationApi extends BaseApi {
  TripLocationApi({String route = "/Triplocations"}) : super(route);

  List<TripLocation> jsonToTriplocation(List<dynamic> json) {
    List<TripLocation> returnList = [];
    for (var item in json) {
      returnList.add(TripLocation.fromJson(item));
    }
    return returnList;
  }

  Future<List<TripLocation>> getAcceptedLocations() async {
    Map<String,dynamic> params = {
      "filter": jsonEncode({
        "where":{
          "location_accepted":true
        },
        "limitedFields":true
      })
      
    };

    dynamic response =
        await get("/fetchLocations", params);

    return jsonToTriplocation(parseResponse(response));
  }


  Future<TripLocation?> getSingleLocation(String id) async{
      Map<String,dynamic> params = {
        "filter":jsonEncode({
          "where":{
            "location_id":id
          }
        })
      };
    

      dynamic response = await get("/fetchLocations", params);
      List<dynamic> json = parseResponse(response);
      TripLocation? location;
      if(json.isNotEmpty){
         location = TripLocation.fromJson(json[0]);
      }
      
      return location;

  }
}
