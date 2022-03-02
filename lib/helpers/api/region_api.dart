import 'package:retkipaikka_flutter/helpers/api/base_api.dart';

class RegionApi extends BaseApi {
  RegionApi({String route = "/Regions"}) : super(route);

  Future<List<dynamic>> getAllRegions() async {
    dynamic regions = await get("/", null);

    return parseResponse(regions);
  }
}
