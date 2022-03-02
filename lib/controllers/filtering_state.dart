import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:retkipaikka_flutter/contants.dart';
import 'package:retkipaikka_flutter/models/abstract_filter_model.dart';
import 'package:retkipaikka_flutter/models/filter_model.dart';
import 'package:retkipaikka_flutter/models/geo_area_model.dart';
import 'package:retkipaikka_flutter/models/triplocation_model.dart';
import 'package:collection/collection.dart';

class FilteringState extends ChangeNotifier {
  List<AbstractFilter> allCommonFilters = [];
  List<AbstractFilter> allCategoryFilters = [];
  List<AbstractFilter> allRegions = [];
  List<AbstractFilter> allMunicipalities = [];

  List<AbstractFilter> locationFiltering = [];
  List<AbstractFilter> categoryFiltering = [];
  List<AbstractFilter> commonFiltering = [];
  void setCommonFilters(List<Filter> filters) {
    allCommonFilters = filters;
    notifyListeners();
  }

  void setCategoryFilters(List<AbstractFilter> categories) {
    allCategoryFilters = categories;
    notifyListeners();
  }

  void setRegions(List<AbstractFilter> regs) {
    allRegions = regs;
    notifyListeners();
  }

  void setMunicipalities(List<AbstractFilter> munics) {
    allMunicipalities = munics;
    notifyListeners();
  }

  AbstractFilter? findAreaFilterByName(dynamic value){
    return [...allMunicipalities,...allRegions].firstWhereOrNull((element) => element.name == value);
  }
  void addCommonFilter(AbstractFilter filter) {
    print(filter);
    
    if (!filterExistsInArray(commonFiltering, filter))
      commonFiltering.add(filter);
      notifyListeners();
  }

  void addCategoryFilter(AbstractFilter filter) {
    if (!filterExistsInArray(categoryFiltering, filter)) {
      categoryFiltering.add(filter);
      notifyListeners();
    }
  }

  void addLocationFilter(AbstractFilter area) {
    if (!filterExistsInArray(locationFiltering, area))
      locationFiltering.add(area);
      notifyListeners();
  }

  bool filterExistsInArray(
      List<AbstractFilter> filterList, AbstractFilter filter) {
    return filterList.indexWhere((element) => element.id == filter.id) != -1;
  }

  String? getCategoryForLocation(TripLocation location){
   AbstractFilter? category =  allCategoryFilters.firstWhereOrNull((element) => element.id == location.category);
    return category?.name;
  }

  String? getFilterNameById(int id){
    AbstractFilter? filter = allCommonFilters.firstWhereOrNull((element) => element.id == id);
    return filter?.name;
  }


  void handleFilterAdd(AbstractFilter filter) {
    switch (filter.type) {
      case kfilterType.filter:
        addCommonFilter(filter);
        break;
      case kfilterType.category:
        addCategoryFilter(filter);
        break;
      case kfilterType.region:
      case kfilterType.municipality:
        addLocationFilter(filter);
        break;
      case kfilterType.noCategory:
        categoryFiltering = [];
        notifyListeners();
        break;
      case kfilterType.noFilter:
        commonFiltering = [];
        notifyListeners();
        break;
      default:
      break;
    }
  }

  void handleFilterRemove(AbstractFilter filter){
        switch (filter.type) {
      case kfilterType.filter:
        removeCommonFilter(filter);
        break;
      case kfilterType.category:
        removeCategoryFilter(filter);
        break;
      case kfilterType.region:
      case kfilterType.municipality:
        removeLocationFilter(filter);
        break;
      default:
      break;
    }
  }

  void removeCommonFilter(AbstractFilter filter) {
    commonFiltering = removeFilterFromList(commonFiltering, filter);
    notifyListeners();
  }

  void removeCategoryFilter(AbstractFilter filter) {
    categoryFiltering = removeFilterFromList(categoryFiltering, filter);
    notifyListeners();
  }

  void removeLocationFilter(AbstractFilter area) {
    locationFiltering = removeFilterFromList(locationFiltering, area);
    notifyListeners();
  }

  List<AbstractFilter> removeFilterFromList(
      List<AbstractFilter> list, AbstractFilter filter) {
    return list.where((element) => element.name != filter.name).toList();
  }
}
