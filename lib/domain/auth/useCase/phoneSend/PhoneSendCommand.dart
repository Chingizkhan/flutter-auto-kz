import '../../../../data/auth/utils/config/AuthConfig.dart';

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