import 'package:retkipaikka_flutter/helpers/api/base_api.dart';

class FilterApi extends BaseApi {
  FilterApi({String route = "/Filters"}) : super(route);

    Future<List<dynamic>> getAllFilters() async {
    dynamic filters = await get("/", null);

    return parseResponse(filters);
  }

}
