import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo/src/core/colors/colors.dart';
import 'package:todo/src/core/constants/constants.dart';
import 'package:todo/src/core/extentions/space.dart';
import 'package:todo/src/core/extentions/text_styles.dart';
import 'package:todo/src/features/presentation/blocs/get_events/get_events_bloc.dart';
import 'package:todo/src/features/presentation/pages/main/widgets/custom_calendar.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../../core/helper/helper.dart';
import 'widgets/card_item.dart';
import 'widgets/custom_appbar.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late final ScrollController _scrollController;
  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: RefreshIndicator(
        onRefresh: () async {
          BlocProvider.of<GetEventsBloc>(context).add(const GetTodosEvent());
        },
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            CustomAppBar(
              onTap: () {},
              date: DateFormat('dd MMMM yyyy').format(DateTime.now()),
              day: DateFormat('EEEE').format(DateTime.now()),
            ),
            SliverToBoxAdapter(
              child: 10.ph,
            ),
            BlocBuilder<GetEventsBloc, GetEventsState>(
              builder: (context, state) {
                if (state is GetEventsLoading) {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (state is GetEventsFailure) {
                  return SliverToBoxAdapter(child: Text(state.errorMessage));
                } else if (state is GetEventsSuccess) {
                  return SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 28.0),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          CustomCalendar(
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            lastDate: DateTime(2950),
                            savedDates: getTodosDateTimes(state),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Schedule',
                                style: context.displayMedium,
                              ),
                              ZoomTapAnimation(
                                onTap: () {
                                  Helper.showMessage(
                                    '${DateFormat('dd MMMM yyyy').format(AppConstants.dateTime)} has been chosen',
                                  );
                                  Navigator.pushNamed(
                                    context,
                                    AppConstants.addEventPage,
                                    arguments: getTodosDateTimes(state),
                                  );
                                },
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
                        ],
                      ),
                    ),
                  );
                } else {
                  return const SliverToBoxAdapter(child: SizedBox());
                }
              },
            ),
            SliverToBoxAdapter(
              child: BlocBuilder<GetEventsBloc, GetEventsState>(
                builder: (context, state) {
                  if (state is GetEventsLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is GetEventsFailure) {
                    return Center(
                      child: Text(
                        state.errorMessage,
                        style: context.displayMedium,
                      ),
                    );
                  } else if (state is GetEventsSuccess) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 28.0),
                      child: Column(
                        children: [
                          if (state.todosModel.isEmpty)
                            Text(
                              'No data available',
                              style: context.displayMedium,
                            )
                          else
                            ...List.generate(state.todosModel.length, (index) {
                              return CardItem(
                                onTap: () => Navigator.pushNamed(
                                  context,
                                  AppConstants.detailEventPage,
                                  arguments: state.todosModel[index],
                                ),
                                todoModel: state.todosModel[index],
                              );
                            }),
                        ],
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  List<String> getTodosDateTimes(GetEventsSuccess state) {
    List<String> data = [];
    for (var e in state.todosModel) {
      for (var element in e.eventDate.split(',')) {
        data.add(element);
      }
    }
    return data;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
