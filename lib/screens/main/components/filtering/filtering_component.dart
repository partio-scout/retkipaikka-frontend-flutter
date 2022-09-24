import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:retkipaikka_flutter/controllers/app_state.dart';
import 'package:retkipaikka_flutter/controllers/filtering_state.dart';
import 'package:retkipaikka_flutter/controllers/triplocation_state.dart';
import 'package:retkipaikka_flutter/helpers/alert_helper.dart';
import 'package:retkipaikka_flutter/helpers/api/filtering_api.dart';
import 'package:retkipaikka_flutter/helpers/api_service.dart';
import 'package:retkipaikka_flutter/helpers/components/custom_autocomplete.dart';
import 'package:retkipaikka_flutter/helpers/components/custom_dropdown_button.dart';
import "package:provider/provider.dart";
import 'package:retkipaikka_flutter/helpers/components/dynamic_layout_wrapper.dart';
import 'package:retkipaikka_flutter/helpers/hooks/use_fetch_filters.dart';
import 'package:retkipaikka_flutter/helpers/locales/translate.dart';
import 'package:retkipaikka_flutter/helpers/responsive.dart';
import 'package:retkipaikka_flutter/models/abstract_filter_model.dart';
import 'package:retkipaikka_flutter/screens/main/components/filtering/tag_bar.dart';

class FilteringComponent extends HookWidget {
  FilteringComponent({Key? key, this.backgroundColor = const Color(0xFFe4dfdf)})
      : super(key: key);
  final FilteringApi filteringApi = ApiService().filteringApi;
  final Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    FilteringState filteringState = context.watch<FilteringState>();
    var loading = useState<bool>(true);
    useFetchFilters(context,isLoading: loading);
    
    return SizedBox(
      width: double.infinity,
      // height: 90,
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
                    height: 48,
                    data: [
                      ...filteringState.allMunicipalities,
                      ...filteringState.allRegions
                    ],
                    disabled: loading.value,
                    title: "Sijainti".t(context),
                    onValueSelect: (AbstractFilter value) {
                      filteringState.handleFilterAdd(value);
                    },
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              DynamicLayoutWrapper(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomDropdownButton(
                      height: 50,
                      bgColor: Colors.white,
                      focusColor: Colors.white,
                      title: "Tyyppi".t(context),
                      disabled: loading.value,
                      onDropdownChange: (AbstractFilter value) {
                        filteringState.handleFilterAdd(value);
                      },
                      initialValue: filteringState.getInitialCategoryFilter(context),
                      dropdownData:
                          filteringState.getCategoryFiltersForDropdown(context)),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              DynamicLayoutWrapper(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomDropdownButton(
                      height: 50,
                      bgColor: Colors.white,
                      focusColor: Colors.white,
                      title: "Suodattimet".t(context),
                      disabled: loading.value,
                      onDropdownChange: (AbstractFilter value) {
                        filteringState.handleFilterAdd(value);
                      },
                      initialValue: filteringState.getInitialCommonFilter(context),
                      dropdownData:
                          filteringState.getCommonFiltersForDropdown(context)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
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
                    "Suodata".t(context),
                    style: const TextStyle(color: Colors.white),
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
