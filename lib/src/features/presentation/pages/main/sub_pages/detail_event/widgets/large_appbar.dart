import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo/src/core/extentions/space.dart';
import 'package:todo/src/core/extentions/text_styles.dart';

import '../../../../../../../core/colors/colors.dart';
import '../../../../../../../core/icons/icons.dart';
import '../../../../../../widgets/icon_with_text.dart';

class LargeAppBar extends StatelessWidget {
  const LargeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      elevation: 0.0,
      toolbarHeight: 200,
      automaticallyImplyLeading: false,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            color: AppColors.C_009FEE,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            ),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              60.ph,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(60.0),
                    child: Material(
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () => Navigator.pop(context),
                        icon: SvgPicture.asset(
                          AppIcons.arrowLeft,
                          fit: BoxFit.cover,
                          height: 15.0,
                          width: 15.0,
                        ),
                      ),
                    ),
                  ),
                  const IconWithText(
                    icon: AppIcons.edit,
                    text: 'Edit',
                    itemsColor: AppColors.C_FFFFFF,
                  )
                ],
              ),
              10.ph,
              Text(
                'Watching Football',
                style: context.displayMedium?.copyWith(
                  color: AppColors.C_FFFFFF,
                  fontSize: 26.0,
                ),
              ),
              Text(
                'Manchester United vs Arsenal (Premiere League)',
                style: context.displaySmall?.copyWith(
                  color: AppColors.C_FFFFFF,
                ),
              ),
              12.ph,
              const IconWithText(
                icon: AppIcons.hour,
                text: '17:00 - 18:30',
                itemsColor: AppColors.C_FFFFFF,
              ),
              12.ph,
              const IconWithText(
                icon: AppIcons.location,
                text: 'Stamford Bridge',
                itemsColor: AppColors.C_FFFFFF,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
