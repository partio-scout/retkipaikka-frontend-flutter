import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:retkipaikka_flutter/controllers/filtering_state.dart';
import 'package:retkipaikka_flutter/helpers/alert_helper.dart';
import 'package:retkipaikka_flutter/helpers/api/filtering_api.dart';
import 'package:provider/provider.dart';

void useFetchFilters(BuildContext context, {ValueNotifier<bool>? isLoading}) {
  useEffect(() {
    Future.microtask(() async {
      FilteringState fState = context.read<FilteringState>();
      if (fState.allMunicipalities.isEmpty ||
          fState.allRegions.isEmpty ||
          fState.allCategoryFilters.isEmpty ||
          fState.allCategoryFilters.isEmpty) {
        if (isLoading != null) {
          isLoading.value = true;
        }
        FilteringApi filteringApi = FilteringApi();
        await filteringApi.getMunicipalities().then((value) {
          fState.setMunicipalities(value);
          return filteringApi.getRegions();
        }).then((data) {
          fState.setRegions(data);
          return filteringApi.getCategories();
        }).then((data) {
          fState.setCategoryFilters(data);
          return filteringApi.getFilters();
        }).then((data) {
          fState.setCommonFilters(data);
        }).catchError((error) {
          if (kDebugMode) {
            print("FETCHING FILTERS ERROR");
          }
          AlertHelper.displayErrorAlert("Network error!", context);
        }).whenComplete(() {
          if (isLoading != null) {
            isLoading.value = false;
          }
        });
      } else {
        if (isLoading != null) {
          isLoading.value = false;
        }
      }
    });
    return null;
  }, []);
}
