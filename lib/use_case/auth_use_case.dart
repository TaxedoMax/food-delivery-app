import 'package:antons_app/repository/api_emulator.dart';

class AuthUseCase{
  Future<String> login(String login, String password) async {
    String status = await APIEmulator.login(login, password);
    return status;
  }

  Future<String> register(String login, String email, String password) async{
    String status = await APIEmulator.register(login, email, password);
    return status;
  }
}