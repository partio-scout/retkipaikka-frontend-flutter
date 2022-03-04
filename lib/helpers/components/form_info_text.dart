

import 'package:flutter/material.dart';

class FormInfoText extends StatelessWidget {
  const FormInfoText({ Key? key, required this.text }) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.black.withOpacity(0.5),
        ),
      ),
    );
  
  }
}