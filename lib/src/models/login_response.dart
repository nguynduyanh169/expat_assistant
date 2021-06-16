import 'dart:convert';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    this.token,
    this.type,
    this.email,
  });

  String token;
  String type;
  String email;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        token: json["token"],
        type: json["type"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "type": type,
        "email": email,
      };
}
