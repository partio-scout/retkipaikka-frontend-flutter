import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:retkipaikka_flutter/models/abstract_filter_model.dart';


class CustomDropdownButton extends HookWidget {
  final AbstractFilter initialValue;
  final List<AbstractFilter> dropdownData;
  final Color? bgColor;
  final Function(AbstractFilter s)? onDropdownChange;
  final TextStyle? floatingLabelStyle;
  final String? title;
  final AbstractFilter? value;
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
      this.value,
      this.height = 40,
      required this.disabled,
      this.errorText,
      this.floatingLabelStyle = const TextStyle(fontSize: 20),
      this.onDropdownChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dropDownState = useState<AbstractFilter>(initialValue);
    var newDropdownDataState = useState<List<AbstractFilter>>(dropdownData);
    useEffect(() {
      newDropdownDataState.value = dropdownData;
      return null;
    }, [dropdownData]);

    useEffect(() {
      if (dropDownState.value != initialValue) {
        dropDownState.value = initialValue;
      }
      return null;
    }, [initialValue]);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
         // color: bgColor,
          height: height,
          child: DropdownButtonFormField<AbstractFilter>(
            value: dropDownState.value,
            isExpanded: true,
            itemHeight: null,
            //itemHeight: 40,

            decoration: InputDecoration(
                labelText: title,
                floatingLabelStyle: floatingLabelStyle,
                errorText: errorText,
                //errorMaxLines: 3,
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                border: const OutlineInputBorder()),
            icon: const Icon(
              Icons.keyboard_arrow_down_rounded,
             
            ),
            elevation: 16,

            //dropdownColor: bgColor,

            hint: Text(dropDownState.value.name),
            focusColor: Theme.of(context).scaffoldBackgroundColor, // const TextStyle(color: Colors.white),
            //underline: Container(height: 2, color: bgColor),
            onChanged: disabled
                ? null
                : (AbstractFilter? newValue) {
                    //print(newValue);
                   
                    if (newValue != null) {
                      dropDownState.value = newValue;
                      if (onDropdownChange != null) {
                        onDropdownChange!(newValue);
                      }
                    }
                  },
            items: newDropdownDataState.value
                .map<DropdownMenuItem<AbstractFilter>>((AbstractFilter value) {
              return DropdownMenuItem<AbstractFilter>(
                  value: value, child: Text(value.name));
            }).toList(),
          ),
        ),
      ],
    );
  }
}
