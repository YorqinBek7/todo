import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/src/features/presentation/cubits/select_needed_day/select_needed_day_cubit.dart';
import 'package:todo/src/features/presentation/pages/locator.dart';

import 'src/config/app/app.dart';

void main() {
  setupLocator();
  runApp(BlocProvider(
    create: (context) => SelectNeededDayCubit(),
    child: const MainApp(),
  ));
}
