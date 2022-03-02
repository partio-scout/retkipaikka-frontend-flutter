import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:retkipaikka_flutter/models/triplocation_model.dart';

class ImageSlider extends HookWidget {
  ImageSlider({Key? key, required this.images}) : super(key: key);

  List<String> images;

  final CarouselController controller = CarouselController();

  List<Widget> getImageSliders(List<dynamic> images) {
    final List<Widget> imageSliders = images
        .map((item) => Container(
              margin: const EdgeInsets.all(5.0),
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  child: Image.network(item, fit: BoxFit.cover, width: 1000.0),
                    
                ),
            ))
        .toList();

    return imageSliders;
  }

  @override
  Widget build(BuildContext context) {
    var currentIndex = useState<int>(0);
    return Column(children: [
      Expanded(
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse}
          ),
          child: CarouselSlider(
            items: getImageSliders(images),
            carouselController: controller,
            options: CarouselOptions(
              enableInfiniteScroll: false,
                autoPlay: false,
                enlargeCenterPage: true,
                aspectRatio: 2.0,
                onPageChanged: (index, reason) {
                  currentIndex.value = index;
                }),
          ),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: images.asMap().entries.map((entry) {
          return MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {             
                controller.animateToPage(entry.key);
              },
              child: Container(
                width: 12.0,
                height: 12.0,
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black)
                        .withOpacity(
                            currentIndex.value == entry.key ? 0.9 : 0.4)),
              ),
            ),
          );
        }).toList(),
      ),
    ]);
  }
}
