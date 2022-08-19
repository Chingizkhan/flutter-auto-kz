import 'package:flutter/material.dart';
import 'package:flutter_projects/screen/auth/model/LoginModel.dart';
import 'package:provider/provider.dart';

class LoginContent extends StatelessWidget {
  const LoginContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<LoginModel>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _loginInputCreate(state),
        const SizedBox(height: 20),
        _passwordInputCreate(state),
        const SizedBox(height: 40),
        _buttons(context, state),
        if (state.user != null) _dataCreate(state) else Container()
      ],
    );
  }
}

TextField _loginInputCreate(LoginModel state) {
  return TextField(
    controller: state.loginController,
    decoration: const InputDecoration(
        labelText: 'Login'
    ),
  );
}

TextField _passwordInputCreate(LoginModel state) {
  return TextField(
    controller: state.passwordController,
    decoration: const InputDecoration(
        labelText: 'Password'
    ),
  );
}

ButtonBar _buttons(BuildContext context, LoginModel state) {
  return ButtonBar(
    children: [
      MaterialButton(
        onPressed: () => state.phoneHandler(state.loginController.text),
        child: const Text('Confirm phone'),
      ),
      MaterialButton(
        onPressed: () => state.confirmHandler(context, state.loginController.text, state.passwordController.text),
        child: const Text('Confirm code'),
      )
    ],
  );
}

FutureBuilder _dataCreate(LoginModel state) {
  return FutureBuilder(
      future: state.user,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text('phone: ${snapshot.data!.phone}');
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const CircularProgressIndicator();
      }
  );
}