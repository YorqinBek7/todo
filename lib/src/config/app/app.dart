import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/src/config/routes/routes.dart';
import 'package:todo/src/config/theme/theme.dart';
import 'package:todo/src/features/presentation/blocs/get_events/get_events_bloc.dart';
import 'package:todo/src/features/presentation/pages/locator.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          GetEventsBloc(locator())..add(const GetTodosEvent()),
      child: MaterialApp(
        theme: AppTheme.lighTheme(),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        onGenerateRoute: AppRoutes.onGenerateRoute,
      ),
    );
  }
}
