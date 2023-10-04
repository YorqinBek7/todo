import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo/src/core/extentions/space.dart';
import 'package:todo/src/core/extentions/text_styles.dart';
import '../../core/colors/colors.dart';

class IconWithText extends StatelessWidget {
  const IconWithText({
    super.key,
    required this.icon,
    required this.text,
    required this.itemsColor,
  });
  final String icon;
  final String text;
  final Color itemsColor;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          icon,
          fit: BoxFit.none,
          color: itemsColor,
        ),
        4.pw,
        Text(
          text,
          style: context.displaySmall?.copyWith(
            color: itemsColor,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }
}
