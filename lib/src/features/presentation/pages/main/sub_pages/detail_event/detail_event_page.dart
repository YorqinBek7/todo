import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo/src/core/colors/colors.dart';
import 'package:todo/src/core/extentions/space.dart';
import 'package:todo/src/core/extentions/text_styles.dart';
import 'package:todo/src/core/icons/icons.dart';
import 'widgets/large_appbar.dart';

class DetailEventPage extends StatelessWidget {
  const DetailEventPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const LargeAppBar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  28.ph,
                  Text(
                    'Reminder',
                    style: context.displayMedium,
                  ),
                  10.ph,
                  Text(
                    '15 minutes before',
                    style: context.displayMedium?.copyWith(
                      color: AppColors.C_7C7B7B,
                    ),
                  ),
                  22.ph,
                  Text(
                    'Description',
                    style: context.displayMedium,
                  ),
                  10.ph,
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus vel ex sit amet neque dignissim mattis non eu est. Etiam pulvinar est mi, et porta magna accumsan nec. Ut vitae urna nisl. Integer gravida sollicitudin massa, ut congue orci posuere sit amet.',
                    style: context.displaySmall?.copyWith(
                      color: AppColors.C_7C7B7B,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                  10.ph,
                ],
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                const Spacer(),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 54.0,
                    margin: const EdgeInsets.symmetric(horizontal: 28.0),
                    decoration: BoxDecoration(
                      color: AppColors.C_FEE8E9,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          AppIcons.trash,
                        ),
                        2.pw,
                        Text(
                          'Delete Event',
                          style: context.displayMedium,
                        ),
                      ],
                    ),
                  ),
                ),
                28.ph,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
