import 'package:flutter/cupertino.dart';
import 'package:retkipaikka_flutter/constants.dart';
import 'package:retkipaikka_flutter/helpers/locales/translate.dart';
import 'package:retkipaikka_flutter/models/abstract_filter_model.dart';
import 'package:retkipaikka_flutter/models/filter_model.dart';
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
    commonFiltering = [];
    notifyListeners();
  }

  AbstractFilter getInitialCategoryFilter(BuildContext context) {
    return Filter(
        id: -1,
        type: FilterType.noCategory,
        name: "Ei kategorioita".t(context));
  }

  List<AbstractFilter> getCategoryFiltersForDropdown(BuildContext context) {
    return [getInitialCategoryFilter(context), ...allCategoryFilters];
  }

  AbstractFilter getInitialCommonFilter(BuildContext context) {
    return Filter(
        id: -1, type: FilterType.noFilter, name: "Ei suodattimia".t(context));
  }

  List<AbstractFilter> regionIdsToFilter(List<dynamic> ids) {
    List<AbstractFilter> geoList =
        allRegions.where((element) => ids.contains(element.id)).toList();
    return geoList;
  }

  List<AbstractFilter> getCommonFiltersForDropdown(BuildContext context) {
    return [getInitialCommonFilter(context), ...allCommonFilters];
  }

  void setCategoryFilters(List<AbstractFilter> categories) {
    allCategoryFilters = categories;
    categoryFiltering = [];
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

  AbstractFilter? findAreaFilterByName(dynamic value) {
    return [...allMunicipalities, ...allRegions]
        .firstWhereOrNull((element) => element.name == value);
  }

  void addCommonFilter(AbstractFilter filter) {
    if (!filterExistsInArray(commonFiltering, filter)) {
      commonFiltering.add(filter);
    }
    notifyListeners();
  }

  void addCategoryFilter(AbstractFilter filter) {
    if (!filterExistsInArray(categoryFiltering, filter)) {
      categoryFiltering.add(filter);
      notifyListeners();
    }
  }

  void addLocationFilter(AbstractFilter area) {
    if (!filterExistsInArray(locationFiltering, area)) {
      locationFiltering.add(area);
    }
    notifyListeners();
  }

  bool filterExistsInArray(
      List<AbstractFilter> filterList, AbstractFilter filter) {
    return filterList.indexWhere((element) => element.id == filter.id) != -1;
  }

  AbstractFilter? getCategoryForLocation(TripLocation location) {
    AbstractFilter? category = allCategoryFilters
        .firstWhereOrNull((element) => element.id == location.category);
    return category;
  }

  AbstractFilter? getCategoryById(int? id) {
    if (id == null) return null;
    AbstractFilter? category =
        allCategoryFilters.firstWhereOrNull((element) => element.id == id);
    return category;
  }

  AbstractFilter? getFilterById(int id) {
    AbstractFilter? filter =
        allCommonFilters.firstWhereOrNull((element) => element.id == id);
    return filter;
  }

  void handleFilterAdd(AbstractFilter filter) {
    switch (filter.type) {
      case FilterType.filter:
        addCommonFilter(filter);
        break;
      case FilterType.category:
        addCategoryFilter(filter);
        break;
      case FilterType.region:
      case FilterType.municipality:
        addLocationFilter(filter);
        break;
      case FilterType.noCategory:
        categoryFiltering = [];
        notifyListeners();
        break;
      case FilterType.noFilter:
        commonFiltering = [];
        notifyListeners();
        break;
      default:
        break;
    }
  }

  void handleFilterRemove(AbstractFilter filter) {
    switch (filter.type) {
      case FilterType.filter:
        removeCommonFilter(filter);
        break;
      case FilterType.category:
        removeCategoryFilter(filter);
        break;
      case FilterType.region:
      case FilterType.municipality:
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
