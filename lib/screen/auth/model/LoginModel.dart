import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/auth/model/User.dart';
import '../../../data/auth/utils/config/AuthConfig.dart';
import 'package:http/http.dart' as http;

class LoginModel extends ChangeNotifier {
  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  late SharedPreferences prefs;
  Future<User>? user = null;

  // void initial() async {
  //   prefs = await SharedPreferences.getInstance();
  //   print('access token: ${prefs.getString(AuthConfig.accessToken)}');
  //   print('refresh token: ${prefs.getString(AuthConfig.accessToken)}');
  // }

  Future<SharedPreferences> initSharedPrefs() async {
    prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  Future<http.Response> phoneHandler(String phone) async {
    initSharedPrefs();

    var url = Uri.parse(AuthConfig.phoneUrl);
    final response = await http.post(url, body: jsonEncode(PhoneSendCommand(phone)));

    if (response.statusCode == 200) {
      // print('success phone');
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

    final token = extractTokens(response);

    saveTokens(token.access, token.refresh);

    if (response.statusCode == 200) {
      // print('success code');
      final user = User.fromJson(jsonDecode(response.body));
      // print('User: ${user.toString()}');
      this.user = Future(() => user);
      notifyListeners();
      Navigator.pushNamed(context, '/main');
      return user;
    } else {
      throw Exception('Failed to login ${response.body}');
    }
  }

  Token extractTokens(http.Response response) {
    final accessToken = response.headers[AuthConfig.accessToken]!;
    final refreshToken = response.headers[AuthConfig.refreshToken]!;

    return Token(accessToken, refreshToken);
  }

  void saveTokens(String accessToken, String refreshToken) {
    prefs.setString(AuthConfig.accessToken, accessToken);
    prefs.setString(AuthConfig.refreshToken, refreshToken);
  }

}

class Token {
  final String access;
  final String refresh;

  Token(this.access, this.refresh);
}

class PhoneSendCommand {
  final String phone;
  final String domain;

  PhoneSendCommand(this.phone) : domain = AuthConfig.domain;

  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'domain': domain,
    };
  }
}

class CodeSendCommand {
  final String phone;
  final String code;
  final String domain;

  CodeSendCommand(this.phone, this.code) : domain = AuthConfig.domain;

  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'code': code,
      'domain': domain,
    };
  }
}

