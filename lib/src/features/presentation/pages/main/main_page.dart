import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/src/core/colors/colors.dart';
import 'package:todo/src/core/constants/constants.dart';
import 'package:todo/src/core/extentions/space.dart';
import 'package:todo/src/core/extentions/text_styles.dart';
import 'package:todo/src/features/presentation/pages/main/widgets/custom_calendar.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import 'widgets/card_item.dart';
import 'widgets/custom_appbar.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CustomAppBar(
            onTap: () {},
            date: DateFormat('dd MMMM yyyy').format(DateTime.now()),
            day: DateFormat('EEEE').format(DateTime.now()),
          ),
          SliverToBoxAdapter(
            child: 10.ph,
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  CustomCalendar(
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1950),
                    lastDate: DateTime(2950),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Schedule',
                        style: context.displayMedium,
                      ),
                      ZoomTapAnimation(
                        onTap: () => Navigator.pushNamed(
                            context, AppConstants.addEventPage),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: AppColors.C_009FEE,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 8.0,
                          ),
                          child: Text(
                            '+ Add task',
                            style: context.displayMedium?.copyWith(
                              fontSize: 12.0,
                              color: AppColors.C_FFFFFF,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  18.ph,
                  ...List.generate(
                    10,
                    (index) => CardItem(
                      onTap: () => Navigator.pushNamed(
                          context, AppConstants.detailEventPage),
                      itemsColor: AppColors.C_056EA1,
                      backgroundColor: AppColors.C_009FEE,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
