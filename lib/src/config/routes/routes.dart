import 'package:flutter/cupertino.dart';
import 'package:todo/src/core/constants/constants.dart';
import 'package:todo/src/features/presentation/pages/main/sub_pages/add_event/add_event_page.dart';
import 'package:todo/src/features/presentation/pages/main/sub_pages/detail_event/detail_event_page.dart';
import 'package:todo/src/features/presentation/pages/main/main_page.dart';

import '../../features/presentation/pages/error/error_page.dart';

class AppRoutes {
  static CupertinoPageRoute onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppConstants.mainPage:
        return _toPage(const MainPage());
      case AppConstants.addEventPage:
        return _toPage(const AddEventPage());
      case AppConstants.detailEventPage:
        return _toPage(const DetailEventPage());
      default:
        return _toPage(
          const ErrorPage(
            errorMessage: 'Something went wrong',
          ),
        );
    }
  }

  static CupertinoPageRoute _toPage(Widget page) {
    return CupertinoPageRoute(
      builder: (context) => page,
    );
  }
}
