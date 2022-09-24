import 'package:flutter/material.dart';
import 'package:retkipaikka_flutter/controllers/app_state.dart';
import 'package:retkipaikka_flutter/controllers/filtering_state.dart';
import 'package:provider/provider.dart';
import 'package:retkipaikka_flutter/models/abstract_filter_model.dart';
import 'package:retkipaikka_flutter/screens/main/components/filtering/filter_tag.dart';

class TagBar extends StatelessWidget {
  const TagBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    FilteringState filteringState = context.watch<FilteringState>();

    // ignore: unused_local_variable
    Locale currentLocale = context.watch<AppState>().appLocale;
    return Align(
      alignment: Alignment.topLeft,
      child: Wrap(
        runSpacing: 5,
        alignment: WrapAlignment.start,
        children: [
          for (AbstractFilter filter in [
            ...filteringState.locationFiltering,
            ...filteringState.categoryFiltering,
            ...filteringState.commonFiltering
          ]) ...[
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: FilterTag(
                filter: filter,
                onTagPressed: (tag) {
                  context.read<FilteringState>().handleFilterRemove(tag);
                },
              ),
            ),
          ]
        ],
      ),
    );
  }
}
