import 'package:flutter/material.dart';

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

          const Center(
            child: Padding(
              padding: EdgeInsets.only(left: 5),
              child: Text(
                "Partion Retkipaikat",
                style: TextStyle(color: Colors.white, fontSize: 50),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
