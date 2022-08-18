import 'package:flutter/material.dart';
import 'package:flutter_projects/extensions.dart';
import 'package:flutter_projects/screen/auth/model/LoginModel.dart';
import 'package:provider/provider.dart';
import '../content/LoginContent.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: ChangeNotifierProvider(
            create: (context) => LoginModel(),
            child: const LoginContent().padding(),
          ),
        ),
      ),
    );
  }
}
