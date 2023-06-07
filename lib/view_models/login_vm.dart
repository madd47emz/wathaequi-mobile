import 'package:wathaequi/repositories/login_repo.dart';

class LoginViewModel{
  late LoginRepo _loginRepo;
  Future<String> login(String nin,String password) async{
    _loginRepo = LoginRepo();
    return await _loginRepo.login(nin, password);
  }
}