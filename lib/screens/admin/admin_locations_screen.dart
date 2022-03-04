

import 'package:flutter/material.dart';
import 'package:retkipaikka_flutter/helpers/responsive.dart';

class AdminLocationsScreen extends StatelessWidget {
  const AdminLocationsScreen({ Key? key, required this.displayOnlyNew }) : super(key: key);
  final bool displayOnlyNew;
  @override
  Widget build(BuildContext context) {
      EdgeInsets padding = Responsive.isDesktop(context)
        ? const EdgeInsets.only(left: 100,right: 100,top:50)
        : const EdgeInsets.only(left: 10,right: 10,top:20);
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(displayOnlyNew?"Uudet retkipaikat":"Retkipaikat",style: const TextStyle(fontSize: 20),)
        ],
        
      ),
    );
  }
}