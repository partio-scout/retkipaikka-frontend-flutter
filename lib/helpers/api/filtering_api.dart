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

  List<Filter> jsonToFilter(List<dynamic> json){
    List<Filter> returnList = [];

    for (var item in json) {
      returnList.add(Filter.fromJson(item));
    }
    return returnList;

  }

  Future<List<GeoArea>> getMunicipalities() async {
    List<dynamic> municipalities = await municipalityApi.getAllMunicipalities();

    return jsonToGeoArea(municipalities);
  }

  Future<List<GeoArea>> getRegions() async {
    List<dynamic> regions = await regionApi.getAllRegions();

    return jsonToGeoArea(regions);
  }


  Future<List<Filter>> getFilters() async{
    List<dynamic> filters = await filterApi.getAllFilters();

    return jsonToFilter(filters);


  }

  Future<List<Filter>> getCategories() async{
    List<dynamic> categories = await categoryApi.getAllCategories();

    return jsonToFilter(categories);




  }
  
}
