import 'package:firebase_auth/firebase_auth.dart';

abstract class IAuthRepository {
  Future<User?> getUser();
  Future getLogout();
  Future setEmailEndPasswordLogin({required String email,required String password});
  Future recoverPassword({required String email});
  Future getEmailEndPasswordLogin(
      {required String email, required String password});
  Future getGoogleLogin();
  Future getFacebookLogin();
}
