import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo/src/core/extentions/text_styles.dart';
import '../../../../../../../core/colors/colors.dart';

class EventFieldWithTitle extends StatelessWidget {
  const EventFieldWithTitle({
    super.key,
    required this.controller,
    required this.title,
    this.maxLine,
    this.suffixIcon,
  });
  final TextEditingController controller;
  final String title;
  final int? maxLine;
  final String? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.displaySmall,
        ),
        TextField(
          controller: controller,
          maxLines: maxLine ?? 1,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.C_F3F4F6,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none,
            ),
            suffixIcon: suffixIcon != null
                ? SvgPicture.asset(
                    suffixIcon!,
                    fit: BoxFit.none,
                    color: AppColors.C_009FEE,
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
