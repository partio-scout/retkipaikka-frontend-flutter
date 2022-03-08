import 'package:flutter/material.dart';
import 'package:retkipaikka_flutter/models/abstract_filter_model.dart';
import 'package:retkipaikka_flutter/screens/main/components/filtering/filter_tag.dart';

class AdminTagBar extends StatelessWidget {
  const AdminTagBar(
      {Key? key, this.tags = const [], required this.onTagPressed})
      : super(key: key);
  final List<AbstractFilter> tags;
  final Function(AbstractFilter) onTagPressed;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Wrap(
        runSpacing: 5,
        alignment: WrapAlignment.start,
        children: [
          for (AbstractFilter filter in tags) ...[
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: FilterTag(filter: filter, onTagPressed: onTagPressed),
            ),
          ]
        ],
      ),
    );
  }
}
