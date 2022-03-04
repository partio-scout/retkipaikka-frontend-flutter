import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:collection/collection.dart';

class CustomImagePicker extends HookWidget {
  CustomImagePicker(
      {Key? key,
      this.value,
      this.initialData = const [],
      this.onDataChanged,
      this.maxImages = 5})
      : super(key: key);
  final ImagePicker _picker = ImagePicker();
  final List<String> initialData;
  final Function(List<XFile> currentData, List<String> initialData)?
      onDataChanged;
  final int maxImages;
  final List<XFile>? value;

  void onChanged(List<XFile> data) {
    if (onDataChanged != null) {
      onDataChanged!(data, initialData);
    }
  }

  @override
  Widget build(BuildContext context) {
    var imageState =
        useState<List<XFile>>(initialData.map((e) => XFile(e)).toList());

    useEffect((){
      if(value != null && value!.length != imageState.value.length){
        imageState.value = value!;
      }
      return null;
    },[value]);  
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      FittedBox(
        child: MaterialButton(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            height: 50,
            onPressed: imageState.value.length >= maxImages
                ? null
                : () async {
                    List<XFile>? pickedFileList = await _picker.pickMultiImage();
                    if (pickedFileList != null) {
                      // Filter out files with same name
                      if (imageState.value.isNotEmpty) {
                        pickedFileList = pickedFileList
                            .where((pickedFile) =>
                                imageState.value.indexWhere((stateFile) =>
                                    pickedFile.name != stateFile.name) !=
                                -1)
                            .toList();
                      }
                      pickedFileList = [...imageState.value, ...pickedFileList];
                      if (pickedFileList.length > 5) {
                        pickedFileList = pickedFileList.sublist(0, 5);
                      }
                      imageState.value = pickedFileList;
                      onChanged(pickedFileList);
                    }
                  },
            color: Theme.of(context).primaryColor,
            child: Row(children: const [
               Icon(Icons.upload,color: Colors.white,),
               SizedBox(width: 5),
               Text(
                "Lataa kuvia",
                style: TextStyle(color: Colors.white),
              ),
               SizedBox(width:5)
            ])),
      ),
      const SizedBox(height: 10),
      Wrap(
          children: imageState.value.mapIndexed((index, item) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 130,
            height: 130,
            child: Stack(alignment: Alignment.topRight, children: [
              kIsWeb
                    ? Image.network(item.path, fit: BoxFit.cover)
                    : Image.file(File(item.path),fit:BoxFit.cover),
               
                 
              InkWell(
                onTap: () {
                  List<XFile> list = List.from(imageState.value);
                  list.removeAt(index);
                  imageState.value = list;
                  onChanged(list);
                },
                child: Container(
                  margin: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(.7),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  height: 22,
                  width: 22,
                  child: const Icon(
                    Icons.close,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
              )
            ]),
          ),
        );
      }).toList())
    ]);
  }
}
