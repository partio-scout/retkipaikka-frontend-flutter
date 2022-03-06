import 'package:flutter/material.dart';
import 'package:retkipaikka_flutter/controllers/filtering_state.dart';
import 'package:retkipaikka_flutter/helpers/alert_helper.dart';
import 'package:retkipaikka_flutter/helpers/api/filtering_api.dart';
import 'package:retkipaikka_flutter/helpers/responsive.dart';
import 'package:retkipaikka_flutter/screens/admin/components/filter_form.dart';
import 'package:retkipaikka_flutter/screens/admin/components/filter_table.dart';
import 'package:provider/provider.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:retkipaikka_flutter/screens/admin/components/table_title.dart';

class AdminFiltersScreen extends HookWidget {
  AdminFiltersScreen({Key? key}) : super(key: key);
  final FilteringApi filteringApi = FilteringApi();

  Future<void> refreshFilters(BuildContext context) {
    return filteringApi.getFilters().then((res) {
      context.read<FilteringState>().setCommonFilters(res);
    }).catchError((err) {
      AlertHelper.displayErrorAlert(err, context);
    });
  }

  Future<void> refreshCategories(BuildContext context) {
    return filteringApi.getCategories().then((res) {
      context.read<FilteringState>().setCategoryFilters(res);
    }).catchError((err) {
      AlertHelper.displayErrorAlert(err, context);
    });
  }

  @override
  Widget build(BuildContext context) {
    var isLoading = useState<bool>(false);
    FilteringState fState = context.watch<FilteringState>();
    EdgeInsets padding = Responsive.isDesktop(context)
        ? const EdgeInsets.only(left: 100, right: 100, top: 20)
        : const EdgeInsets.only(left: 10, right: 10, top: 20);
    return SingleChildScrollView(
      child: Padding(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 25,
            ),
            FilterTable(
                tableData: fState.allCommonFilters,
                title: TableTitle(
                  text: "Suodattimet",
                  isLoading: isLoading.value,
                ),
                onRefreshClick: () {
                  isLoading.value = true;
                  refreshFilters(context)
                      .whenComplete(() => isLoading.value = false);
                }),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 25),
              child: FilterForm(
                  title: "Suodattimen lisääminen",
                  onSubmit: (data) {
                    filteringApi.createFilter(data).then((value) {
                      AlertHelper.displaySuccessAlert(
                          "Suodattimen luonti onnistui!", context, cb: (() {
                        isLoading.value = true;
                        refreshFilters(context)
                            .whenComplete(() => isLoading.value = false);
                      }));
                    }).catchError((err) {
                      AlertHelper.displayErrorAlert(err, context);
                    });
                  }),
            ),
            FilterTable(
                tableData: fState.allCategoryFilters,
                title: TableTitle(
                  text: "Kategoriat",
                  isLoading: isLoading.value,
                ),
                onRefreshClick: () {
                  isLoading.value = true;
                  refreshCategories(context)
                      .whenComplete(() => isLoading.value = false);
                }),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: FilterForm(
                  title: "Kategorian lisääminen",
                  onSubmit: (data) {
                    filteringApi.createCategory(data).then((value) {
                      AlertHelper.displaySuccessAlert(
                          "Kategorian luonti onnistui!", context, cb: (() {
                        isLoading.value = true;
                        refreshCategories(context)
                            .whenComplete(() => isLoading.value = false);
                      }));
                    }).catchError((err) {
                      AlertHelper.displayErrorAlert(err, context);
                    });
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
