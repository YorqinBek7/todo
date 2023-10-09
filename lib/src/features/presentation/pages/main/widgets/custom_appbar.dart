import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo/src/core/constants/constants.dart';
import 'package:todo/src/core/extentions/space.dart';
import 'package:todo/src/core/extentions/text_styles.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../../../core/icons/icons.dart';

class CustomAppBar extends StatelessWidget {
  final VoidCallback onTap;
  final String date;
  final String day;
  const CustomAppBar({
    super.key,
    required this.onTap,
    required this.date,
    required this.day,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      actions: [
        const Spacer(
          flex: 2,
        ),
        Column(
          children: [
            Text(
              day,
              style: context.displayMedium,
            ),
            ZoomTapAnimation(
              onTap: onTap,
              child: Row(
                children: [
                  Text(
                    date,
                    style: context.displaySmall?.copyWith(fontSize: 10.0),
                  ),
                  4.pw,
                  SvgPicture.asset(
                    AppIcons.arrowBottom,
                  )
                ],
              ),
            ),
          ],
        ),
        const Spacer(),
        ZoomTapAnimation(
          onTap: () {
            print(AppConstants.dateTime);
          },
          child: SvgPicture.asset(
            AppIcons.notification,
          ),
        ),
        28.pw,
      ],
    );
  }
}
