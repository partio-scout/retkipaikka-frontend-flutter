import 'package:flutter/material.dart';

class AppSpinner extends StatelessWidget {
  const AppSpinner({Key? key, this.width = 75, this.height = 75, this.color})
      : super(key: key);

  final double width;
  final double height;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        child: CircularProgressIndicator(color: color),
        width: width,
        height: height,
      ),
    );
  }
}
