import 'package:retkipaikka_flutter/helpers/api/base_api.dart';

class ImageApi extends BaseApi {
  ImageApi({String route = "/Images"}) : super(route);

  Future<dynamic> deleteImagesByLocationId(String locationId) async {
    dynamic res = await delete("/" + locationId, null);

    return parseResponse(res);
  }
}
