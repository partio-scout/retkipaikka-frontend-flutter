import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:retkipaikka_flutter/contants.dart';
import 'package:retkipaikka_flutter/controllers/filtering_state.dart';
import 'package:retkipaikka_flutter/controllers/triplocation_state.dart';
import 'package:retkipaikka_flutter/helpers/api/filtering_api.dart';
import 'package:retkipaikka_flutter/helpers/components/custom_autocomplete.dart';
import 'package:retkipaikka_flutter/helpers/components/custom_dropdown_button.dart';
import "package:provider/provider.dart";
import 'package:retkipaikka_flutter/models/abstract_filter_model.dart';
import 'package:retkipaikka_flutter/models/filter_model.dart';
import 'package:retkipaikka_flutter/models/geo_area_model.dart';
import 'package:retkipaikka_flutter/screens/main/components/filtering/tag_bar.dart';

class FilteringComponent extends HookWidget {
  FilteringComponent({Key? key}) : super(key: key);
  final FilteringApi filteringApi = FilteringApi();
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
            print(error);
          }).whenComplete(() => loading.value = false);
        }else{
          loading.value = false;
        }
      });
    }, []);

    return Container(
      width: double.infinity,
      // height: 90,
      color: Color(0xFFe4dfdf),
      child: Column(
        children: [
          Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomAutocomplete(
                  data: [
                    ...filteringState.allMunicipalities,
                    ...filteringState.allRegions
                  ],
                  disabled:loading.value,
                  title: "Sijainti",
                  onValueSelect: (AbstractFilter value) {
                    filteringState.handleFilterAdd(value);
                  },
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomDropdownButton(
                      bgColor: Colors.white,
                      focusColor: Colors.white,
                      title: "Tyyppi",
                      disabled:loading.value,
                      onDropdownChange: (AbstractFilter value) {
                        filteringState.handleFilterAdd(value);
                      },
                      initialValue: Filter(
                          id: -1,
                          type: kfilterType.noCategory,
                          name: "Ei kategorioita"),
                      dropdownData: filteringState.allCategoryFilters),
              ),
              
              SizedBox(
                width: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomDropdownButton(
                      bgColor: Colors.white,
                      focusColor: Colors.white,
                      title: "Suodattimet",
                      disabled:loading.value,
                      onDropdownChange: (AbstractFilter value) {
                        filteringState.handleFilterAdd(value);
                      },
                      initialValue: Filter(
                          id: -1, type: kfilterType.noFilter, name: "Ei suodattimia"),
                      dropdownData: filteringState.allCommonFilters),
              ),
              

             Padding(
                  padding: const EdgeInsets.only(top: 20,left:10,bottom: 5),
                  child: MaterialButton(
                    padding: EdgeInsets.zero,
                    height: 50,
                    
                    onPressed: () {
                      context.read<TripLocationState>().handleFiltering(filteringState);
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
          Padding(
            padding: const EdgeInsets.only(top:5,left:10,bottom:5),
            child: TagBar(),
          )
        ],
      ),
    );
  }
}
