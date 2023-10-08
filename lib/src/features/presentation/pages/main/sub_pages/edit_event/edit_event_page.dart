import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:todo/src/core/colors/colors.dart';
import 'package:todo/src/core/constants/constants.dart';
import 'package:todo/src/core/extentions/space.dart';
import 'package:todo/src/core/extentions/text_styles.dart';
import 'package:todo/src/core/helper/helper.dart';
import 'package:todo/src/core/icons/icons.dart';
import 'package:todo/src/features/data/models/todo/todo_model_key.dart';
import 'package:todo/src/features/data/repository/event_repository.dart';
import 'package:todo/src/features/presentation/blocs/get_events/get_events_bloc.dart';
import 'package:todo/src/features/presentation/blocs/get_location/get_location_bloc.dart';
import 'package:todo/src/features/presentation/pages/locator.dart';
import '../../../../cubits/event_data/event_data_cubit.dart';
import '../add_event/widgets/event_field_with_title.dart';

class EditEventPage extends StatelessWidget {
  final int id;
  const EditEventPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => EventDataCubit(),
        ),
        BlocProvider(
          create: (context) => GetLocationBloc(locator()),
        )
      ],
      child: EditEventView(
        eventRepository: locator(),
        id: id,
      ),
    );
  }
}

class EditEventView extends StatefulWidget {
  const EditEventView({
    super.key,
    required this.eventRepository,
    required this.id,
  });
  final EventRepository eventRepository;
  final int id;

  @override
  State<EditEventView> createState() => _EditEventViewState();
}

class _EditEventViewState extends State<EditEventView> {
  late TextEditingController _eventNameController;
  late TextEditingController _eventDescController;
  late TextEditingController _eventLocationController;
  late TextEditingController _eventTimeController;

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
    final cubit = BlocProvider.of<EventDataCubit>(context);
    final bloc = BlocProvider.of<GetLocationBloc>(context);
    return BlocListener<GetLocationBloc, GetLocationState>(
      listener: (context, state) {
        if (state is GetLocationLoading) {
          //Show Dialog
          Helper.showDismissableDialog(context);
        } else if (state is GetLocationSuccess) {
          //Successfully fetched location
          Navigator.pop(context);
          _eventLocationController.text = state.currentLocation.name;
          cubit.updateTodoData(
            TodoModelKey.eventLocation,
            state.currentLocation.name,
          );
        } else if (state is GetLocationFailure) {
          //Show Error Message
          Navigator.pop(context);
          Helper.showErrorSnackbar(
            context: context,
            errorMessage: state.errorMessage,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
        ),
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: BlocBuilder<EventDataCubit, EventDataState>(
                  builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        16.ph,
                        EventFieldWithTitle(
                          controller: _eventNameController,
                          title: 'Event name',
                          onChanged: (value) {
                            cubit.updateTodoData(TodoModelKey.eventName, value);
                          },
                        ),
                        16.ph,
                        EventFieldWithTitle(
                          controller: _eventDescController,
                          title: 'Event description',
                          maxLine: 3,
                          onChanged: (value) {
                            cubit.updateTodoData(TodoModelKey.eventDesc, value);
                          },
                        ),
                        16.ph,
                        EventFieldWithTitle(
                          readOnly: true,
                          onTap: () async {
                            var geo = await _determinePosition();
                            bloc.add(GetCurrentLocationEvent(
                              lat: geo.latitude,
                              lon: geo.longitude,
                            ));
                          },
                          controller: _eventLocationController,
                          title: 'Event location',
                          suffixIcon: AppIcons.location,
                        ),
                        16.ph,
                        DropdownButton(
                          value:
                              Helper.hexToColor(state.todoModel.priorityColor),
                          items: AppConstants.colors
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
                          onChanged: (value) {
                            cubit.updateTodoData(
                              TodoModelKey.priorityColor,
                              value.toString().substring(6, 16),
                            );
                          },
                        ),
                        16.ph,
                        EventFieldWithTitle(
                          readOnly: true,
                          onTap: () async {
                            await getEventTime().then((selectedTime) {
                              _eventTimeController.text =
                                  '${selectedTime.$1} - ${selectedTime.$2}';
                              cubit.updateTodoData(TodoModelKey.eventTime,
                                  '${selectedTime.$1} - ${selectedTime.$2}');
                            });
                          },
                          controller: _eventTimeController,
                          title: 'Event Time',
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () async {
                            var registerChecker =
                                cubit.canAdd(cubit.state.todoModel);
                            if (registerChecker.$1 == true) {
                              await widget.eventRepository
                                  .editTodo(
                                todo: cubit.state.todoModel,
                                id: widget.id,
                              )
                                  .whenComplete(() {
                                BlocProvider.of<GetEventsBloc>(context)
                                    .add(const GetTodosEvent());
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  AppConstants.mainPage,
                                  (route) => false,
                                );
                                Helper.showSuccessSnackbar(
                                  context: context,
                                  successMessage: 'Successfuly edited',
                                );
                              });
                            } else {
                              Helper.showErrorSnackbar(
                                context: context,
                                errorMessage: registerChecker.$2,
                              );
                            }
                          },
                          child: Container(
                            height: 54.0,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: AppColors.C_009FEE,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Center(
                              child: Text(
                                'Edit',
                                style: context.displayMedium?.copyWith(
                                  color: AppColors.C_FFFFFF,
                                ),
                              ),
                            ),
                          ),
                        ),
                        28.ph,
                      ],
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<(String, String)> getEventTime() async {
    TimeOfDay? startTime;
    TimeOfDay? endTime;
    Helper.showMessage('Please choose a start time');
    startTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).whenComplete(() async {
      Helper.showMessage('Please choose a end time');
      endTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
    });

    return (startTime!.format(context), endTime!.format(context));
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled && mounted) {
      Helper.showErrorSnackbar(
          context: context, errorMessage: 'Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied && mounted) {
        Helper.showErrorSnackbar(
            context: context, errorMessage: 'Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever && mounted) {
      Helper.showErrorSnackbar(
          context: context,
          errorMessage:
              'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
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
