import 'package:flutter/material.dart';
import 'package:retkipaikka_flutter/helpers/locales/translate.dart';

class TitleImage extends StatelessWidget {
  const TitleImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: Stack(
        children: [
          // Container(
          //   decoration: BoxDecoration(
          //       image: DecorationImage(
          //           fit: BoxFit.fitWidth,
          //           alignment: Alignment.topCenter,
          //           image: AssetImage("/assets/images/frontpage_img.jpg"))),
          // )
          Image.asset(
            "assets/images/frontpage_img.jpg",
            fit: BoxFit.cover,
            width: double.infinity,
          ),

           Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                "Partion Retkipaikat".t(context),
                style: const TextStyle(color: Colors.white, fontSize: 50),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
