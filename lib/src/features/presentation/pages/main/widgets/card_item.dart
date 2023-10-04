import 'package:flutter/material.dart';
import 'package:todo/src/core/extentions/space.dart';
import 'package:todo/src/core/extentions/text_styles.dart';
import 'package:todo/src/features/widgets/icon_with_text.dart';
import '../../../../../core/icons/icons.dart';

class CardItem extends StatelessWidget {
  const CardItem({
    super.key,
    required this.itemsColor,
    required this.backgroundColor,
    required this.onTap,
  });

  final Color itemsColor;
  final Color backgroundColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 7.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: backgroundColor.withOpacity(.2),
        ),
        height: 95.0,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 10.0,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
                color: backgroundColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Watching Football',
                    style: context.displayMedium?.copyWith(
                      color: itemsColor,
                    ),
                  ),
                  Text(
                    'Profile Page, Cart, and Wishlist.',
                    style: context.displaySmall?.copyWith(
                      fontSize: 8.0,
                      color: itemsColor,
                    ),
                  ),
                  10.ph,
                  IconWithText(
                    icon: AppIcons.hour,
                    text: '21:00 - 22:30',
                    itemsColor: itemsColor,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
