import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:retkipaikka_flutter/helpers/locales/translate.dart';
import 'package:retkipaikka_flutter/models/abstract_filter_model.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CustomAutocomplete extends HookWidget {
  const CustomAutocomplete(
      {Key? key,
      this.title,
      required this.data,
      required this.onValueSelect,
      required this.disabled,
      this.floatingLabelStyle = const TextStyle(fontSize: 20),
      this.height = 40,
      this.clearAfterSelect = true,
      this.errorText,
      this.value})
      : super(key: key);
  final String? title;
  final List<AbstractFilter> data;
  final TextStyle floatingLabelStyle;
  final Function(AbstractFilter value) onValueSelect;
  final bool disabled;
  final double height;
  final bool clearAfterSelect;
  final String? errorText;
  final String? value;

  @override
  Widget build(BuildContext context) {
    var dropdownData = useState<List<AbstractFilter>>(data);
    var controller = useTextEditingController();
    useEffect(() {
      controller.text = value ?? "";
      return null;
    }, [value]);
    // Needs to use state here because wont update the dropdown data after initial load otherwise
    useEffect(() {
      dropdownData.value = data;
      return null;
    }, [data]);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
            //color: Theme.of(context).scaffoldBackgroundColor,
            height: errorText == null ? height : height * 1.45,
            child: TypeAheadField<AbstractFilter>(
              //initialValue: initialValue,

              noItemsFoundBuilder: ((context) =>
                   ListTile(title: Text("Ei tuloksia".t(context)))),
              textFieldConfiguration: TextFieldConfiguration(
                  enabled: !disabled,
                  controller: controller,
                  autofocus: false,
                  style: const TextStyle(fontSize: 17),
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: title,
                    errorText: errorText,
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 10),
                    floatingLabelStyle: floatingLabelStyle,
                    labelStyle: floatingLabelStyle,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  )),
              suggestionsCallback: (pattern) async {
                return dropdownData.value.where((element) =>
                    element.name.toLowerCase().contains(pattern.toLowerCase()));
              },

              minCharsForSuggestions: 3,
              hideOnLoading: true,
              //loadingBuilder: (context)=>null,
              itemBuilder: (context, suggestion) {
                return ListTile(
                  //leading: Icon(Icons.shopping_cart),
                  title: Text(suggestion.getTranslatedName(context)),
                  //subtitle: Text('\$${suggestion['price']}'),
                );
              },
              onSuggestionSelected: (suggestion) {
                if (clearAfterSelect) {
                  controller.text = "";
                } else {
                  controller.text = suggestion.getTranslatedName(context);
                }

                onValueSelect(suggestion);
              },
            )),
      ],
    );
  }
}
