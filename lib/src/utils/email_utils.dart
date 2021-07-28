import 'dart:math';

import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class EmailUtils {
  String username = "tuongdmse62978@fpt.edu.vn";
  String password = "Mmanhtuong1501";

  Future<Map<String, dynamic>> sendMail(String email) async {
    Map<String, dynamic> check = {'message': 0};
    final smtpServer = gmail(username, password);
    var rng = new Random();
    var code = rng.nextInt(900000) + 100000;
    final message = Message()
      ..from = Address(username, 'Expat Assistant')
      ..recipients.add(email)
      ..subject = 'Confirmation Code'
      ..text = 'Confirmation Code: $code';
    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
      check = {'message': code};
    } on MailerException catch (e) {
      print(e.toString());
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
    return check;
  }
}
