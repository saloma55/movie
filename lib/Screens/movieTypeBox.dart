import 'package:flutter/material.dart';

class Movietypebox extends StatelessWidget {
  String type;
  Movietypebox({super.key,required this.type,});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 20.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: Color(0xffcbcbcb),
        ),
      ),
      child: Text(
        type,
        style: TextStyle(
          color: Color(0xffcbcbcb),
          fontSize: 15,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
