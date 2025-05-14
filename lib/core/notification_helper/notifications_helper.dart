import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;

class NotificationService {
  static Future<String> getAccessToken() async {
    final serviceAccountJson = {
      "type": "service_account",
      "project_id": "trend-perfume-push-notificatio",
      "private_key_id": "15e2ef961c1af05073596c83fa230a654c54c376",
      "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCuLjM2Ybt9hLXe\nIXOb3DtAmnWlyfJ0VyOX0ZTsOznvdw6YASbxpLjVjK1sKXIe3z+vEOYUbSqTy4SF\nv8E3dO1YR5E/5aJGxzuMV8RqCmGwWE/Zd61iLd5UZkf67V7SH2qXb19hoi6b0hWi\nBShr0rkVueDrT/kHX35G9Ip72cXeX+JSNciyZZNHjoBn/jFnIHZHc7wzUVHPwpUU\nQ8aK2Udoa6K3qoAEl5WCNG/83j0rWav4CjNv5Q7OXlKGcuRxMhf+6s2VWJ5VfUpf\nP/ji7N2bmJySnYuhijS1MdrbFD02cB4i3Xks6xRhWXFBNg4qxJSDYYyQX/ihUZ8Q\n+njjrO79AgMBAAECggEADlgFpaPUwdhs9bcBg0NWqdJOf/GqgsQuTTFYN0AFXGAM\nlp35rAqpogRsv6yGFl7CKtOUbvgyemtXJYCOE9gQN6XlI0Lw4y1DDSKpLSZftxr+\nsGT3pU8rsP2fTd3AYkNuDryAOVUWy4Q4fdg45PA8h7p/+EDkvCO0DXnT8bEUZ2SR\nD0e4mUOwBCZsa687s6yQrzbEYXsh6kpJVXyx12rguY//x7fn9z1h/K4puNZrNZ8L\ncArrIGfBpYxbWLjgwFOGcF3GLF8oD46f3y3lRCxLNwn7vN8xGyKQSzt656/Mb0Fd\nLHa6HQGbeich8YKtcfZ8605HwhrBqmgO87RO4InPzQKBgQDq/bfhXqZjpNhR20y+\nBmwRPDMUJHwEhDuOUDfKAfytIcY+WFt2IAN0iakKIfxZK5nzs/GV/dNyEbhPrk3W\nHp021AG9yKgI7UbWXdL/aBvD8X4fwXhS43wfcPKNtY9Uu4YiadrMVehniPIL+9ne\nN1SSlVDS5mowCp4ulmtws76XZwKBgQC9wLLYbwH1ob37OJwKLI/y1X0bNyCnx1Hr\nH2cjeO/y6KU7yEtmtr23qjlpyr+L3X1bbxoHro1pclHSOJEikS5WwtSjvRGEiMRm\n7FQlQgMTuC6QCNYCIXHEu9an7Ubb6FptqrCup69PpjzLpmFP8DcXtjnxMMoz7G1E\nkPuIaHB7+wKBgB1y4Flg+C8imG1hszNZMK/UQH50uAoE3EXQbb1mFFlKE0L65bNe\n/a/cFJANhEdUfH2a/lqSra3s5JEvwddkjMUzOmijPdOokKkKpweU723V1L18DG0u\nzv5NtEfoCedPfNbRNzdGSNK4ycSQslPz0Shxh+h2MbaFjh8+gIZmMCtfAoGARtW1\nregasihz9GFYls+12O/raQp2TUux//TUGsDdyi8g56VIyIo1XmfUUPLX+I1xa32Z\nGP8HWTLM6o4lV+McilTm7kz5SiGIN+fHLbVr0qOx9iDmSxtTDh8U7dE834DoqQHM\nPRbp8fDbxyZQM3g4CMkE7k3JXgLHc44v5+cc/psCgYA2qbdftu3a2bT8/Fw60xtD\nkF0fOa2hTJsG0ZMCJuHdT4CWaferVlUjXLisGIesF2+qjp4iQrQx0VL8TJ/t5eMH\niD0u1VYlrkc1BpdEL0nZZ0MvnaauapfeHgzam7/U4bgkbA/z7BNv4Zw7P1Py+VtG\nR93w7M4xN+QqUIC7xiodig==\n-----END PRIVATE KEY-----\n",
      "client_email": "push-notification@trend-perfume-push-notificatio.iam.gserviceaccount.com",
      "client_id": "104593089202656498605",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/push-notification%40trend-perfume-push-notificatio.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com"
    };
    List<String> scopes = [
      "https://www.googleapis.com/auth/userinfo.email",
      "https://www.googleapis.com/auth/firebase.database",
      "https://www.googleapis.com/auth/firebase.messaging"
    ];
    http.Client client = await auth.clientViaServiceAccount(
      auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
      scopes,
    );
    auth.AccessCredentials credentials =
        await auth.obtainAccessCredentialsViaServiceAccount(
            auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
            scopes,
            client);
    client.close();
    return credentials.accessToken.data;
  }
  static Future<void> sendNotificationToAllUsers(String title, String body) async {
    final String accessToken = await getAccessToken();
    String endpointFCM =
        'https://fcm.googleapis.com/v1/projects/trend-perfume-push-notificatio/messages:send';

    final Map<String, dynamic> message = {
      "message": {
        "topic": "all_users",  // إرسال إلى جميع المستخدمين في هذا الـ Topic
        "notification": {
          "title": title,
          "body": body
        },
        "data": {
          "route": "serviceScreen", // مسار التنقل في التطبيق عند فتح الإشعار
        }
      }
    };

    final http.Response response = await http.post(
      Uri.parse(endpointFCM),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      },
      body: jsonEncode(message),
    );

    if (response.statusCode == 200) {
      print('Notification sent to all users successfully');
    } else {
      print('Failed to send notification');
    }
  }



  static Future<void> sendNotification(
      String deviceToken, String title, String body) async {
    final String accessToken = await getAccessToken();
    String endpointFCM =
        'https://fcm.googleapis.com/v1/projects/trend-perfume-push-notificatio/messages:send';

    final Map<String, dynamic> message = {
      "message": {
        "token": deviceToken,
        "notification": {"title": title, "body": body},
        "data": {
          "route": "serviceScreen",
        }
      }
    };

    final http.Response response = await http.post(
      Uri.parse(endpointFCM),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      },
      body: jsonEncode(message),
    );

    if (response.statusCode == 200) {
      print('Notification sent successfully');
    } else {
      print('Failed to send notification');
    }
  }
}
