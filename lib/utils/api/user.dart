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

Future<GeneralResponse> checkDuplicate(String option, String value) async {
  http.Response response = await http.post(
    Uri.parse("$host/user/check/duplicate?option=$option&value=$value"),
  );
  String responseBody = utf8.decoder.convert(response.bodyBytes);
  return GeneralResponse.fromJson(json.decode(responseBody));
}
