abstract class UserRepository{
  Future<String> signIn(String email, String password);
  Future<String> register(String login, String email, String password);
}