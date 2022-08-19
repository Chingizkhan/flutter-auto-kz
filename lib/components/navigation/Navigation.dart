import 'package:flutter/material.dart';
import 'package:flutter_projects/components/navigation/NavigationConfig.dart';
import 'package:flutter_projects/screen/main/screen/MainScreen.dart';

import '../../screen/auth/screen/LoginScreen.dart';

Map<String, WidgetBuilder> navigationCreate() {
  return {
    NavigationConfig.login: (BuildContext context) => const LoginScreen(),
    NavigationConfig.main: (BuildContext context) => const MainScreen(),
  };
}
