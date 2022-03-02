import 'package:retkipaikka_flutter/helpers/api/base_api.dart';

class CategoryApi extends BaseApi {
  CategoryApi({String route = "/Categories"}) : super(route);


    Future<List<dynamic>> getAllCategories() async {
    dynamic categories = await get("/", null);

    return parseResponse(categories);
  }
}
