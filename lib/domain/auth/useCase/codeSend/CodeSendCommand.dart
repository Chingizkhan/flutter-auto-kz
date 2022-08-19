import '../../../../data/auth/utils/config/AuthConfig.dart';

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