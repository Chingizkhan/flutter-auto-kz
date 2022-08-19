import 'package:flutter/material.dart';
import 'package:flutter_projects/components/navigation/NavigationConfig.dart';
import 'package:flutter_projects/utils/setInitialRoute.dart';
import 'components/navigation/Navigation.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // final initialRoute = InitialRoute();
  // initialRoute.init();

  runApp(const MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auto.kz',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: NavigationConfig.login,
      routes: navigationCreate(),
    );
  }
}
