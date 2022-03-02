


import 'package:flutter/material.dart';
import 'package:retkipaikka_flutter/contants.dart';
import 'package:retkipaikka_flutter/controllers/filtering_state.dart';
import 'package:retkipaikka_flutter/models/abstract_filter_model.dart';
import 'package:provider/provider.dart';
class FilterTag extends StatelessWidget {
  const FilterTag({ Key? key,required this.filter }) : super(key: key);
  final AbstractFilter filter;
  @override
  Widget build(BuildContext context) {

    return FittedBox(
      child: Container(
        height: 30,
        
        color: getTagColor(filter.type),
        child: Padding(
          padding: const EdgeInsets.only(left:5),
          child: Row(children: [
            Text(filter.name,style:TextStyle(color: Colors.white)),
            SizedBox(width: 10,),
            IconButton(padding: EdgeInsets.zero, icon:const Icon(Icons.close),color: Colors.white,onPressed:(){
              context.read<FilteringState>().handleFilterRemove(filter);
            } )
    
          ],),
        ),
        
      ),
    );
  }
}