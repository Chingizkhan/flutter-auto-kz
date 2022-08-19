import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_projects/components/navigation/NavigationConfig.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/auth/model/Token.dart';
import '../../../data/auth/model/User.dart';
import '../../../data/auth/utils/config/AuthConfig.dart';
import 'package:http/http.dart' as http;
import '../../../domain/auth/useCase/codeSend/CodeSendCommand.dart';
import '../../../domain/auth/useCase/phoneSend/PhoneSendCommand.dart';

class LoginModel extends ChangeNotifier {
  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  late SharedPreferences prefs;
  Future<User>? user = null;

  Future<SharedPreferences> initSharedPrefs() async =>
      await SharedPreferences.getInstance();

  Future<http.Response> phoneHandler(String phone) async {
    initSharedPrefs();

    var url = Uri.parse(AuthConfig.phoneUrl);
    final response = await http.post(url, body: jsonEncode(PhoneSendCommand(phone)));

    if (response.statusCode == 200) {
      notifyListeners();
    } else {
      throw Exception('Failed to login ${response.statusCode} ${response.body}');
    }

    return response;
  }

  Future<User> confirmHandler(BuildContext context, String phone, String code) async {

    var url = Uri.parse(AuthConfig.codeUrl);
    final response = await http.post(
        url,
        body: jsonEncode(CodeSendCommand(phone, code))
    );

    final token = _extractTokens(response);

    _saveTokens(token.access, token.refresh);

    if (response.statusCode == 200) {
      final user = User.fromJson(jsonDecode(response.body));
      this.user = Future(() => user);
      notifyListeners();
      Navigator.pushNamed(context, NavigationConfig.main);
      return user;
    } else {
      throw Exception('Failed to login ${response.body}');
    }
  }

  Token _extractTokens(http.Response response) {
    final accessToken = response.headers[AuthConfig.accessToken]!;
    final refreshToken = response.headers[AuthConfig.refreshToken]!;

    return Token(accessToken, refreshToken);
  }

  void _saveTokens(String accessToken, String refreshToken) {
    prefs.setString(AuthConfig.accessToken, accessToken);
    prefs.setString(AuthConfig.refreshToken, refreshToken);
  }

}
