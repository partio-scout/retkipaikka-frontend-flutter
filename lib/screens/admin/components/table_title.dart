import 'package:flutter/material.dart';
import 'package:retkipaikka_flutter/helpers/components/app_spinner.dart';

class TableTitle extends StatelessWidget {
  const TableTitle({Key? key, required this.isLoading, required this.text})
      : super(key: key);

  final bool isLoading;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Text(
        text, //"Uudet retkipaikat" : "Retkipaikat",
        style: const TextStyle(fontSize: 20),
      ),
      const SizedBox(
        width: 20,
      ),
      isLoading
          ? const AppSpinner(
              width: 25,
              height: 25,
            )
          : const SizedBox(),
    ]);
  }
}
