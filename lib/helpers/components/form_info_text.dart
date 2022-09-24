import 'package:flutter/material.dart';
import 'package:retkipaikka_flutter/helpers/locales/translate.dart';

class FormInfoText extends StatelessWidget {
  const FormInfoText({Key? key, required this.text}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Text(
        text.t(context),
        style: TextStyle(
          color: Theme.of(context).textTheme.caption?.color?.withOpacity(0.5),
        ),
      ),
    );
  }
}
