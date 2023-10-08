import 'package:flutter/material.dart';
import 'package:todo/src/core/extentions/space.dart';
import 'package:todo/src/core/extentions/text_styles.dart';
import 'package:todo/src/core/helper/helper.dart';
import 'package:todo/src/features/data/models/todo/todo_model.dart';
import 'package:todo/src/features/widgets/icon_with_text.dart';
import '../../../../../core/icons/icons.dart';

class CardItem extends StatelessWidget {
  const CardItem({
    super.key,
    required this.onTap,
    required this.todoModel,
  });

  final VoidCallback onTap;
  final TodoModel todoModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 7.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Helper.hexToColor(todoModel.priorityColor).withOpacity(.2),
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
                color: Helper.hexToColor(todoModel.priorityColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    todoModel.eventName,
                    style: context.displayMedium?.copyWith(
                      color: Helper.hexToColor(todoModel.priorityColor),
                    ),
                  ),
                  Text(
                    todoModel.eventDesc,
                    style: context.displaySmall?.copyWith(
                      fontSize: 8.0,
                      color: Helper.hexToColor(todoModel.priorityColor),
                    ),
                  ),
                  10.ph,
                  Row(
                    children: [
                      IconWithText(
                        icon: AppIcons.hour,
                        text: todoModel.eventTime,
                        itemsColor: Helper.hexToColor(todoModel.priorityColor),
                      ),
                      IconWithText(
                        icon: AppIcons.location,
                        text: todoModel.eventLocation,
                        itemsColor: Helper.hexToColor(todoModel.priorityColor),
                      )
                    ],
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
