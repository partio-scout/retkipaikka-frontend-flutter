import 'package:retkipaikka_flutter/helpers/api/base_api.dart';

class MunicipalityApi extends BaseApi {
  MunicipalityApi({String route = "/Municipalities"}) : super(route);

  Future<List<dynamic>> getAllMunicipalities() async {
    dynamic municipalities = await get("", null);

    return parseResponse(municipalities);
  }
}
