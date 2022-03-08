import 'package:retkipaikka_flutter/contants.dart';
import 'package:retkipaikka_flutter/helpers/api/category_api.dart';
import 'package:retkipaikka_flutter/helpers/api/filter_api.dart';
import 'package:retkipaikka_flutter/helpers/api/municipality_api.dart';
import 'package:retkipaikka_flutter/helpers/api/region_api.dart';
import 'package:retkipaikka_flutter/models/filter_model.dart';
import 'package:retkipaikka_flutter/models/geo_area_model.dart';

class FilteringApi {
  final MunicipalityApi municipalityApi = MunicipalityApi();
  final RegionApi regionApi = RegionApi();
  final CategoryApi categoryApi = CategoryApi();
  final FilterApi filterApi = FilterApi();

  List<GeoArea> jsonToGeoArea(List<dynamic> json) {
    List<GeoArea> returnList = [];
    for (var item in json) {
      returnList.add(GeoArea.fromJson(item));
    }
    return returnList;
  }

  List<Filter> jsonToFilter(List<dynamic> json) {
    List<Filter> returnList = [];

    for (var item in json) {
      returnList.add(Filter.fromJson(item));
    }
    return returnList;
  }

  Future<List<GeoArea>> getMunicipalities() async {
    dynamic response = await municipalityApi.get("", null);
    List<dynamic> municipalities = municipalityApi.parseResponse(response);

    return jsonToGeoArea(municipalities);
  }

  Future<List<GeoArea>> getRegions() async {
    dynamic response = await regionApi.get("", null);
    List<dynamic> regions = regionApi.parseResponse(response);
    return jsonToGeoArea(regions);
  }

  Future<List<Filter>> getFilters() async {
    dynamic response = await filterApi.get("", null);
    List<dynamic> filters = filterApi.parseResponse(response);
    return jsonToFilter(filters);
  }

  Future<void> createFilter(Map<String, dynamic> data) async {
    Map<String, dynamic> dataCpy = Map.from(data);
    if (dataCpy["object_type"] == null) {
      dataCpy["object_type"] = filterTypetoType(kfilterType.filter);
    }
    dynamic res = await filterApi.post("/", dataCpy);
    return filterApi.parseResponse(res);
  }

  Future<void> updateFilter(Map<String, dynamic> data, int filterId) async {
    dynamic res = await filterApi.patch("/" + filterId.toString(), data);

    return filterApi.parseResponse(res);
  }

  Future<void> createCategory(Map<String, dynamic> data) async {
    Map<String, dynamic> dataCpy = Map.from(data);
    if (dataCpy["object_type"] == null) {
      dataCpy["object_type"] = filterTypetoType(kfilterType.category);
    }
    dynamic res = await categoryApi.post("/", dataCpy);
    return categoryApi.parseResponse(res);
  }

  Future<void> updateCategory(Map<String, dynamic> data, int categoryId) async {
    dynamic res = await categoryApi.patch("/" + categoryId.toString(), data);

    return categoryApi.parseResponse(res);
  }

  Future<void> deleteFilter(int filterId) async {
    dynamic res = await filterApi
        .get("/" + filterId.toString() + "/triplocations/count", {});
    Map<String, dynamic> countData = filterApi.parseResponse(res);
    if (countData["count"] == 0) {
      dynamic response = await filterApi.delete("/" + filterId.toString(), {});
      return filterApi.parseResponse(response);
    } else {
      throw "Error: You can't delete a filter that is in use!";
    }
  }

  Future<void> deleteCategory(int categoryId) async {
    dynamic res = await categoryApi
        .get("/" + categoryId.toString() + "/triplocations/count", {});
    Map<String, dynamic> countData = categoryApi.parseResponse(res);
    if (countData["count"] == 0) {
      dynamic response =
          await categoryApi.delete("/" + categoryId.toString(), {});
      return categoryApi.parseResponse(response);
    } else {
      throw "Error: You can't delete a category that is in use!";
    }
  }

  Future<List<Filter>> getCategories() async {
    dynamic response = await categoryApi.get("", null);
    List<dynamic> categories = categoryApi.parseResponse(response);
    return jsonToFilter(categories);
  }
}
