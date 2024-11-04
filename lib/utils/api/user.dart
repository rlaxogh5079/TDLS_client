import 'package:client/utils/model/response.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const String host = "http://18.207.176.98:3000";

Future<ResponseWithAccessToken> login(String username, String password) async {
  Map data = {"username": username, "password": password};

  http.Response response =
      await http.post(Uri.parse("$host/user/login"), body: data);
  String responseBody = utf8.decoder.convert(response.bodyBytes);
  return ResponseWithAccessToken.fromJson(json.decode(responseBody));
}

Future<GeneralResponse> register(
    String username, String password, String nickname, String email) async {
  Map<String, String> data = {
    "user_id": username,
    "password": password,
    "nickname": nickname,
    "email": email
  };

  http.Response response = await http.put(
    Uri.parse("$host/user/signup"),
    headers: {"Content-Type": "application/json"},
    body: json.encode(data),
  );

  String responseBody = utf8.decoder.convert(response.bodyBytes);
  return GeneralResponse.fromJson(json.decode(responseBody));
}

Future<GeneralResponse> checkDuplicate(String option, String value) async {
  http.Response response = await http.post(
    Uri.parse("$host/user/check/duplicate?option=$option&value=$value"),
  );
  String responseBody = utf8.decoder.convert(response.bodyBytes);
  return GeneralResponse.fromJson(json.decode(responseBody));
}

Future<GeneralResponse> sendEmailRequest(String email) async {
  http.Response response = await http.post(
    Uri.parse("$host/user/email/send/verify_code?email=$email"),
  );
  String responseBody = utf8.decoder.convert(response.bodyBytes);
  return GeneralResponse.fromJson(json.decode(responseBody));
}

Future<GeneralResponse> verifyEmail(String email, String verifyCode) async {
  http.Response response = await http.post(
    Uri.parse("$host/user/email/verify?email=$email&verify_code=$verifyCode"),
  );
  String responseBody = utf8.decoder.convert(response.bodyBytes);
  return GeneralResponse.fromJson(json.decode(responseBody));
}
