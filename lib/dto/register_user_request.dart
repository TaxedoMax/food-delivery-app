import 'package:json_annotation/json_annotation.dart';

part 'register_user_request.g.dart';

@JsonSerializable()
class RegisterUserRequest{
  @JsonKey(name: 'userName')
  final String login;
  
  @JsonKey(name: 'email')
  final String email;
  
  @JsonKey(name: 'password')
  final String password;

  RegisterUserRequest(this.login, this.email, this.password);

  factory RegisterUserRequest.fromJson(Map<String, dynamic> json) => _$RegisterUserRequestFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterUserRequestToJson(this);
}