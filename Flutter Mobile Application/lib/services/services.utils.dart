import 'package:dbcrypt/dbcrypt.dart';
import 'package:intl/intl.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:random_string/random_string.dart';

class Utils {
  static String hashedPassword(String password) {
    var hasedPassword = DBCrypt().hashpw(password, DBCrypt().gensalt());
    return hasedPassword;
  }

  static String password() {
    return randomAlphaNumeric(10);
  }

  static sendEmail(
      {String password, String subject, Map<String, dynamic> data}) async {
    String username = 'kusmakharpathak.sunway@gmail.com';
    String userPassword ='yahoo123@';

    // ignore: deprecated_member_use
    final smtpServer = gmail(username, userPassword);
    final message = Message()
      ..from = Address(username, 'E-Doctors')
      ..recipients.add(data['email'])
      ..subject = '$subject'
      ..html =
          "<!DOCTYPE html><html><head> <link href='https://fonts.googleapis.com/css?family=Poppins:200,300,400,500,600,700' rel='stylesheet'> <style> .primary { background: #17bebb; } .bg_white { background-image: linear-gradient(to right, rgba(100, 220, 225, 0.5), rgba(100, 250, 100, 0.1); } h2{ font-family: 'Poppins', sans-serif; color: #17bebb; margin-top: 0; font-weight: 400; } body { font-family: 'Poppins', sans-serif; font-weight: 400; font-size: 15px; line-height: 1.8; color: rgb(248, 250, 249); } a { color: #17bebb; } /*LOGO*/ </style></head><body width='100%' style='margin: 0; padding: 0 !important; mso-line-height-rule: exactly; background-color: #f1f1f1;'> <center style='width: 100%; background-color: #f1f1f1;'> <div style='display: none; font-size: 1px;max-height: 0px; max-width: 0px; opacity: 0; overflow: hidden; mso-hide: all; font-family: sans-serif;'> &zwnj;&nbsp;&zwnj;&nbsp;&zwnj;&nbsp;&zwnj;&nbsp;&zwnj;&nbsp;&zwnj;&nbsp;&zwnj;&nbsp;&zwnj;&nbsp;&zwnj;&nbsp;&zwnj;&nbsp;&zwnj;&nbsp;&zwnj;&nbsp;&zwnj;&nbsp;&zwnj;&nbsp;&zwnj;&nbsp;&zwnj;&nbsp;&zwnj;&nbsp;&zwnj;&nbsp; </div> <div style='max-width: 600px; margin: 0 auto;' class='email-container'> <!-- BEGIN BODY --> <table align='center' role='presentation' cellspacing='0' cellpadding='0' border='0' width='100%' style='margin: auto;'> <tr> <td valign='top' class='bg_white' style='padding: 1em 2.5em 0 2.5em;'> <table role='presentation' border='0' cellpadding='0' cellspacing='0' width='100%'> <tr> <td class='logo' style='text-align: center;'> <h2>E-Doctor Login Details</h2> </td> </tr> </table> </td> </tr><!-- end tr --> <tr> <td valign='middle' class='hero bg_white'> <div class='text'style=' text-align: center;'> <h3>Welcome to E-Doctor ChatBot Mobile application</h3> </div> <table role='presentation' border='0' cellpadding='0' cellspacing='0' width='100%'> <tr> <td style='text-align: left;'> Full Name </td> <td>:</td> <td> ${data['fName']} ${data['lName']} </td> </tr> <tr> <td style='text-align: left;'> E-mail </td> <td>:</td> <td> ${data['email']} </td> </tr> <tr> <td style='text-align: left;'> Password </td> <td>:</td> <td> $password </td> </tr> <tr> <td style='text-align: left;'> Age </td> <td>:</td> <td> ${data['age']} </td> </tr> </table> </td> </tr> </table> <table align='center' role='presentation' cellspacing='0' cellpadding='0' border='0' width='100%' style='margin: auto;'> <tr> <td valign='top' class='bg_white' style='padding: 1em 2.5em 0 2.5em;'> <table role='presentation' border='0' cellpadding='0' cellspacing='0' width='100%'> <tr> <td class='logo' style='text-align: center;'> </td> </tr> </table> </td> </tr></table> </div> </center></body></html>";
    try {
      await send(message, smtpServer);
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }

  static formatTimestamp( timestamp) {
    var format = new DateFormat("d MMM 'at' h:mm a");
    var date = new DateTime.fromMillisecondsSinceEpoch(timestamp);
    return format.format(date);
  }
}
