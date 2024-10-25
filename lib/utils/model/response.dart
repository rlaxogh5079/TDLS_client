class ResponseWithAccessToken {
  final String message;
  final int statusCode;
  String? detail;
  String? accessToken;

  ResponseWithAccessToken({
    required this.message,
    required this.statusCode,
    this.accessToken,
    this.detail,
  });

  factory ResponseWithAccessToken.fromJson(Map<String, dynamic> json) {
    if (json["status_code"] as int == 200) {
      return ResponseWithAccessToken(
          message: json["message"] as String,
          statusCode: json["status_code"] as int,
          accessToken: json["token"] as String);
    } else {
      return ResponseWithAccessToken(
          message: json["message"] as String,
          statusCode: json["status_code"] as int,
          detail: json["detail"] as String);
    }
  }
}
