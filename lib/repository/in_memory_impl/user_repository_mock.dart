import 'package:antons_app/repository/user_repository.dart';
import 'package:pair/pair.dart';

class UserRepositoryMock implements UserRepository{
  final List<Pair<String, String>> _users =
  [
    const Pair('admin', 'admin'),
    const Pair('max', '123456')
  ];

  @override
  Future<String> register(String login, String email, String password) async{
    await Future.delayed(const Duration(seconds: 1));
    for(var pair in _users){
      if(pair.key == login) return 'Login exist';
    }
    _users.add(Pair(login, password));
    return 'OK';
  }

  @override
  Future<String> signIn(String login, String password) async{
    await Future.delayed(const Duration(seconds: 1));
    var credentials = Pair(login, password);

    if(_users.contains(credentials)){
      return 'OK';
    }
    return 'ERROR';
  }
}