import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {
  SmallText(
      {Key? key,
      this.color = const Color(0xFF3a3b3c),
      required this.text,
      this.size = 9,
      this.height,
      this.textAlign,
      this.fontStyle,
      this.fontWeight = FontWeight.w900,
      this.spacing})
      : super(key: key);
  Color? color;
  final String text;
  final FontStyle? fontStyle;
  final FontWeight? fontWeight;
  double size;
  final double? height;
  final TextAlign? textAlign;
  final double? spacing;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      softWrap: false,
      textAlign: textAlign,
      style: TextStyle(
        letterSpacing: spacing,
        color: color,
        overflow: TextOverflow.ellipsis,
        fontSize: size,
        fontStyle: fontStyle,
        fontWeight: fontWeight,
      ),
    );
  }
}
