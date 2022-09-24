import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class CustomCheckbox extends FormBuilderFieldOption {
  final String text;
  const CustomCheckbox({Key? key, required value, required this.text, child})
      : super(key: key, value: value, child: child);

  @override
  Widget build(BuildContext context) {
    return child ?? Text(text.toString());
  }
}