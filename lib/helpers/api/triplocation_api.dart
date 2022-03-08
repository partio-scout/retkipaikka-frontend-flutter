import 'dart:convert';

import 'package:image_picker/image_picker.dart';
import 'package:retkipaikka_flutter/helpers/api/base_api.dart';
import 'package:retkipaikka_flutter/helpers/api/image_api.dart';

import 'package:retkipaikka_flutter/models/triplocation_model.dart';
import 'package:http/http.dart' as http;

class TripLocationApi extends BaseApi {
  TripLocationApi({String route = "/Triplocations"}) : super(route);

  ImageApi imageApi = ImageApi();
  List<TripLocation> jsonToTriplocation(List<dynamic> json) {
    List<TripLocation> returnList = [];
    for (var item in json) {
      returnList.add(TripLocation.fromJson(item));
    }
    return returnList;
  }

  Future<List<TripLocation>> getAcceptedLocations(
      {bool limitedFields = true}) async {
    Map<String, dynamic> params = {
      "filter": jsonEncode({
        "where": {"location_accepted": true},
        "limitedFields": limitedFields,
        "order": "location_category ASC"
      }),
    };
    return await getLocations(params);
  }

  Future<List<TripLocation>> getNewLocations() async {
    Map<String, dynamic> params = {
      "filter": jsonEncode({
        "where": {"location_accepted": false},
        "limitedFields": false
      })
    };
    return await getLocations(params);
  }

  Future<List<TripLocation>> getLocations(Map<String, dynamic> params) async {
    dynamic response = await get("/fetchLocations", params);

    return jsonToTriplocation(parseResponse(response));
  }

  Future<TripLocation?> getSingleLocation(String id) async {
    Map<String, dynamic> params = {
      "filter": jsonEncode({
        "where": {"location_id": id},
        "limit": 1
      })
    };

    dynamic response = await get("/fetchLocations", params);
    List<dynamic> json = parseResponse(response);
    TripLocation? location;
    if (json.isNotEmpty) {
      location = TripLocation.fromJson(json[0]);
    }

    return location;
  }

  Future<dynamic> deleteLocationById(String locationId) async {
    Map<String, dynamic> params = {
      "locationData": jsonEncode({"location_id": locationId})
    };
    dynamic response =
        await delete("/deleteLocation", null, queryParams: params);
    parseResponse(response);

    dynamic imageDelResponse =
        await imageApi.deleteImagesByLocationId(locationId);

    return imageDelResponse;
  }

  Future<String> handleTripLocationPost(
      Map<String, dynamic> data, List<XFile> images) async {
    dynamic response = await _postTripLocation(data, images);
    return await parseResponse(response);
  }

  Future<void> deleteLocationImages(
      String locationId, List<String> images) async {
    for (var img in images) {
      await imageApi.deleteImageByLocationId(locationId, img);
    }
    return;
  }

  Future<void> handleTripLocationEdit(
      Map<String, dynamic> data, List<XFile> images) async {
    dynamic response = await patch("/editLocation", data);
    parseResponse(response);

    if (images.isNotEmpty) {
      await imageApi.postImagesForLocation(data["location_id"], images);
    }
    return;
  }

  Future<http.Response> _postTripLocation(
      Map<String, dynamic> data, List<XFile> images) async {
    Uri parsedUri = await buildUri("/addNewLocation", {});
    var request = http.MultipartRequest("POST", parsedUri);
    request.fields['object'] = jsonEncode(data);

    for (XFile img in images) {
      request.files.add(http.MultipartFile.fromBytes(
          "image", await img.readAsBytes(),
          filename: img.name));
    }

    var response = await request.send();
    return await http.Response.fromStream(response);
  }
}
