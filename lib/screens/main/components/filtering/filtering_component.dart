import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:retkipaikka_flutter/contants.dart';
import 'package:retkipaikka_flutter/controllers/filtering_state.dart';
import 'package:retkipaikka_flutter/controllers/triplocation_state.dart';
import 'package:retkipaikka_flutter/helpers/alert_helper.dart';
import 'package:retkipaikka_flutter/helpers/api/filtering_api.dart';
import 'package:retkipaikka_flutter/helpers/components/custom_autocomplete.dart';
import 'package:retkipaikka_flutter/helpers/components/custom_dropdown_button.dart';
import "package:provider/provider.dart";
import 'package:retkipaikka_flutter/helpers/components/dynamic_layout_wrapper.dart';
import 'package:retkipaikka_flutter/helpers/responsive.dart';
import 'package:retkipaikka_flutter/models/abstract_filter_model.dart';
import 'package:retkipaikka_flutter/models/filter_model.dart';
import 'package:retkipaikka_flutter/models/geo_area_model.dart';
import 'package:retkipaikka_flutter/screens/main/components/filtering/tag_bar.dart';

class FilteringComponent extends HookWidget {
  FilteringComponent({Key? key, this.backgroundColor = const Color(0xFFe4dfdf)})
      : super(key: key);
  final FilteringApi filteringApi = FilteringApi();
  final Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    FilteringState filteringState = context.watch<FilteringState>();
    var loading = useState<bool>(true);
    // List<AbstractFilter> allCommonFilters =
    // List<AbstractFilter> allCategoryFilters = [];
    // List<AbstractFilter> allRegions = [];
    // List<AbstractFilter> allMunicipalities = [];
    useEffect(() {
      Future.microtask(() async {
        if (filteringState.allMunicipalities.isEmpty ||
            filteringState.allRegions.isEmpty ||
            filteringState.allCategoryFilters.isEmpty ||
            filteringState.allCategoryFilters.isEmpty) {
          await filteringApi.getMunicipalities().then((value) {
            filteringState.setMunicipalities(value);
            return filteringApi.getRegions();
          }).then((data) {
            filteringState.setRegions(data);
            return filteringApi.getCategories();
          }).then((data) {
            filteringState.setCategoryFilters(data);
            return filteringApi.getFilters();
          }).then((data) {
            filteringState.setCommonFilters(data);
          }).catchError((error) {
            print("FETCHING FILTERS ERROR");
            AlertHelper.displayErrorAlert("Network error!", context);
          }).whenComplete(() => loading.value = false);
        } else {
          loading.value = false;
        }
      });
    }, []);

    return Container(
      width: double.infinity,
      // height: 90,
      color: backgroundColor,
      child: Wrap(children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Flex(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            direction:
                Responsive.isDesktop(context) ? Axis.horizontal : Axis.vertical,
            children: [
              DynamicLayoutWrapper(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomAutocomplete(
                    data: [
                      ...filteringState.allMunicipalities,
                      ...filteringState.allRegions
                    ],
                    disabled: loading.value,
                    title: "Sijainti",
                    onValueSelect: (AbstractFilter value) {
                      filteringState.handleFilterAdd(value);
                    },
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              DynamicLayoutWrapper(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomDropdownButton(
                      bgColor: Colors.white,
                      focusColor: Colors.white,
                      title: "Tyyppi",
                      disabled: loading.value,
                      onDropdownChange: (AbstractFilter value) {
                        filteringState.handleFilterAdd(value);
                      },
                      initialValue: filteringState.getInitialCategoryFilter(),
                      dropdownData:
                          filteringState.getCategoryFiltersForDropdown()),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              DynamicLayoutWrapper(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomDropdownButton(
                      bgColor: Colors.white,
                      focusColor: Colors.white,
                      title: "Suodattimet",
                      disabled: loading.value,
                      onDropdownChange: (AbstractFilter value) {
                        filteringState.handleFilterAdd(value);
                      },
                      initialValue: filteringState.getInitialCommonFilter(),
                      dropdownData:
                          filteringState.getCommonFiltersForDropdown()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
                child: MaterialButton(
                  padding: EdgeInsets.zero,
                  height: 50,
                  onPressed: () {
                    context
                        .read<TripLocationState>()
                        .handleFiltering(filteringState);
                  },
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    "Suodata",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 5, left: 10, bottom: 5),
          child: TagBar(),
        )
      ]),
    );
  }
}
