import 'package:image_picker/image_picker.dart';
import 'package:retkipaikka_flutter/helpers/api/base_api.dart';
import 'package:http/http.dart' as http;

class ImageApi extends BaseApi {
  ImageApi({String route = "/Images"}) : super(route);

  Future<dynamic> deleteImagesByLocationId(String locationId) async {
    dynamic res = await delete("/" + locationId, null);

    return parseResponse(res);
  }

  Future<void> deleteImageByLocationId(String locationId, String image) async {
    dynamic res = await delete("/" + locationId + "/files/" + image, {});

    return parseResponse(res);
  }

  Future<dynamic> postImagesForLocation(
      String locationId, List<XFile> images) async {
    Uri parsedUri = await buildUri("/" + locationId + "/upload", {});
    var request = http.MultipartRequest("POST", parsedUri);

    for (XFile img in images) {
      request.files.add(http.MultipartFile.fromBytes(
          "image", await img.readAsBytes(),
          filename: img.name));
    }

    var response = await request.send();
    var httpRes = await http.Response.fromStream(response);
    return parseResponse(httpRes);
  }
}
