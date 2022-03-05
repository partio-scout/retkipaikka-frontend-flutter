import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AppSpinner extends StatelessWidget {
  const AppSpinner({
    Key? key,
    this.width = 75,
    this.height = 75,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        child: SpinKitDualRing(
          color: Theme.of(context).primaryColor,
          duration: Duration(milliseconds: 1000),
        ),
        width: width,
        height: height,
      ),
    );
  }
}
