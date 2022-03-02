import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:retkipaikka_flutter/models/abstract_filter_model.dart';
import 'package:retkipaikka_flutter/models/filter_model.dart';

class CustomDropdownButton extends HookWidget {
  final AbstractFilter initialValue;
  final List<AbstractFilter> dropdownData;
  final Color? bgColor;
  final Function(AbstractFilter s)? onDropdownChange;
  final TextStyle? floatingLabelStyle;
  final String? title;
  final Color? focusColor;
  final double height;
  final bool disabled;
  final String? errorText;
  const CustomDropdownButton(
      {Key? key,
      this.bgColor,
      this.title,
      required this.initialValue,
      required this.dropdownData,
      this.focusColor,
      this.height = 40,
      required this.disabled,
      this.errorText,
      this.floatingLabelStyle=const TextStyle(fontSize: 20),
      this.onDropdownChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dropDownState = useState<AbstractFilter>(initialValue);
    var newDropdownData = useState<List<AbstractFilter>>(dropdownData);
    useEffect(() {
      newDropdownData.value = [initialValue, ...dropdownData];
    }, [dropdownData]);
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Container(
            color: bgColor,
            height: height,
            child: DropdownButtonFormField<AbstractFilter>(
              
              value: newDropdownData.value[0],
              isExpanded: true,
              itemHeight: null,
              //itemHeight: 40,
             

              decoration: InputDecoration(
                  labelText: title,
                  floatingLabelStyle: floatingLabelStyle,
                  errorText: errorText,
                  //errorMaxLines: 3,
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  border: OutlineInputBorder()
                  ),
              icon: const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Colors.black,
              ),
              elevation: 16,
              
              dropdownColor: bgColor,

              hint: Text(dropDownState.value.name),
              focusColor: focusColor, // const TextStyle(color: Colors.white),
              //underline: Container(height: 2, color: bgColor),
              onChanged: disabled?null: (AbstractFilter? newValue) {
                print(newValue);
                print(" ONCHANGE");
                if (newValue != null) {
                  dropDownState.value = newValue;
                  if (onDropdownChange != null) {
                    onDropdownChange!(newValue);
                  }
                }
              },
              items: newDropdownData.value
                  .map<DropdownMenuItem<AbstractFilter>>(
                      (AbstractFilter value) {
                return DropdownMenuItem<AbstractFilter>(
                    value: value, child: Text(value.name));
              }).toList(),
            ),
          ),
        ],
      
    );
  }
}
