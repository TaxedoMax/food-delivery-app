import 'package:antons_app/dto/login_user_request.dart';
import 'package:antons_app/repository/api_impl/api_repository.dart';
import 'package:antons_app/repository/user_repository.dart';
import 'package:dio/dio.dart';

import '../../dto/register_user_request.dart';

class UserRepositoryApi extends ApiRepository implements UserRepository{
  @override
  Future<String> signIn(String email, String password) async{
    Response response = await ApiRepository.dio.post('/users/login', data: LoginUserRequest(email, password).toJson());

    if(response.statusCode == 200){

      return 'OK';
    }

    else {
      return response.statusCode.toString();
      // TODO: different status codes
    }
  }

  @override
  Future<String> register(String login, String email, String password) async{
    Response response = await ApiRepository.dio.post('/users/register', data: RegisterUserRequest(login, email, password).toJson());

    if(response.statusCode == 200){
      return 'OK';
    }

    else {
      return response.statusCode.toString();
      // TODO: different status codes
    }
  }
}