import 'package:flutter/material.dart';
import 'package:todo/src/core/colors/colors.dart';
import 'package:todo/src/core/extentions/space.dart';
import 'package:todo/src/core/extentions/text_styles.dart';
import 'package:todo/src/core/icons/icons.dart';
import 'widgets/event_field_with_title.dart';

class AddEventPage extends StatefulWidget {
  const AddEventPage({super.key});

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  late TextEditingController _eventNameController;
  late TextEditingController _eventDescController;
  late TextEditingController _eventLocationController;
  late TextEditingController _eventTimeController;

  List<Color> colors = [
    AppColors.C_008000,
    AppColors.C_EE2B00,
    AppColors.C_EE8F00,
  ];
  Color selectedColor = AppColors.C_008000;

  @override
  void initState() {
    _eventDescController = TextEditingController();
    _eventLocationController = TextEditingController();
    _eventNameController = TextEditingController();
    _eventTimeController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EventFieldWithTitle(
                    controller: _eventNameController,
                    title: 'Event name',
                  ),
                  16.ph,
                  EventFieldWithTitle(
                    controller: _eventDescController,
                    title: 'Event description',
                    maxLine: 3,
                  ),
                  16.ph,
                  EventFieldWithTitle(
                    controller: _eventLocationController,
                    title: 'Event location',
                    suffixIcon: AppIcons.location,
                  ),
                  16.ph,
                  DropdownButton(
                    value: selectedColor,
                    items: colors
                        .map(
                          (color) => DropdownMenuItem(
                            value: color,
                            child: ColoredBox(
                              color: color,
                              child: const SizedBox(
                                height: 20.0,
                                width: 20.0,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {},
                  ),
                  16.ph,
                  EventFieldWithTitle(
                    controller: _eventTimeController,
                    title: 'Event Time',
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 54.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.C_009FEE,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                        child: Text(
                          'Add',
                          style: context.displayMedium?.copyWith(
                            color: AppColors.C_FFFFFF,
                          ),
                        ),
                      ),
                    ),
                  ),
                  28.ph,
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _eventDescController.dispose();
    _eventTimeController.dispose();
    _eventLocationController.dispose();
    _eventNameController.dispose();
    super.dispose();
  }
}
