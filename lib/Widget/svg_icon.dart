import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgIcons extends StatelessWidget {
  const SvgIcons({
    Key? key,
    required this.height,
    required this.width,
    required this.imgPath,
  }) : super(key: key);

  final double height;
  final double width;
  final String imgPath;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: width,
        // margin: EdgeInsets.only(left: width * 0.09),
        child: SvgPicture.asset(
          imgPath,
          
        ));
  }
}
