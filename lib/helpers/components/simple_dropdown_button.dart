import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';


class SimpleDropdownButton extends HookWidget {
  final String initialValue;
  final List<String> dropdownData;
  final Color? bgColor;
  final Function(String s)? onDropdownChange;
  final Color? focusColor;
  const SimpleDropdownButton(
      {Key? key,
      this.bgColor,
      required this.initialValue,
      required this.dropdownData,
      this.focusColor,
      this.onDropdownChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dropDownState = useState<String>(initialValue);
    return DropdownButton<String>(
      value: dropDownState.value,
      icon: const Icon(
        Icons.keyboard_arrow_down,
        color: Colors.white,
      ),
      elevation: 16,
    
      dropdownColor: bgColor,
      
      focusColor: focusColor,
      hint: Text(dropDownState.value, style:TextStyle(color: Colors.white)),
      underline: Container(height: 2, color: bgColor),
      onChanged: (String? newValue) {
        dropDownState.value = newValue!;
        if (onDropdownChange != null) {
          onDropdownChange!(newValue);
        }
      },
      items: dropdownData.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            
            value,      
            style:TextStyle(color: Colors.white)   
          ),
        );
      }).toList(),
    );
  }
}
