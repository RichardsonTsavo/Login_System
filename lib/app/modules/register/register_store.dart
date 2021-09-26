import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:portfolio/app/shared/auth/auth_controller.dart';

part 'register_store.g.dart';

class RegisterStore = _RegisterStoreBase with _$RegisterStore;
abstract class _RegisterStoreBase with Store {
  final AuthController _authController = Modular.get();
  @observable
  bool isLoading = false;
  @observable
  bool isPasswordVisible = true;

  @action
  void changePasswordVisible() {
    isPasswordVisible = !isPasswordVisible;
  }

  String email = "";
  @observable
  String password = "";

  @action
  void setPassword(value){
    password = value;
  }

  @action
  Future signUp() async {
    isLoading = true;
    await _authController.registerWithEmailAndPassword(
        email: email, password: password);
    isLoading = false;
  }
}