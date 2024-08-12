import 'package:antons_app/repository/api_impl/user_repository_api.dart';
import 'package:antons_app/repository/user_repository.dart';
import 'package:get_it/get_it.dart';

class AuthUseCase{
  bool _isAuthorized = false;

  final UserRepository _userRepository = GetIt.I.get<UserRepository>();

  Future<String> signIn(String email, String password) async {
    String status = await _userRepository.signIn(email, password);
    if(status == 'OK') {
      _isAuthorized = true;
    }
    else {
      _isAuthorized = false;
    }
    return status;
  }

  Future<String> register(String login, String email, String password) async{
    String status = await _userRepository.register(login, email, password);
    if(status == 'OK') {
      _isAuthorized = true;
    }
    else {
      _isAuthorized = false;
    }
    return status;
  }

  Future<bool> isAuthorized() async{
    // TODO: repository-check
    return _isAuthorized;
  }
}