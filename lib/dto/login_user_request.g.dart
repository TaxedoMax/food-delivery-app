// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_user_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginUserRequest _$LoginUserRequestFromJson(Map<String, dynamic> json) =>
    LoginUserRequest(
      json['email'] as String,
      json['password'] as String,
    );

Map<String, dynamic> _$LoginUserRequestToJson(LoginUserRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
    };
