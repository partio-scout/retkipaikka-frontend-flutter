import 'package:flutter/material.dart';
import 'package:retkipaikka_flutter/helpers/responsive.dart';

class DynamicLayoutWrapper extends StatelessWidget {
  const DynamicLayoutWrapper({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    bool isDesktop = Responsive.isDesktop(context);

    return isDesktop ? Expanded(child: child) : SizedBox(child: child);
  }
}
