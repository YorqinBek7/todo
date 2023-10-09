import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo/src/core/colors/colors.dart';
import 'package:todo/src/core/extentions/space.dart';
import 'package:todo/src/core/extentions/text_styles.dart';
import 'package:todo/src/core/icons/icons.dart';
import 'package:todo/src/features/data/models/todo/todo_model.dart';
import 'package:todo/src/features/data/repository/event_repository.dart';
import 'package:todo/src/features/presentation/blocs/get_events/get_events_bloc.dart';
import 'widgets/large_appbar.dart';

class DetailEventPage extends StatelessWidget {
  const DetailEventPage({
    super.key,
    required this.todoModel,
    required this.eventRepository,
  });
  final TodoModel todoModel;
  final EventRepository eventRepository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          LargeAppBar(
            todoModel: todoModel,
            eventRepository: eventRepository,
          ),
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
                    todoModel.eventDesc,
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
                  onTap: () {
                    BlocProvider.of<GetEventsBloc>(context)
                        .add(RemoveTodoByIdEvent(todoModel.id));
                    Navigator.pop(context);
                  },
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
