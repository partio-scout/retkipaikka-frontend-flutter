import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:retkipaikka_flutter/models/triplocation_model.dart';

class ImageSlider extends HookWidget {
  ImageSlider({Key? key, required this.images}) : super(key: key);

  List<String> images;

  final CarouselController controller = CarouselController();

  List<Widget> getImageSliders(List<dynamic> images, BuildContext context) {
    final List<Widget> imageSliders = images
        .map(
          (item) => Container(
            //width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.all(5.0),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              child: Image.network(
                item,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          // InkWell(
          //   onTap: () {},
          //   child: Container(
          //     margin: const EdgeInsets.all(3),
          //     decoration: BoxDecoration(
          //       color: Colors.red.withOpacity(.7),
          //       shape: BoxShape.circle,
          //     ),
          //     alignment: Alignment.center,
          //     height: 22,
          //     width: 22,
          //     child: const Icon(
          //       Icons.close,
          //       size: 18,
          //       color: Colors.white,
          //     ),
          //   ),
          // ),
        )
        .toList();

    return imageSliders;
  }

  @override
  Widget build(BuildContext context) {
    var currentIndex = useState<int>(0);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse
            }),
            child: CarouselSlider(
              items: getImageSliders(images, context),
              carouselController: controller,
              options: CarouselOptions(
                  height: 600,
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
      ],
    );
  }
}
