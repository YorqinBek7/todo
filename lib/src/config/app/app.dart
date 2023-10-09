import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/src/config/routes/routes.dart';
import 'package:todo/src/config/theme/theme.dart';
import 'package:todo/src/features/presentation/blocs/get_events/get_events_bloc.dart';
import 'package:todo/src/features/presentation/pages/locator.dart';
import '../../core/constants/constants.dart';
import '../../features/presentation/blocs/events_for_calendar/event_for_calendar_bloc.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => GetEventsBloc(locator())
            ..add(GetTodosEvent(AppConstants.dateTime.toString())),
        ),
        BlocProvider(
            create: (context) => EventsForCalendarBloc(locator())
              ..add(EventsForCalendarEvent())),
      ],
      child: MaterialApp(
        theme: AppTheme.lighTheme(),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        onGenerateRoute: AppRoutes.onGenerateRoute,
      ),
    );
  }
}
