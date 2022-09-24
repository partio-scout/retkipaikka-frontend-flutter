import 'package:flutter/material.dart';
import 'package:retkipaikka_flutter/constants.dart';
import 'package:retkipaikka_flutter/models/abstract_filter_model.dart';

class FilterTag extends StatelessWidget {
  const FilterTag({Key? key, required this.filter, required this.onTagPressed})
      : super(key: key);
  final AbstractFilter filter;
  final Function(AbstractFilter) onTagPressed;
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Container(
        height: 30,
        color: getTagColor(filter.type),
        child: Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Row(
            children: [
              Text(filter.getTranslatedName(context), style: const TextStyle(color: Colors.white)),
              const SizedBox(
                width: 10,
              ),
              IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.close),
                  color: Colors.white,
                  onPressed: () {
                    onTagPressed(filter);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
