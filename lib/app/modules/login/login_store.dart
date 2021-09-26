import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:portfolio/app/shared/auth/auth_controller.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStoreBase with _$LoginStore;
abstract class _LoginStoreBase with Store {
 final AuthController _authController = Modular.get();

  @observable
  bool isLoading = false;
  @observable
  bool isPasswordVisible = true;

  @action
  void changePasswordVisible() {
    isPasswordVisible = !isPasswordVisible;
  }

  Map<String,String> fields = {};

 @action
 Future signIn() async {
   isLoading = true;
   await _authController.loginWithEmailAndPassword(
       email: fields["email"]!, password: fields["password"]!);
   isLoading = false;
 }

 @action
 Future signWithGoogle() async {
   await _authController.loginWithGoogle();
 }

 @action
 Future signWithFacebook() async {
   await _authController.loginWithFacebook();
 }


}